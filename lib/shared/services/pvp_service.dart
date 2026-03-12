import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'auth_service.dart';

class PvpMatch {
  final String id;
  final String player1Id;
  final String? player2Id;
  final String player1Name;
  final String? player2Name;
  final int player1Score;
  final int player2Score;
  final int seed;
  final String status;
  final DateTime? startTime;

  PvpMatch({
    required this.id,
    required this.player1Id,
    this.player2Id,
    required this.player1Name,
    this.player2Name,
    required this.player1Score,
    required this.player2Score,
    required this.seed,
    required this.status,
    this.startTime,
  });

  factory PvpMatch.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PvpMatch(
      id: doc.id,
      player1Id: data['player1Id'] ?? '',
      player2Id: data['player2Id'],
      player1Name: data['player1Name'] ?? 'Unknown',
      player2Name: data['player2Name'],
      player1Score: data['player1Score'] ?? 0,
      player2Score: data['player2Score'] ?? 0,
      seed: data['seed'] ?? 0,
      status: data['status'] ?? 'waiting',
      startTime: (data['startTime'] as Timestamp?)?.toDate(),
    );
  }
}

class PvpService {
  PvpService._();
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Each session gets a unique device ID so the same Firebase user
  /// on different devices can still match with each other.
  static String? _sessionDeviceId;
  static String _getDeviceId() {
    _sessionDeviceId ??=
        '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(999999)}';
    return _sessionDeviceId!;
  }

  /// Track the match ID we created this session (so we don't join our OWN match)
  static String? myCreatedMatchId;

  /// Active polling timer (cancelled when match found or user leaves)
  static Timer? _pollingTimer;

  /// Completer for the polling flow
  static Completer<PvpMatch>? _matchCompleter;

  /// Clean up stale matches older than 2 minutes
  static Future<void> _cleanStaleMatches() async {
    try {
      final waitingMatches = await _firestore
          .collection('matches')
          .where('status', isEqualTo: 'waiting')
          .get();

      for (final doc in waitingMatches.docs) {
        final data = doc.data();
        final createdAt = (data['createdAt'] as Timestamp?)?.toDate();
        if (createdAt != null) {
          final age = DateTime.now().difference(createdAt);
          if (age.inMinutes > 2) {
            debugPrint('[PVP] Cleaning stale match ${doc.id} (${age.inSeconds}s old)');
            try {
              await doc.reference.delete();
            } catch (_) {}
          }
        }
      }
    } catch (e) {
      debugPrint('[PVP] cleanStaleMatches error: $e');
    }
  }

  /// Try to join an existing waiting match using a Firestore transaction
  /// to prevent two players from joining the same match simultaneously.
  static Future<PvpMatch?> _tryJoinExistingMatch(
      String uid, String name, String deviceId) async {
    try {
      final waitingMatches = await _firestore
          .collection('matches')
          .where('status', isEqualTo: 'waiting')
          .get();

      debugPrint(
          '[PVP] Found ${waitingMatches.docs.length} waiting match(es)');

      for (final doc in waitingMatches.docs) {
        final data = doc.data();
        final matchDeviceId = data['deviceId'] ?? '';

        // Skip our own match
        if (matchDeviceId == deviceId) {
          debugPrint('[PVP] -> Skipping match ${doc.id} (own device)');
          continue;
        }

        // Skip stale matches
        final createdAt = (data['createdAt'] as Timestamp?)?.toDate();
        if (createdAt != null &&
            DateTime.now().difference(createdAt).inMinutes > 2) {
          debugPrint('[PVP] -> Skipping stale match ${doc.id}');
          continue;
        }

        // Try to join with a transaction (atomic — prevents race condition)
        debugPrint('[PVP] -> Attempting to JOIN match ${doc.id} via transaction');
        try {
          final result =
              await _firestore.runTransaction<PvpMatch?>((transaction) async {
            final freshDoc = await transaction.get(doc.reference);
            if (!freshDoc.exists) return null;

            final freshData = freshDoc.data() as Map<String, dynamic>;

            // Double-check it's still 'waiting' inside the transaction
            if (freshData['status'] != 'waiting') {
              debugPrint('[PVP] -> Match ${doc.id} no longer waiting');
              return null;
            }

            // Join the match!
            transaction.update(doc.reference, {
              'player2Id': uid,
              'player2Name': name,
              'player2DeviceId': deviceId,
              'status': 'active',
              'startTime': FieldValue.serverTimestamp(),
            });

            // Return a match object with updated data
            return PvpMatch(
              id: doc.id,
              player1Id: freshData['player1Id'] ?? '',
              player2Id: uid,
              player1Name: freshData['player1Name'] ?? 'Unknown',
              player2Name: name,
              player1Score: 0,
              player2Score: 0,
              seed: freshData['seed'] ?? 0,
              status: 'active',
              startTime: DateTime.now(),
            );
          });

          if (result != null) {
            debugPrint('[PVP] ===== JOINED match ${doc.id}! =====');
            return result;
          }
        } catch (e) {
          debugPrint('[PVP] -> Transaction failed for ${doc.id}: $e');
          continue;
        }
      }
    } catch (e) {
      debugPrint('[PVP] _tryJoinExistingMatch error: $e');
    }
    return null;
  }

  /// Find or create a match.
  /// This is the main entry point. Flow:
  /// 1. Clean up stale matches
  /// 2. Try to join an existing waiting match (with transaction)
  /// 3. If no match available → create one + start polling to keep retrying
  static Future<PvpMatch> findMatch() async {
    final uid = AuthService.uid;
    if (uid == null) throw Exception('User not logged in');
    final name = await AuthService.getDisplayName();
    final deviceId = _getDeviceId();

    debugPrint('[PVP] ===== findMatch START =====');
    debugPrint('[PVP] UID: $uid, Name: $name, DeviceID: $deviceId');

    // Cancel any previous polling
    cancelPolling();
    myCreatedMatchId = null;

    // Step 1: Clean stale matches
    await _cleanStaleMatches();

    // Step 2: Try to join an existing match
    final joined = await _tryJoinExistingMatch(uid, name, deviceId);
    if (joined != null) {
      return joined;
    }

    // Step 3: No match found → create a new one
    debugPrint('[PVP] No match to join, creating new one...');
    final seed = Random().nextInt(1000000);
    final ref = await _firestore.collection('matches').add({
      'player1Id': uid,
      'player1Name': name,
      'deviceId': deviceId,
      'player2Id': null,
      'player2Name': null,
      'player1Score': 0,
      'player2Score': 0,
      'seed': seed,
      'status': 'waiting',
      'createdAt': FieldValue.serverTimestamp(),
    });

    myCreatedMatchId = ref.id;
    debugPrint('[PVP] ===== CREATED match ${ref.id}. Starting polling... =====');

    // Step 4: Start a polling timer that keeps trying to join OTHER matches
    // This handles the race condition: if both clients created matches,
    // one of them will eventually find and join the other's match.
    _matchCompleter = Completer<PvpMatch>();

    _pollingTimer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (_matchCompleter == null || _matchCompleter!.isCompleted) {
        timer.cancel();
        return;
      }

      debugPrint('[PVP] Polling... trying to find another match to join');

      // Check if our own match was already joined (someone else found us)
      try {
        final ourDoc = await _firestore.collection('matches').doc(ref.id).get();
        if (ourDoc.exists) {
          final data = ourDoc.data()!;
          if (data['status'] == 'active') {
            debugPrint('[PVP] Our match was joined by someone else!');
            timer.cancel();
            if (!_matchCompleter!.isCompleted) {
              _matchCompleter!.complete(PvpMatch.fromFirestore(ourDoc));
            }
            return;
          }
        }
      } catch (e) {
        debugPrint('[PVP] Poll check own match error: $e');
      }

      // Try to join someone else's match
      final found = await _tryJoinExistingMatch(uid, name, deviceId);
      if (found != null) {
        timer.cancel();
        // Delete our own waiting match since we joined another
        try {
          await _firestore.collection('matches').doc(ref.id).delete();
          debugPrint('[PVP] Deleted our own waiting match ${ref.id}');
        } catch (_) {}
        if (!_matchCompleter!.isCompleted) {
          // We joined someone else's match, so we are NOT player1
          myCreatedMatchId = null;
          _matchCompleter!.complete(found);
        }
      }
    });

    // Return our created match immediately — game_screen will use streamMatch
    // to detect when it goes active (either via polling join or opponent joining)
    final created = PvpMatch.fromFirestore(await ref.get());
    return created;
  }

  /// Cancel polling (call when leaving matchmaking or match found)
  static void cancelPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
    if (_matchCompleter != null && !_matchCompleter!.isCompleted) {
      _matchCompleter!.completeError('Cancelled');
    }
    _matchCompleter = null;
  }

  /// Listen to match updates
  static Stream<PvpMatch> streamMatch(String matchId) {
    return _firestore
        .collection('matches')
        .doc(matchId)
        .snapshots()
        .map((doc) => PvpMatch.fromFirestore(doc));
  }

  /// Update my score in the match
  static Future<void> updateMyScore(
    String matchId,
    int score,
    bool isPlayer1,
  ) async {
    try {
      await _firestore.collection('matches').doc(matchId).update({
        isPlayer1 ? 'player1Score' : 'player2Score': score,
      });
    } catch (e) {
      debugPrint('[PVP] updateMyScore error: $e');
    }
  }

  /// Set match to finished
  static Future<void> finishMatch(String matchId) async {
    try {
      await _firestore.collection('matches').doc(matchId).update({
        'status': 'finished',
      });
    } catch (e) {
      debugPrint('[PVP] finishMatch error: $e');
    }
  }

  /// Cancel/delete a waiting match (user left matchmaking screen)
  static Future<void> cancelMatch(String matchId) async {
    try {
      final doc = await _firestore.collection('matches').doc(matchId).get();
      if (doc.exists) {
        final data = doc.data()!;
        if (data['status'] == 'waiting') {
          await doc.reference.delete();
          debugPrint('[PVP] Cancelled and deleted match $matchId');
        }
      }
    } catch (e) {
      debugPrint('[PVP] cancelMatch error: $e');
    }
  }
}
