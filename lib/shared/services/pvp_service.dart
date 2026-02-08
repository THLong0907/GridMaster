import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      player1Id: data['player1Id'],
      player2Id: data['player2Id'],
      player1Name: data['player1Name'],
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

  /// Find or create a match
  static Future<PvpMatch> findMatch() async {
    final uid = AuthService.uid;
    if (uid == null) throw Exception('User not logged in');
    final name = await AuthService.getDisplayName();

    // 1. Try to find a waiting match
    final waitingMatches = await _firestore
        .collection('matches')
        .where('status', isEqualTo: 'waiting')
        .limit(1)
        .get();

    if (waitingMatches.docs.isNotEmpty) {
      final doc = waitingMatches.docs.first;
      final match = PvpMatch.fromFirestore(doc);

      // Don't join your own match
      if (match.player1Id != uid) {
        await doc.reference.update({
          'player2Id': uid,
          'player2Name': name,
          'status': 'active',
          'startTime': FieldValue.serverTimestamp(),
        });
        return PvpMatch.fromFirestore(await doc.reference.get());
      }
    }

    // 2. No match found, create one
    final seed = Random().nextInt(1000000);
    final ref = await _firestore.collection('matches').add({
      'player1Id': uid,
      'player1Name': name,
      'player2Id': null,
      'player2Name': null,
      'player1Score': 0,
      'player2Score': 0,
      'seed': seed,
      'status': 'waiting',
      'createdAt': FieldValue.serverTimestamp(),
    });

    return PvpMatch.fromFirestore(await ref.get());
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
    await _firestore.collection('matches').doc(matchId).update({
      isPlayer1 ? 'player1Score' : 'player2Score': score,
    });
  }

  /// Set match to finished
  static Future<void> finishMatch(String matchId) async {
    await _firestore.collection('matches').doc(matchId).update({
      'status': 'finished',
    });
  }
}
