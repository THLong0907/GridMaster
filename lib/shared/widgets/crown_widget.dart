import 'package:flutter/material.dart';

/// A shiny gold crown widget with a gentle floating animation
class CrownWidget extends StatefulWidget {
  final double size;
  const CrownWidget({super.key, this.size = 24});

  @override
  State<CrownWidget> createState() => _CrownWidgetState();
}

class _CrownWidgetState extends State<CrownWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0,
      end: -8,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glow effect
          Container(
            width: widget.size * 1.2,
            height: widget.size * 1.2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withValues(alpha: 0.4),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          Icon(
            Icons.emoji_events, // Material icon that looks like a trophy/crown
            color: Colors.amber,
            size: widget.size,
          ),
          // Small highlight
          Positioned(
            top: 2,
            right: 2,
            child: Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: Colors.white70,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
