import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A dynamic energy orb widget that displays the current score
/// with pulsing glow, orbiting particles, shimmer ring, and bounce effects.
class EnergyOrbScoreWidget extends StatefulWidget {
  final int score;
  final double size;
  final bool isNewRecord;

  const EnergyOrbScoreWidget({
    super.key,
    required this.score,
    this.size = 85,
    this.isNewRecord = false,
  });

  @override
  State<EnergyOrbScoreWidget> createState() => _EnergyOrbScoreWidgetState();
}

class _EnergyOrbScoreWidgetState extends State<EnergyOrbScoreWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _orbitController;
  late AnimationController _shimmerController;
  late AnimationController _bounceController;
  late Animation<double> _pulseAnim;
  late Animation<double> _bounceAnim;

  int _prevScore = 0;

  @override
  void initState() {
    super.initState();

    // Pulse: gentle breathing glow
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _pulseAnim = Tween(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Orbit: particles rotating around the orb
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat();

    // Shimmer: ring shimmer effect
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();

    // Bounce: score change bounce
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _bounceAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.25), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.25, end: 0.9), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.0), weight: 40),
    ]).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeOut),
    );

    _prevScore = widget.score;
  }

  @override
  void didUpdateWidget(covariant EnergyOrbScoreWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.score != _prevScore) {
      _prevScore = widget.score;
      _bounceController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _orbitController.dispose();
    _shimmerController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.isNewRecord
        ? const Color(0xFFFFD700)   // Gold for new record
        : const Color(0xFF6C5CE7);  // Purple default

    final glowColor = widget.isNewRecord
        ? const Color(0xFFFFA500)
        : const Color(0xFFA29BFE);

    return AnimatedBuilder(
      animation: Listenable.merge([
        _pulseController,
        _orbitController,
        _shimmerController,
        _bounceController,
      ]),
      builder: (context, child) {
        return Transform.scale(
          scale: _bounceAnim.value,
          child: SizedBox(
            width: widget.size,
            height: widget.size,
            child: CustomPaint(
              painter: _EnergyOrbPainter(
                pulseValue: _pulseAnim.value,
                orbitValue: _orbitController.value,
                shimmerValue: _shimmerController.value,
                baseColor: baseColor,
                glowColor: glowColor,
                isNewRecord: widget.isNewRecord,
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: widget.size * 0.02),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: Text(
                      '${widget.score}',
                      key: ValueKey(widget.score),
                      style: GoogleFonts.fredoka(
                        color: Colors.white,
                        fontSize: widget.size * 0.28,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                          Shadow(
                            color: glowColor.withValues(alpha: 0.8),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EnergyOrbPainter extends CustomPainter {
  final double pulseValue;
  final double orbitValue;
  final double shimmerValue;
  final Color baseColor;
  final Color glowColor;
  final bool isNewRecord;

  _EnergyOrbPainter({
    required this.pulseValue,
    required this.orbitValue,
    required this.shimmerValue,
    required this.baseColor,
    required this.glowColor,
    required this.isNewRecord,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.32;

    // 1. Outer glow (pulsing)
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          glowColor.withValues(alpha: 0.3 * pulseValue),
          glowColor.withValues(alpha: 0.1 * pulseValue),
          glowColor.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 1.8));
    canvas.drawCircle(center, radius * 1.8 * pulseValue, glowPaint);

    // 2. Main orb body with gradient
    final orbPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.3, -0.3),
        colors: [
          Color.lerp(baseColor, Colors.white, 0.3)!,
          baseColor,
          Color.lerp(baseColor, Colors.black, 0.3)!,
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, orbPaint);

    // 3. Inner glow / light reflection
    final innerGlow = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.2, -0.35),
        colors: [
          Colors.white.withValues(alpha: 0.5),
          Colors.white.withValues(alpha: 0.0),
        ],
      ).createShader(
        Rect.fromCircle(center: center + Offset(-radius * 0.15, -radius * 0.2), radius: radius * 0.55),
      );
    canvas.drawCircle(
      center + Offset(-radius * 0.15, -radius * 0.2),
      radius * 0.55,
      innerGlow,
    );

    // 4. Orbiting particles
    _drawOrbitingParticles(canvas, center, radius);

    // 5. Shimmer ring
    _drawShimmerRing(canvas, center, radius);

    // 6. Extra sparkles for new record
    if (isNewRecord) {
      _drawSparkles(canvas, center, radius);
    }
  }

  void _drawOrbitingParticles(Canvas canvas, Offset center, double radius) {
    final particleCount = isNewRecord ? 8 : 5;
    final orbitRadius = radius * 1.35;

    for (int i = 0; i < particleCount; i++) {
      final angle = (orbitValue * 2 * pi) + (i * 2 * pi / particleCount);
      // Slight wobble in orbit
      final wobble = sin(angle * 3) * radius * 0.08;
      final px = center.dx + (orbitRadius + wobble) * cos(angle);
      final py = center.dy + (orbitRadius + wobble) * sin(angle);

      final particleSize = radius * (0.04 + 0.03 * sin(angle * 2));
      final alpha = (0.5 + 0.5 * sin(angle * 2 + orbitValue * pi)).clamp(0.2, 1.0);

      final particlePaint = Paint()
        ..color = glowColor.withValues(alpha: alpha)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
      canvas.drawCircle(Offset(px, py), particleSize, particlePaint);

      // Particle glow
      final particleGlow = Paint()
        ..color = glowColor.withValues(alpha: alpha * 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      canvas.drawCircle(Offset(px, py), particleSize * 2.5, particleGlow);
    }
  }

  void _drawShimmerRing(Canvas canvas, Offset center, double radius) {
    final ringRadius = radius * 1.05;
    final sweep = pi * 0.6;
    final startAngle = shimmerValue * 2 * pi;

    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..shader = SweepGradient(
        startAngle: startAngle,
        endAngle: startAngle + sweep,
        colors: [
          Colors.transparent,
          glowColor.withValues(alpha: 0.6 * pulseValue),
          Colors.white.withValues(alpha: 0.8 * pulseValue),
          glowColor.withValues(alpha: 0.6 * pulseValue),
          Colors.transparent,
        ],
        stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
        transform: GradientRotation(startAngle),
      ).createShader(Rect.fromCircle(center: center, radius: ringRadius));

    canvas.drawCircle(center, ringRadius, ringPaint);
  }

  void _drawSparkles(Canvas canvas, Offset center, double radius) {
    final rng = Random(42); // Fixed seed so sparkles don't jump around
    for (int i = 0; i < 6; i++) {
      final angle = rng.nextDouble() * 2 * pi;
      final dist = radius * (1.2 + rng.nextDouble() * 0.6);
      final speed = 0.5 + rng.nextDouble();
      final phase = (orbitValue * speed + i * 0.3) % 1.0;
      final alpha = sin(phase * pi).clamp(0.0, 1.0);

      final sx = center.dx + dist * cos(angle + orbitValue * 0.5);
      final sy = center.dy + dist * sin(angle + orbitValue * 0.5);
      final sparkleSize = radius * 0.03 * (1 + alpha);

      // Draw a 4-point star sparkle
      final sparklePaint = Paint()
        ..color = const Color(0xFFFFD700).withValues(alpha: alpha * 0.8);

      // Horizontal line
      canvas.drawLine(
        Offset(sx - sparkleSize * 2, sy),
        Offset(sx + sparkleSize * 2, sy),
        sparklePaint..strokeWidth = 1.2,
      );
      // Vertical line
      canvas.drawLine(
        Offset(sx, sy - sparkleSize * 2),
        Offset(sx, sy + sparkleSize * 2),
        sparklePaint,
      );
      // Center dot
      canvas.drawCircle(
        Offset(sx, sy),
        sparkleSize,
        Paint()
          ..color = Colors.white.withValues(alpha: alpha)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _EnergyOrbPainter oldDelegate) => true;
}
