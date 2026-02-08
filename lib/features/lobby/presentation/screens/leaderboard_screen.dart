import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grid_master/features/game/domain/models/game_mode.dart';
import 'package:grid_master/shared/services/auth_service.dart';
import 'package:grid_master/shared/services/leaderboard_service.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: GameMode.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      appBar: AppBar(
        title: Text(
          'LEADERBOARDS',
          style: GoogleFonts.fredoka(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: const Color(0xFF6C5CE7),
          labelStyle: GoogleFonts.fredoka(fontWeight: FontWeight.bold),
          tabs: GameMode.values.map((mode) {
            return Tab(text: mode.displayName);
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: GameMode.values.map((mode) {
          return _LeaderboardList(mode: mode);
        }).toList(),
      ),
    );
  }
}

class _LeaderboardList extends StatelessWidget {
  final GameMode mode;

  const _LeaderboardList({required this.mode});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: LeaderboardService.getLeaderboardStream(mode),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading scores'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF6C5CE7)),
          );
        }

        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.leaderboard_outlined,
                  size: 64,
                  color: Colors.white24,
                ),
                const SizedBox(height: 16),
                Text(
                  'No scores yet.\nBe the first to top this mode!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.fredoka(color: Colors.white38),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            final name = data['name'] ?? 'Anonymous';
            final score = data['score'] ?? 0;
            final uid = data['uid'];
            final isMe = uid == AuthService.uid;

            return _LeaderboardItem(
              rank: index + 1,
              name: name,
              score: score,
              isMe: isMe,
            );
          },
        );
      },
    );
  }
}

class _LeaderboardItem extends StatelessWidget {
  final int rank;
  final String name;
  final int score;
  final bool isMe;

  const _LeaderboardItem({
    required this.rank,
    required this.name,
    required this.score,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final color = rank == 1
        ? const Color(0xFFFFD700) // Gold for Top 1
        : rank == 2
        ? const Color(0xFFC0C0C0) // Silver
        : rank == 3
        ? const Color(0xFFCD7F32) // Bronze
        : Colors.white70;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isMe
            ? const Color(0xFF6C5CE7).withValues(alpha: 0.2)
            : const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(16),
        border: isMe
            ? Border.all(color: const Color(0xFF6C5CE7).withValues(alpha: 0.5))
            : null,
      ),
      child: Row(
        children: [
          // Rank
          SizedBox(
            width: 32,
            child: Text(
              '$rank',
              style: GoogleFonts.fredoka(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Crown for Top 1
          if (rank == 1)
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.emoji_events,
                color: Color(0xFFFFD700),
                size: 18,
              ),
            ),

          // Name
          Expanded(
            child: Text(
              isMe ? '$name (You)' : name,
              style: GoogleFonts.fredoka(
                color: isMe ? Colors.white : Colors.white70,
                fontWeight: isMe ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),

          // Score
          Text(
            '$score',
            style: GoogleFonts.fredoka(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
