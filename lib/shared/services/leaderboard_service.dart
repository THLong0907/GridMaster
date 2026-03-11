import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grid_master/features/game/domain/models/game_mode.dart';
import 'auth_service.dart';

/// Service to manage online leaderboards and high scores
class LeaderboardService {
  LeaderboardService._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Upload a high score for a specific mode (only if higher than existing)
  static Future<void> uploadScore(int score, GameMode mode) async {
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
  }

  /// Get the score needed to take Top 1
  static Future<int> getTopScore(GameMode mode) async {
    final query = await _firestore
        .collection('leaderboards')
        .doc(mode.name)
        .collection('scores')
        .orderBy('score', descending: true)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return 0;
    return query.docs.first.get('score') as int;
  }
}
