import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grid_master/l10n/generated/app_localizations.dart';
import 'package:grid_master/shared/widgets/crown_widget.dart';
import 'package:grid_master/shared/widgets/heart_score_widget.dart';

/// Score and streak overlay displayed on top of the Flame game
/// Layout: [Home | Crown+BestScore] ... [ModeName] ... [Heart+Score | Streak/Rival]
class ScoreOverlay extends StatelessWidget {
  final int score;
  final int highScore;
  final int streak;
  final String? comboMessage;
  final String? modeName;
  final bool isTop1;
  final String? rivalName;
  final int? rivalScore;
  final VoidCallback onPauseTap;

  const ScoreOverlay({
    super.key,
    required this.score,
    this.highScore = 0,
    required this.streak,
    this.comboMessage,
    this.modeName,
    this.isTop1 = false,
    this.rivalName,
    this.rivalScore,
    required this.onPauseTap,
  });

  @override
  Widget build(BuildContext context) {
    final isNewRecord = score > 0 && score > highScore;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT: Home button + Crown + Best Score
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildIconButton(Icons.pause_rounded, onPauseTap),
                  const SizedBox(width: 10),
                  const CrownWidget(size: 22),
                  const SizedBox(width: 4),
                Text(
                  '${isNewRecord ? score : highScore}',
                  style: GoogleFonts.fredoka(
                    color: const Color(0xFFFFD700),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.amber.withValues(alpha: 0.5),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  ),
                ],
              ),
            ),

            // CENTER: Mode name + Heart score
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (modeName != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      modeName!,
                      style: GoogleFonts.fredoka(
                        color: Colors.white.withValues(alpha: 0.4),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                const SizedBox(height: 6),
                HeartScoreWidget(
                  score: score,
                  size: 85,
                  isNewRecord: isNewRecord,
                ),
                // NEW RECORD badge
                if (isNewRecord)
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.elasticOut,
                    builder: (context, value, child) {
                      return Transform.scale(scale: value, child: child);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 2),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withValues(alpha: 0.4),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Text(
                        '🏆 NEW RECORD!',
                        style: GoogleFonts.fredoka(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // RIGHT: Streak or Rival
            Expanded(
              child: Align(
                alignment: Alignment.topRight,
                child: rivalName != null
                ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      rivalName!.toUpperCase(),
                      style: GoogleFonts.fredoka(
                        color: Colors.redAccent.withValues(alpha: 0.6),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      '${rivalScore ?? 0}',
                      style: GoogleFonts.fredoka(
                        color: Colors.redAccent,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
                : streak > 1
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFFFF6B6B,
                              ).withValues(alpha: 0.4),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.local_fire_department,
                              color: Colors.white,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'x$streak',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(width: 48),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}
