import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A smooth pink heart widget that displays the current score with a heartbeat animation
class HeartScoreWidget extends StatefulWidget {
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
  State<HeartScoreWidget> createState() => _HeartScoreWidgetState();
}

class _HeartScoreWidgetState extends State<HeartScoreWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _beatAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _beatAnimation = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRecord = widget.isNewRecord;
    final heartColor = isRecord ? const Color(0xFFFFD700) : const Color(0xFFFF69B4);

    return AnimatedBuilder(
      animation: _beatAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _beatAnimation.value,
          child: child,
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Heart icon (Material's favorite icon is a clean heart)
          Icon(
            Icons.favorite,
            color: heartColor,
            size: widget.size,
            shadows: [
              Shadow(
                color: heartColor.withValues(alpha: 0.6),
                blurRadius: 16,
              ),
            ],
          ),
          // Score number inside
          Padding(
            padding: EdgeInsets.only(top: widget.size * 0.04),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Text(
                '${widget.score}',
                key: ValueKey(widget.score),
                style: GoogleFonts.fredoka(
                  color: Colors.white,
                  fontSize: widget.size * 0.3,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
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
