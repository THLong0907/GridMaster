import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grid_master/features/game/domain/models/game_mode.dart';
import 'auth_service.dart';

/// Service to manage online leaderboards and high scores
class LeaderboardService {
  LeaderboardService._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Upload a high score for a specific mode
  static Future<void> uploadScore(int score, GameMode mode) async {
    final uid = AuthService.uid;
    if (uid == null) return;

    final name = await AuthService.getDisplayName();

    final batch = _firestore.batch();

    // 1. Reference to the score document for this user in this mode
    final scoreRef = _firestore
        .collection('leaderboards')
        .doc(mode.name)
        .collection('scores')
        .doc(uid);

    // 2. Set/Update score if it's higher
    batch.set(scoreRef, {
      'score': score,
      'name': name,
      'timestamp': FieldValue.serverTimestamp(),
      'uid': uid,
    }, SetOptions(merge: true));

    // 3. Optional: Global stats update
    // (Could be used to track total crown count etc.)

    await batch.commit();
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
