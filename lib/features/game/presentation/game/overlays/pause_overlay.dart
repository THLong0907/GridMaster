import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grid_master/l10n/generated/app_localizations.dart';

/// Pause overlay with blur background and Resume/Restart/Home buttons
class PauseOverlay extends StatelessWidget {
  final int score;
  final String modeName;
  final VoidCallback onResume;
  final VoidCallback onRestart;
  final VoidCallback onGoHome;

  const PauseOverlay({
    super.key,
    required this.score,
    required this.modeName,
    required this.onResume,
    required this.onRestart,
    required this.onGoHome,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blur + dark overlay
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              color: const Color(0xFF0D0D1A).withValues(alpha: 0.7),
            ),
          ),
        ),
        // Content
        Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.8, end: 1.0),
            duration: const Duration(milliseconds: 300),
            curve: Curves.elasticOut,
            builder: (context, scale, child) =>
                Transform.scale(scale: scale, child: child),
            child: Container(
              width: 280,
              padding: const EdgeInsets.symmetric(
                vertical: 32,
                horizontal: 24,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A3E),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Pause icon
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.pause_rounded,
                      color: Color(0xFF6C5CE7),
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.paused,
                    style: GoogleFonts.fredoka(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    modeName,
                    style: GoogleFonts.fredoka(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 14,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${AppLocalizations.of(context)!.score}: $score',
                    style: GoogleFonts.fredoka(
                      color: const Color(0xFFFFD700),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Resume button
                  _buildButton(
                    AppLocalizations.of(context)!.resume,
                    [const Color(0xFF00B894), const Color(0xFF00CC76)],
                    Icons.play_arrow_rounded,
                    onResume,
                  ),
                  const SizedBox(height: 12),
                  // Restart button
                  _buildButton(
                    AppLocalizations.of(context)!.restart,
                    [const Color(0xFFFF6B6B), const Color(0xFFFF8E53)],
                    Icons.refresh_rounded,
                    onRestart,
                  ),
                  const SizedBox(height: 12),
                  // Home button
                  _buildButton(
                    AppLocalizations.of(context)!.home,
                    [
                      Colors.white.withValues(alpha: 0.1),
                      Colors.white.withValues(alpha: 0.05),
                    ],
                    Icons.home_rounded,
                    onGoHome,
                    textColor: Colors.white70,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(
    String label,
    List<Color> colors,
    IconData icon,
    VoidCallback onTap, {
    Color textColor = Colors.white,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: colors),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 22),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.fredoka(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
