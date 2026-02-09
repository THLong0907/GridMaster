import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

/// Custom decoder for .lottie (dotLottie) archive files
Future<LottieComposition?> _dotLottieDecoder(List<int> bytes) {
  return LottieComposition.decodeZip(
    bytes,
    filePicker: (files) {
      return files.firstWhere(
        (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'),
        orElse: () => files.first,
      );
    },
  );
}

/// A fire Lottie animation widget that displays the current score
class HeartScoreWidget extends StatelessWidget {
  final int score;
  final double size;
  final bool isNewRecord;

  const HeartScoreWidget({
    super.key,
    required this.score,
    this.size = 60,
    this.isNewRecord = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Fire Lottie animation
          Lottie.asset(
            'assets/animation/Fire.lottie',
            decoder: _dotLottieDecoder,
            width: size,
            height: size,
            fit: BoxFit.contain,
            repeat: true,
          ),
          // Score number overlay
          Padding(
            padding: EdgeInsets.only(top: size * 0.05),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Text(
                '$score',
                key: ValueKey(score),
                style: GoogleFonts.fredoka(
                  color: Colors.white,
                  fontSize: size * 0.28,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                    Shadow(
                      color: isNewRecord
                          ? const Color(0xFFFFD700).withValues(alpha: 0.8)
                          : const Color(0xFFFF6B00).withValues(alpha: 0.6),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
