import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/particles.dart' as fp;
import 'package:grid_master/core/constants/colors.dart';

/// Creates particle effects when lines are cleared
class ClearEffectFactory {
  ClearEffectFactory._();

  /// Create a burst of particles at the given cell position
  static ParticleSystemComponent createCellBurst({
    required double x,
    required double y,
    required double cellSize,
    required int colorIndex,
    bool isTriple = false,
  }) {
    final colors = BlockColors.getColor(colorIndex);
    final random = Random();
    final particleCount = isTriple ? 15 : 8;

    return ParticleSystemComponent(
      position: Vector2(x + cellSize / 2, y + cellSize / 2),
      particle: fp.Particle.generate(
        count: particleCount,
        lifespan: isTriple ? 1.2 : 0.8,
        generator: (i) {
          final speed =
              (random.nextDouble() * 80 + 40) * (isTriple ? 1.5 : 1.0);
          final angle = random.nextDouble() * 2 * pi;
          final dx = cos(angle) * speed;
          final dy = sin(angle) * speed;
          final size = random.nextDouble() * 4 + 2;

          final particleColor = random.nextBool() ? colors.main : colors.light;

          return fp.AcceleratedParticle(
            speed: Vector2(dx, dy),
            acceleration: Vector2(0, 120), // gravity
            child: fp.ComputedParticle(
              renderer: (canvas, particle) {
                final paint = Paint()
                  ..color = particleColor.withValues(
                    alpha: 1.0 - particle.progress,
                  );
                canvas.drawCircle(
                  Offset.zero,
                  size * (1.0 - particle.progress * 0.5),
                  paint,
                );
              },
            ),
          );
        },
      ),
    );
  }

  /// Create confetti explosion for triple clear
  static List<ParticleSystemComponent> createConfetti({
    required double centerX,
    required double centerY,
    required double width,
  }) {
    final random = Random();
    final components = <ParticleSystemComponent>[];
    final confettiColors = [
      const Color(0xFFFF6B6B),
      const Color(0xFFFFD93D),
      const Color(0xFF6BCB77),
      const Color(0xFF4D96FF),
      const Color(0xFFFF6B6B),
      const Color(0xFFA29BFE),
      const Color(0xFFFF8E53),
      const Color(0xFF48C9B0),
    ];

    for (int i = 0; i < 5; i++) {
      final spawnX = centerX + (random.nextDouble() - 0.5) * width;
      components.add(
        ParticleSystemComponent(
          position: Vector2(spawnX, centerY),
          particle: fp.Particle.generate(
            count: 12,
            lifespan: 2.0,
            generator: (j) {
              final speed = random.nextDouble() * 150 + 50;
              final angle = -pi / 2 + (random.nextDouble() - 0.5) * pi * 0.8;
              final dx = cos(angle) * speed;
              final dy = sin(angle) * speed;
              final color =
                  confettiColors[random.nextInt(confettiColors.length)];
              final w = random.nextDouble() * 6 + 3;
              final h = random.nextDouble() * 4 + 2;

              return fp.AcceleratedParticle(
                speed: Vector2(dx, dy),
                acceleration: Vector2(0, 200), // gravity
                child: fp.ComputedParticle(
                  renderer: (canvas, particle) {
                    final paint = Paint()
                      ..color = color.withValues(
                        alpha: 1.0 - particle.progress,
                      );
                    canvas.save();
                    canvas.rotate(particle.progress * pi * 4);
                    canvas.drawRect(
                      Rect.fromCenter(center: Offset.zero, width: w, height: h),
                      paint,
                    );
                    canvas.restore();
                  },
                ),
              );
            },
          ),
        ),
      );
    }

    return components;
  }
}
