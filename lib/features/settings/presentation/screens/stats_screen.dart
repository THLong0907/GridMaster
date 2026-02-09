import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grid_master/features/game/domain/models/game_mode.dart';
import 'package:grid_master/shared/services/stats_service.dart';
import 'package:grid_master/shared/widgets/animated_block_background.dart';

/// Statistics dashboard showing game stats
class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  Map<String, dynamic> _stats = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final s = await StatsService.getStats();
    if (mounted) setState(() { _stats = s; _loading = false; });
  }

  String _formatTime(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    if (h > 0) return '${h}h ${m}m';
    return '${m}m ${seconds % 60}s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      body: Stack(
        children: [
          const AnimatedBlockBackground(),
          SafeArea(
            child: _loading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF6C5CE7)))
                : CustomScrollView(
                    slivers: [
                      // App bar
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.arrow_back_ios,
                                    color: Colors.white70),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '📊 STATISTICS',
                                style: GoogleFonts.fredoka(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Global stats
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'OVERALL',
                                style: GoogleFonts.fredoka(
                                  color: Colors.white.withValues(alpha: 0.5),
                                  fontSize: 12,
                                  letterSpacing: 3,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  _statCard(
                                    '🎮',
                                    '${_stats['totalGames'] ?? 0}',
                                    'Games',
                                    const Color(0xFF6C5CE7),
                                  ),
                                  const SizedBox(width: 12),
                                  _statCard(
                                    '⭐',
                                    '${_stats['totalScore'] ?? 0}',
                                    'Total Score',
                                    const Color(0xFFFFD700),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  _statCard(
                                    '📏',
                                    '${_stats['totalLines'] ?? 0}',
                                    'Lines',
                                    const Color(0xFF00B894),
                                  ),
                                  const SizedBox(width: 12),
                                  _statCard(
                                    '⏰',
                                    _formatTime(_stats['totalTime'] ?? 0),
                                    'Play Time',
                                    const Color(0xFFFF6B6B),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Text(
                                'PER MODE',
                                style: GoogleFonts.fredoka(
                                  color: Colors.white.withValues(alpha: 0.5),
                                  fontSize: 12,
                                  letterSpacing: 3,
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                      ),

                      // Per-mode stats
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final mode = GameMode.values[index];
                            final games =
                                _stats['${mode.name}_games'] ?? 0;
                            final best =
                                _stats['${mode.name}_best'] ?? 0;
                            return _modeStatTile(mode, games, best);
                          },
                          childCount: GameMode.values.length,
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 32)),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String emoji, String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.fredoka(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.fredoka(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _modeStatTile(GameMode mode, int games, int best) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(mode.icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mode.displayName,
                  style: GoogleFonts.fredoka(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$games games played',
                  style: GoogleFonts.fredoka(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$best',
                style: GoogleFonts.fredoka(
                  color: const Color(0xFFFFD700),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Best',
                style: GoogleFonts.fredoka(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
