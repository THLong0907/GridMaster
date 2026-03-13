import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:grid_master/core/utils/firebase_helper.dart';
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

  /// Safe factory — NEVER throws, even if doc is deleted or data is malformed
  factory PvpMatch.fromFirestore(DocumentSnapshot doc) {
    final rawData = doc.data();
    if (rawData == null || rawData is! Map<String, dynamic>) {
      return PvpMatch(
        id: doc.id,
        player1Id: '',
        player1Name: 'Unknown',
        player1Score: 0,
        player2Score: 0,
        seed: 0,
        status: 'deleted',
      );
    }
    final data = rawData;
    return PvpMatch(
      id: doc.id,
      player1Id: (data['player1Id'] as String?) ?? '',
      player2Id: data['player2Id'] as String?,
      player1Name: (data['player1Name'] as String?) ?? 'Unknown',
      player2Name: data['player2Name'] as String?,
      player1Score: (data['player1Score'] as num?)?.toInt() ?? 0,
      player2Score: (data['player2Score'] as num?)?.toInt() ?? 0,
      seed: (data['seed'] as num?)?.toInt() ?? 0,
      status: (data['status'] as String?) ?? 'waiting',
      startTime: (data['startTime'] as Timestamp?)?.toDate(),
    );
  }
}

class PvpService {
  PvpService._();
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Each session gets a unique device ID
  static String? _sessionDeviceId;
  static String _getDeviceId() {
    _sessionDeviceId ??=
        '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(999999)}';
    return _sessionDeviceId!;
  }

  /// Whether THIS client is Player1 (created the match)
  static bool isPlayer1 = false;

  /// Cancel flag — set to true to abort matchmaking
  static bool _cancelled = false;

  /// Active stream subscription for cleanup
  static StreamSubscription? _streamSub;

  /// Active polling timer for cleanup
  static Timer? _pollingTimer;

  // ──────────────────────────────────────────────
  // PUBLIC API
  // ──────────────────────────────────────────────

  /// Find or create a match. This method blocks until:
  ///   (a) an opponent is found (returns active PvpMatch), OR
  ///   (b) 60 seconds pass (throws 'timeout'), OR
  ///   (c) cancelMatchmaking() is called (throws 'cancelled')
  ///
  /// game_screen just needs:  final match = await PvpService.findMatch();
  static Future<PvpMatch> findMatch() async {
    if (!FirebaseHelper.isAvailable) {
      throw Exception('No internet connection. PvP requires online.');
    }
    final uid = AuthService.uid;
    if (uid == null) throw Exception('User not logged in');
    final name = await AuthService.getDisplayName();
    final deviceId = _getDeviceId();

    _cancelled = false;
    _streamSub?.cancel();
    _pollingTimer?.cancel();

    debugPrint('[PVP] ===== findMatch START =====');
    debugPrint('[PVP] UID: $uid, Name: $name, DeviceID: $deviceId');

    // Step 1: Clean stale matches
    await _cleanStaleMatches();

    // Step 2: Try to join an existing match immediately
    final joined = await _tryJoinExistingMatch(uid, name, deviceId);
    if (joined != null) {
      isPlayer1 = false;
      return joined;
    }

    // Step 3: Create our own match and wait for resolution
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

    debugPrint('[PVP] ===== CREATED match ${ref.id} =====');

    // Step 4: Wait for match to become active using BOTH paths:
    //   Path A: stream detects opponent joined OUR match
    //   Path B: polling finds and joins a DIFFERENT match
    final completer = Completer<PvpMatch>();

    // TIMEOUT — 60 seconds
    final timeout = Timer(const Duration(seconds: 60), () {
      if (!completer.isCompleted) {
        debugPrint('[PVP] Timeout after 60s');
        completer.completeError('timeout');
      }
    });

    // PATH A: Realtime stream — someone joins our match
    _streamSub = _firestore
        .collection('matches')
        .doc(ref.id)
        .snapshots()
        .where((doc) => doc.exists)
        .listen((doc) {
      final data = doc.data();
      if (data != null && data['status'] == 'active' && !completer.isCompleted) {
        debugPrint('[PVP] PATH A: Our match was joined! id=${ref.id}');
        isPlayer1 = true;
        completer.complete(PvpMatch.fromFirestore(doc));
      }
    });

    // PATH B: Polling — we find and join someone else's match
    _pollingTimer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (completer.isCompleted || _cancelled) {
        timer.cancel();
        return;
      }

      debugPrint('[PVP] Polling... checking for other matches');

      final found = await _tryJoinExistingMatch(uid, name, deviceId);
      if (found != null && !completer.isCompleted) {
        timer.cancel();
        // Delete our own waiting match
        try {
          await _firestore.collection('matches').doc(ref.id).delete();
          debugPrint('[PVP] Deleted our waiting match ${ref.id}');
        } catch (_) {}
        isPlayer1 = false;
        debugPrint('[PVP] PATH B: Joined different match ${found.id}');
        completer.complete(found);
      }
    });

    // AWAIT resolution
    try {
      final result = await completer.future;
      timeout.cancel();
      _streamSub?.cancel();
      _pollingTimer?.cancel();
      debugPrint('[PVP] ===== MATCH READY: ${result.id}, isPlayer1=$isPlayer1 =====');
      return result;
    } catch (e) {
      timeout.cancel();
      _streamSub?.cancel();
      _pollingTimer?.cancel();
      // Clean up our waiting match on timeout/cancel
      try {
        await _firestore.collection('matches').doc(ref.id).delete();
        debugPrint('[PVP] Cleaned up match ${ref.id} after $e');
      } catch (_) {}
      rethrow;
    }
  }

  /// Cancel active matchmaking (call when user leaves the screen)
  static void cancelMatchmaking() {
    _cancelled = true;
    _streamSub?.cancel();
    _streamSub = null;
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  /// Listen to match updates — only emits for existing documents
  static Stream<PvpMatch> streamMatch(String matchId) {
    return _firestore
        .collection('matches')
        .doc(matchId)
        .snapshots()
        .where((doc) => doc.exists)
        .map((doc) => PvpMatch.fromFirestore(doc));
  }

  /// Update my score in the match — silently ignores errors
  static Future<void> updateMyScore(
    String matchId,
    int score,
    bool amPlayer1,
  ) async {
    try {
      final doc = await _firestore.collection('matches').doc(matchId).get();
      if (!doc.exists) return;
      await _firestore.collection('matches').doc(matchId).update({
        amPlayer1 ? 'player1Score' : 'player2Score': score,
      });
    } catch (e) {
      debugPrint('[PVP] updateMyScore error: $e');
    }
  }

  /// Set match to finished
  static Future<void> finishMatch(String matchId) async {
    try {
      final doc = await _firestore.collection('matches').doc(matchId).get();
      if (!doc.exists) return;
      await _firestore.collection('matches').doc(matchId).update({
        'status': 'finished',
      });
    } catch (e) {
      debugPrint('[PVP] finishMatch error: $e');
    }
  }

  /// Cancel/delete a waiting match
  static Future<void> cancelMatch(String matchId) async {
    try {
      final doc = await _firestore.collection('matches').doc(matchId).get();
      if (doc.exists) {
        final data = doc.data();
        if (data != null && data['status'] == 'waiting') {
          await doc.reference.delete();
          debugPrint('[PVP] Cancelled match $matchId');
        }
      }
    } catch (e) {
      debugPrint('[PVP] cancelMatch error: $e');
    }
  }

  // ──────────────────────────────────────────────
  // PRIVATE HELPERS
  // ──────────────────────────────────────────────

  static Future<void> _cleanStaleMatches() async {
    try {
      final waitingMatches = await _firestore
          .collection('matches')
          .where('status', isEqualTo: 'waiting')
          .get();
      for (final doc in waitingMatches.docs) {
        try {
          final data = doc.data();
          final createdAt = (data['createdAt'] as Timestamp?)?.toDate();
          if (createdAt != null &&
              DateTime.now().difference(createdAt).inMinutes > 2) {
            debugPrint('[PVP] Cleaning stale match ${doc.id}');
            await doc.reference.delete();
          }
        } catch (e) {
          debugPrint('[PVP] Clean error ${doc.id}: $e');
        }
      }
    } catch (e) {
      debugPrint('[PVP] cleanStaleMatches error: $e');
    }
  }

  static Future<PvpMatch?> _tryJoinExistingMatch(
      String uid, String name, String deviceId) async {
    try {
      final waitingMatches = await _firestore
          .collection('matches')
          .where('status', isEqualTo: 'waiting')
          .get();

      debugPrint('[PVP] Found ${waitingMatches.docs.length} waiting match(es)');

      for (final doc in waitingMatches.docs) {
        final data = doc.data();
        final matchDeviceId = (data['deviceId'] as String?) ?? '';

        if (matchDeviceId == deviceId) {
          debugPrint('[PVP] -> Skip own match ${doc.id}');
          continue;
        }

        final createdAt = (data['createdAt'] as Timestamp?)?.toDate();
        if (createdAt != null &&
            DateTime.now().difference(createdAt).inMinutes > 2) {
          continue;
        }

        debugPrint('[PVP] -> Trying to JOIN ${doc.id}');
        try {
          final result =
              await _firestore.runTransaction<PvpMatch?>((tx) async {
            final freshDoc = await tx.get(doc.reference);
            if (!freshDoc.exists) return null;
            final freshData = freshDoc.data();
            if (freshData == null) return null;
            if (freshData['status'] != 'waiting') return null;

            tx.update(doc.reference, {
              'player2Id': uid,
              'player2Name': name,
              'player2DeviceId': deviceId,
              'status': 'active',
              'startTime': FieldValue.serverTimestamp(),
            });

            return PvpMatch(
              id: doc.id,
              player1Id: (freshData['player1Id'] as String?) ?? '',
              player2Id: uid,
              player1Name:
                  (freshData['player1Name'] as String?) ?? 'Unknown',
              player2Name: name,
              player1Score: 0,
              player2Score: 0,
              seed: (freshData['seed'] as num?)?.toInt() ?? 0,
              status: 'active',
              startTime: DateTime.now(),
            );
          });

          if (result != null) {
            debugPrint('[PVP] ===== JOINED match ${doc.id}! =====');
            return result;
          }
        } catch (e) {
          debugPrint('[PVP] Transaction failed ${doc.id}: $e');
        }
      }
    } catch (e) {
      debugPrint('[PVP] _tryJoinExistingMatch error: $e');
    }
    return null;
  }
}
