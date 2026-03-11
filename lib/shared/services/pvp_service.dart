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
    _sessionDeviceId ??= '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(999999)}';
    return _sessionDeviceId!;
  }

  /// Track the match ID we created this session (so we don't join our OWN match)
  static String? myCreatedMatchId;

  /// Find or create a match
  static Future<PvpMatch> findMatch() async {
    final uid = AuthService.uid;
    if (uid == null) throw Exception('User not logged in');
    final name = await AuthService.getDisplayName();
    final deviceId = _getDeviceId();

    debugPrint('[PVP] ===== findMatch START =====');
    debugPrint('[PVP] UID: $uid, Name: $name, DeviceID: $deviceId');

    // Reset tracked match
    myCreatedMatchId = null;

    // 1. Try to find ANY waiting match
    try {
      final waitingMatches = await _firestore
          .collection('matches')
          .where('status', isEqualTo: 'waiting')
          .get();

      debugPrint('[PVP] Found ${waitingMatches.docs.length} waiting match(es)');

      for (final doc in waitingMatches.docs) {
        final data = doc.data();
        final matchDeviceId = data['deviceId'] ?? '';
        final matchPlayerName = data['player1Name'] ?? 'Unknown';

        debugPrint('[PVP] Match ${doc.id}: deviceId=$matchDeviceId, name=$matchPlayerName');

        // Skip if this match was created by THIS device session
        if (matchDeviceId == deviceId) {
          debugPrint('[PVP] -> Skipping (same device session)');
          continue;
        }

        // Check if match is stale (older than 2 minutes)
        final createdAt = (data['createdAt'] as Timestamp?)?.toDate();
        if (createdAt != null) {
          final age = DateTime.now().difference(createdAt);
          if (age.inMinutes > 2) {
            debugPrint('[PVP] -> Deleting stale match (${age.inSeconds}s old)');
            try { await doc.reference.delete(); } catch (_) {}
            continue;
          }
        }

        // Found a valid match — join it!
        debugPrint('[PVP] -> JOINING match ${doc.id}!');
        try {
          await doc.reference.update({
            'player2Id': uid,
            'player2Name': name,
            'player2DeviceId': deviceId,
            'status': 'active',
            'startTime': FieldValue.serverTimestamp(),
          });
          final joined = PvpMatch.fromFirestore(await doc.reference.get());
          debugPrint('[PVP] ===== JOINED! Rival: $matchPlayerName =====');
          return joined;
        } catch (e) {
          debugPrint('[PVP] -> Join failed: $e');
          continue;
        }
      }
    } catch (e) {
      debugPrint('[PVP] Query error: $e');
    }

    // 2. No valid match found → create a new one
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
    final created = PvpMatch.fromFirestore(await ref.get());
    debugPrint('[PVP] ===== CREATED match ${ref.id}. Waiting... =====');
    return created;
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
}
