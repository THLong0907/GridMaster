import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:grid_master/features/game/domain/models/game_mode.dart';
import 'package:grid_master/core/utils/firebase_helper.dart';
import 'auth_service.dart';

/// Service to manage online leaderboards and high scores.
/// All Firestore calls are wrapped with try-catch for offline resilience.
class LeaderboardService {
  LeaderboardService._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Upload a high score for a specific mode (only if higher than existing)
  static Future<void> uploadScore(int score, GameMode mode) async {
    if (!FirebaseHelper.isAvailable) return;

    try {
      final uid = AuthService.uid;
      if (uid == null) return;

      final name = await AuthService.getDisplayName();

      // Reference to the score document for this user in this mode
      final scoreRef = _firestore
          .collection('leaderboards')
          .doc(mode.name)
          .collection('scores')
          .doc(uid);

      // Use transaction to only update if score is higher
      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(scoreRef);
        final currentScore = snapshot.exists
            ? (snapshot.data()?['score'] as int? ?? 0)
            : 0;

        // Only write if new score is higher
        if (score > currentScore) {
          transaction.set(scoreRef, {
            'score': score,
            'name': name,
            'timestamp': FieldValue.serverTimestamp(),
            'uid': uid,
          }, SetOptions(merge: true));
        }
      });
    } catch (e) {
      debugPrint('[Leaderboard] Upload failed (offline?): $e');
    }
  }

  /// Fetch top 10 players for a mode
  static Stream<QuerySnapshot> getLeaderboardStream(GameMode mode) {
    return _firestore
        .collection('leaderboards')
        .doc(mode.name)
        .collection('scores')
        .orderBy('score', descending: true)
        .limit(10)
        .snapshots();
  }

  /// Check if the player is currently Top 1 for a mode
  static Future<bool> isTop1(GameMode mode) async {
    if (!FirebaseHelper.isAvailable) return false;

    try {
      final uid = AuthService.uid;
      if (uid == null) return false;

      final query = await _firestore
          .collection('leaderboards')
          .doc(mode.name)
          .collection('scores')
          .orderBy('score', descending: true)
          .limit(1)
          .get();

      if (query.docs.isEmpty) return true; // You are the first!

      return query.docs.first.id == uid;
    } catch (e) {
      debugPrint('[Leaderboard] isTop1 failed (offline?): $e');
      return false;
    }
  }

  /// Get the score needed to take Top 1
  static Future<int> getTopScore(GameMode mode) async {
    if (!FirebaseHelper.isAvailable) return 0;

    try {
      final query = await _firestore
          .collection('leaderboards')
          .doc(mode.name)
          .collection('scores')
          .orderBy('score', descending: true)
          .limit(1)
          .get();

      if (query.docs.isEmpty) return 0;
      return query.docs.first.get('score') as int;
    } catch (e) {
      debugPrint('[Leaderboard] getTopScore failed (offline?): $e');
      return 0;
    }
  }
}
