import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:grid_master/shared/services/daily_challenge_service.dart';
import 'package:grid_master/l10n/generated/app_localizations.dart';

/// Animated daily challenge card for lobby screen
class DailyChallengeCard extends StatefulWidget {
  const DailyChallengeCard({super.key});

  @override
  State<DailyChallengeCard> createState() => _DailyChallengeCardState();
}

class _DailyChallengeCardState extends State<DailyChallengeCard>
    with SingleTickerProviderStateMixin {
  bool _completed = false;
  int _bestScore = 0;
  int _streak = 0;
  late AnimationController _shimmer;

  @override
  void initState() {
    super.initState();
    _shimmer = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    _loadData();
  }

  @override
  void dispose() {
    _shimmer.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final svc = DailyChallengeService.instance;
    final completed = await svc.isCompletedToday();
    final best = await svc.getTodayBestScore();
    final streak = await svc.getStreak();
    if (mounted) {
      setState(() {
        _completed = completed;
        _bestScore = best;
        _streak = streak;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateStr =
        '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}';

    return GestureDetector(
      onTap: () {
        final seed = DailyChallengeService.instance.todaySeed;
        context.push('/game/easy?practice=false&daily=true&seed=$seed');
      },
      child: AnimatedBuilder(
        animation: _shimmer,
        builder: (context, child) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _completed
                    ? [const Color(0xFF1A4A2E), const Color(0xFF0D3320)]
                    : [const Color(0xFF2D1B69), const Color(0xFF1A1145)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _completed
                    ? const Color(0xFF00B894).withValues(alpha: 0.5)
                    : const Color(0xFF6C5CE7).withValues(alpha: 0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: (_completed
                          ? const Color(0xFF00B894)
                          : const Color(0xFF6C5CE7))
                      .withValues(alpha: 0.2),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              children: [
                // Calendar icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: (_completed
                            ? const Color(0xFF00B894)
                            : const Color(0xFF6C5CE7))
                        .withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: (_completed
                              ? const Color(0xFF00B894)
                              : const Color(0xFF6C5CE7))
                          .withValues(alpha: 0.4),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      _completed ? Icons.check_circle_rounded : Icons.calendar_today_rounded,
                      size: 22,
                      color: _completed ? const Color(0xFF00B894) : const Color(0xFF6C5CE7),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.dailyChallenge.toUpperCase(),
                            style: GoogleFonts.fredoka(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            dateStr,
                            style: GoogleFonts.fredoka(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          if (_completed) ...[
                            Text(
                              AppLocalizations.of(context)!.best(_bestScore),
                              style: GoogleFonts.fredoka(
                                color: const Color(0xFF00B894),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                          if (_streak > 0)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.local_fire_department_rounded, size: 14, color: Color(0xFFFDCB6E)),
                                const SizedBox(width: 2),
                                Text(
                                  '$_streak ${AppLocalizations.of(context)!.streak}!',
                                  style: GoogleFonts.fredoka(
                                    color: const Color(0xFFFDCB6E),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          if (!_completed && _streak == 0)
                            Text(
                              '${AppLocalizations.of(context)!.play}!',
                              style: GoogleFonts.fredoka(
                                color: Colors.white.withValues(alpha: 0.5),
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Arrow
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
