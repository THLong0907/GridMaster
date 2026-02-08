import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grid_master/core/constants/strings.dart';
import 'package:grid_master/shared/widgets/crown_widget.dart';

/// Score and streak overlay displayed on top of the Flame game
class ScoreOverlay extends StatelessWidget {
  final int score;
  final int streak;
  final String? comboMessage;
  final String? modeName;
  final bool isTop1;
  final String? rivalName;
  final int? rivalScore;
  final VoidCallback onHomeTap;

  const ScoreOverlay({
    super.key,
    required this.score,
    required this.streak,
    this.comboMessage,
    this.modeName,
    this.isTop1 = false,
    this.rivalName,
    this.rivalScore,
    required this.onHomeTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Home button
            _buildIconButton(Icons.home_rounded, onHomeTap),

            // Score display
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isTop1)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: CrownWidget(size: 32),
                  ),
                if (modeName != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      modeName!,
                      style: GoogleFonts.fredoka(
                        color: Colors.white.withValues(alpha: 0.4),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                Text(
                  GameStrings.score,
                  style: GoogleFonts.fredoka(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 1),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
                  child: Text(
                    '$score',
                    key: ValueKey(score),
                    style: GoogleFonts.fredoka(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // Streak or Rival
            if (rivalName != null)
              Column(
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
            else
              streak > 1
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
