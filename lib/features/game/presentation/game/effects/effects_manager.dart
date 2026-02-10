import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/particles.dart' as fp;
import 'package:grid_master/shared/services/audio_service.dart';
import 'screen_effects.dart';

/// Effect intensity levels
enum EffectIntensity { light, medium, strong, extreme }

/// Full-screen effects manager with intensity scaling
class EffectsManager {
  EffectsManager._();
  static final _rng = Random();

  // ═══ COLOR PALETTES ═══
  static const _tetColors = [
    Color(0xFFFF0000), Color(0xFFFFD700), Color(0xFFFF4500),
    Color(0xFFFF69B4), Color(0xFF00FF7F), Color(0xFFFF1493),
    Color(0xFFFFA500), Color(0xFFFF6347),
  ];

  static const _rainbowColors = [
    Color(0xFFFF0000), Color(0xFFFF7F00), Color(0xFFFFFF00),
    Color(0xFF00FF00), Color(0xFF0000FF), Color(0xFF4B0082),
    Color(0xFF9400D3),
  ];

  // ═══ INTENSITY ═══
  static EffectIntensity getIntensity(int streak, int linesCleared) {
    if (streak >= 8 || linesCleared >= 5) return EffectIntensity.extreme;
    if (streak >= 5 || linesCleared >= 4) return EffectIntensity.strong;
    if (streak >= 3 || linesCleared >= 3) return EffectIntensity.medium;
    return EffectIntensity.light;
  }

  /// Get pitch multiplier for streak-based escalation
  static double getPitchMultiplier(int streak) {
    if (streak >= 8) return 3.0;
    if (streak >= 5) return 2.0;
    if (streak >= 3) return 1.5;
    return 1.0;
  }

  // ═══════════════ FULL-SCREEN BASIC EFFECTS ═══════════════

  /// 🎆 Firework — rocket flies up → pauses → explodes across full screen
  static List<Component> createFirework({
    required double screenWidth,
    required double screenHeight,
    required EffectIntensity intensity,
  }) {
    final components = <Component>[];
    final burstCount = switch (intensity) {
      EffectIntensity.extreme => 8,
      EffectIntensity.strong => 6,
      EffectIntensity.medium => 4,
      _ => 3,
    };
    final particlesPerBurst = switch (intensity) {
      EffectIntensity.extreme => 50,
      EffectIntensity.strong => 38,
      EffectIntensity.medium => 28,
      _ => 20,
    };

    for (int b = 0; b < burstCount; b++) {
      // Spread across full screen
      final bx = _rng.nextDouble() * screenWidth;
      final by = _rng.nextDouble() * screenHeight * 0.5 + screenHeight * 0.1;
      final burstColor = _tetColors[_rng.nextInt(_tetColors.length)];

      components.add(
        ParticleSystemComponent(
          position: Vector2(bx, by),
          particle: fp.Particle.generate(
            count: particlesPerBurst,
            lifespan: 3.0,
            generator: (i) {
              final speed = _rng.nextDouble() * 400 + 200;
              final angle = _rng.nextDouble() * 2 * pi;
              final dx = cos(angle) * speed;
              final dy = sin(angle) * speed;
              final size = _rng.nextDouble() * 10 + 6;
              final color = Color.lerp(
                burstColor,
                _tetColors[_rng.nextInt(_tetColors.length)],
                _rng.nextDouble() * 0.4,
              )!;

              return fp.AcceleratedParticle(
                speed: Vector2(dx, dy),
                acceleration: Vector2(0, 120),
                child: fp.ComputedParticle(
                  renderer: (canvas, particle) {
                    final t = particle.progress;
                    final opacity = (1.0 - t).clamp(0.0, 1.0);
                    // Trail effect — draw a line behind
                    final trailLen = 14 * (1.0 - t);
                    final paint = Paint()
                      ..color = color.withValues(alpha: opacity)
                      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
                    canvas.drawCircle(Offset.zero, size * (1.0 - t * 0.3), paint);
                    // Spark trail
                    if (t < 0.7) {
                      canvas.drawLine(
                        Offset.zero,
                        Offset(-dx * 0.02 * trailLen, -dy * 0.02 * trailLen),
                        Paint()
                          ..color = color.withValues(alpha: opacity * 0.5)
                          ..strokeWidth = size * 0.5
                          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
                      );
                    }
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

  /// ✨ Sparkle — glittering stars across full screen
  static List<Component> createSparkle({
    required double screenWidth,
    required double screenHeight,
    required EffectIntensity intensity,
  }) {
    final components = <Component>[];
    final count = switch (intensity) {
      EffectIntensity.extreme => 25,
      EffectIntensity.strong => 18,
      EffectIntensity.medium => 12,
      _ => 7,
    };

    for (int i = 0; i < count; i++) {
      final sx = _rng.nextDouble() * screenWidth;
      final sy = _rng.nextDouble() * screenHeight * 0.7;
      final sparkleColor = _tetColors[_rng.nextInt(_tetColors.length)];

      components.add(
        ParticleSystemComponent(
          position: Vector2(sx, sy),
          particle: fp.Particle.generate(
            count: 12,
            lifespan: 3.5,
            generator: (j) {
              final speed = _rng.nextDouble() * 50 + 20;
              final angle = _rng.nextDouble() * 2 * pi;
              final size = _rng.nextDouble() * 10 + 7;

              return fp.AcceleratedParticle(
                speed: Vector2(cos(angle) * speed, sin(angle) * speed),
                acceleration: Vector2(0, 40),
                child: fp.ComputedParticle(
                  renderer: (canvas, particle) {
                    final twinkle = (sin(particle.progress * pi * 8) + 1) / 2;
                    final opacity = ((1.0 - particle.progress) * twinkle).clamp(0.0, 1.0);
                    final paint = Paint()
                      ..color = sparkleColor.withValues(alpha: opacity)
                      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

                    canvas.save();
                    canvas.rotate(particle.progress * pi * 4);
                    for (int k = 0; k < 4; k++) {
                      canvas.drawRect(
                        Rect.fromCenter(center: Offset.zero, width: size, height: size * 0.2),
                        paint,
                      );
                      canvas.rotate(pi / 4);
                    }
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

  /// 🌊 Shockwave — full-screen expanding ring + screen flash
  static List<Component> createShockwave({
    required double screenWidth,
    required double screenHeight,
    required double centerX,
    required double centerY,
    required EffectIntensity intensity,
  }) {
    final components = <Component>[];
    final maxRadius = switch (intensity) {
      EffectIntensity.extreme => screenWidth * 1.2,
      EffectIntensity.strong => screenWidth * 0.9,
      EffectIntensity.medium => screenWidth * 0.7,
      _ => screenWidth * 0.5,
    };
    final ringColor = _tetColors[_rng.nextInt(_tetColors.length)];

    // Main shockwave ring
    components.add(
      ParticleSystemComponent(
        position: Vector2(centerX, centerY),
        particle: fp.ComputedParticle(
          lifespan: 1.2,
          renderer: (canvas, particle) {
            final t = particle.progress;
            final radius = maxRadius * t;
            final opacity = (1.0 - t).clamp(0.0, 1.0);
            final strokeWidth = 10.0 * (1.0 - t) + 2.0;

            // Outer ring
            canvas.drawCircle(
              Offset.zero,
              radius,
              Paint()
                ..color = ringColor.withValues(alpha: opacity * 0.8)
                ..style = PaintingStyle.stroke
                ..strokeWidth = strokeWidth
                ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
            );
            // Inner glow fill
            canvas.drawCircle(
              Offset.zero,
              radius * 0.95,
              Paint()
                ..color = ringColor.withValues(alpha: opacity * 0.15)
                ..style = PaintingStyle.fill,
            );
            // Second ring (slightly behind)
            if (t > 0.1) {
              canvas.drawCircle(
                Offset.zero,
                radius * 0.75,
                Paint()
                  ..color = ringColor.withValues(alpha: opacity * 0.3)
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = strokeWidth * 0.5
                  ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
              );
            }
          },
        ),
      ),
    );

    // Screen flash
    components.add(ScreenFlashComponent(color: ringColor, duration: 0.45));

    return components;
  }

  /// 💥 Block Explosion — fragments fly to screen edges
  static List<Component> createBlockExplosion({
    required double screenWidth,
    required double screenHeight,
    required double centerX,
    required double centerY,
    required double cellSize,
    required EffectIntensity intensity,
  }) {
    final components = <Component>[];
    final fragmentCount = switch (intensity) {
      EffectIntensity.extreme => 45,
      EffectIntensity.strong => 35,
      EffectIntensity.medium => 25,
      _ => 16,
    };

    components.add(
      ParticleSystemComponent(
        position: Vector2(centerX, centerY),
        particle: fp.Particle.generate(
          count: fragmentCount,
          lifespan: 2.5,
          generator: (i) {
            final speed = _rng.nextDouble() * 500 + 200;
            final angle = _rng.nextDouble() * 2 * pi;
            final dx = cos(angle) * speed;
            final dy = sin(angle) * speed;
            final fragSize = _rng.nextDouble() * (cellSize * 0.8) + 6;
            final color = _tetColors[_rng.nextInt(_tetColors.length)];

            return fp.AcceleratedParticle(
              speed: Vector2(dx, dy),
              acceleration: Vector2(0, 200),
              child: fp.ComputedParticle(
                renderer: (canvas, particle) {
                  final t = particle.progress;
                  final opacity = (1.0 - t).clamp(0.0, 1.0);
                  final sz = fragSize * (1.0 - t * 0.4);
                  canvas.save();
                  canvas.rotate(t * pi * 6);
                  canvas.drawRect(
                    Rect.fromCenter(center: Offset.zero, width: sz, height: sz),
                    Paint()..color = color.withValues(alpha: opacity),
                  );
                  // Fragment glow
                  canvas.drawRect(
                    Rect.fromCenter(center: Offset.zero, width: sz * 1.3, height: sz * 1.3),
                    Paint()
                      ..color = color.withValues(alpha: opacity * 0.3)
                      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
                  );
                  canvas.restore();
                },
              ),
            );
          },
        ),
      ),
    );
    return components;
  }

  // ═══════════════ COMBO EFFECTS ═══════════════

  /// 🔥 Fire Pillar — vertical fire columns
  static List<Component> createFirePillar({
    required double screenWidth,
    required double screenHeight,
    required double centerX,
  }) {
    final components = <Component>[];
    // Multiple fire columns spread across screen
    for (int i = 0; i < 3; i++) {
      final fx = centerX + (i - 1) * screenWidth * 0.3;
      components.add(
        ParticleSystemComponent(
          position: Vector2(fx, screenHeight),
          particle: fp.Particle.generate(
            count: 40,
            lifespan: 2.5,
            generator: (j) {
              final speed = _rng.nextDouble() * 450 + 200;
              final dx = (_rng.nextDouble() - 0.5) * 80;
              final dy = -speed;
              final size = _rng.nextDouble() * 14 + 8;
              final t = _rng.nextDouble();
              final color = Color.lerp(
                const Color(0xFFFF4500), const Color(0xFFFFD700), t,
              )!;

              return fp.AcceleratedParticle(
                speed: Vector2(dx, dy),
                acceleration: Vector2(0, 80),
                child: fp.ComputedParticle(
                  renderer: (canvas, particle) {
                    final opacity = (1.0 - particle.progress).clamp(0.0, 1.0);
                    canvas.drawCircle(
                      Offset.zero,
                      size * (1.0 - particle.progress * 0.3),
                      Paint()
                        ..color = color.withValues(alpha: opacity)
                        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
                    );
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

  /// ⚡ Lightning — full-screen bolt from top to bottom
  static List<Component> createLightning({
    required double screenWidth,
    required double screenHeight,
  }) {
    final components = <Component>[];

    // Multiple bolts
    for (int bolt = 0; bolt < 3; bolt++) {
      final startX = _rng.nextDouble() * screenWidth;
      components.add(
        ParticleSystemComponent(
          position: Vector2(startX, 0),
          particle: fp.ComputedParticle(
            lifespan: 0.6,
            renderer: (canvas, particle) {
              final t = particle.progress;
              final opacity = (1.0 - t * 2.5).clamp(0.0, 1.0);

              // Build zigzag bolt path
              final path = Path();
              path.moveTo(0, 0);
              double x = 0, y = 0;
              final segments = 12;
              for (int s = 0; s < segments; s++) {
                x += (_rng.nextDouble() - 0.5) * 60;
                y += screenHeight / segments;
                path.lineTo(x, y);
              }

              // Main bolt (bright)
              canvas.drawPath(
                path,
                Paint()
                  ..color = const Color(0xFFFFFFFF).withValues(alpha: opacity)
                  ..strokeWidth = 7
                  ..style = PaintingStyle.stroke,
              );
              // Glow around bolt
              canvas.drawPath(
                path,
                Paint()
                  ..color = const Color(0xFF87CEFA).withValues(alpha: opacity * 0.7)
                  ..strokeWidth = 20
                  ..style = PaintingStyle.stroke
                  ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14),
              );

              // Spark particles at segments
              for (int s = 0; s < 4; s++) {
                final sx = (_rng.nextDouble() - 0.5) * 30;
                final sy = _rng.nextDouble() * screenHeight;
                canvas.drawCircle(
                  Offset(sx, sy),
                  6,
                  Paint()
                    ..color = const Color(0xFF00BFFF).withValues(alpha: opacity)
                    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
                );
              }
            },
          ),
        ),
      );
    }

    // Full-screen flash
    components.add(ScreenFlashComponent(
      color: const Color(0xFF87CEFA),
      duration: 0.3,
    ));

    return components;
  }

  /// 🌈 Rainbow Wave — horizontal sweep across full screen
  static List<Component> createRainbowWave({
    required double screenWidth,
    required double screenHeight,
  }) {
    final components = <Component>[];

    // Horizontal sweep
    components.add(
      ParticleSystemComponent(
        position: Vector2(0, 0),
        particle: fp.ComputedParticle(
          lifespan: 2.0,
          renderer: (canvas, particle) {
            final t = particle.progress;
            for (int i = 0; i < _rainbowColors.length; i++) {
              final sweepX = t * screenWidth * 1.5 - i * 50;
              if (sweepX > -80 && sweepX < screenWidth + 80) {
                final opacity = (1.0 - t).clamp(0.0, 1.0) * 0.7;
                canvas.drawRect(
                  Rect.fromLTWH(sweepX - 25, 0, 50, screenHeight),
                  Paint()
                    ..color = _rainbowColors[i].withValues(alpha: opacity)
                    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 22),
                );
              }
            }
          },
        ),
      ),
    );

    // Rainbow particles scattered fullscreen
    for (int i = 0; i < 30; i++) {
      final px = _rng.nextDouble() * screenWidth;
      final py = _rng.nextDouble() * screenHeight;
      final color = _rainbowColors[_rng.nextInt(_rainbowColors.length)];

      components.add(
        ParticleSystemComponent(
          position: Vector2(px, py),
          particle: fp.Particle.generate(
            count: 6,
            lifespan: 3.0,
            generator: (j) {
              final speed = _rng.nextDouble() * 120 + 50;
              final angle = _rng.nextDouble() * 2 * pi;
              return fp.AcceleratedParticle(
                speed: Vector2(cos(angle) * speed, sin(angle) * speed),
                acceleration: Vector2(0, 40),
                child: fp.ComputedParticle(
                  renderer: (canvas, p) {
                    final opacity = (1.0 - p.progress).clamp(0.0, 1.0);
                    canvas.drawCircle(
                      Offset.zero, 9,
                      Paint()
                        ..color = color.withValues(alpha: opacity)
                        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7),
                    );
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

  // ═══════════════ TẾT SPECIAL EFFECTS ═══════════════

  /// 🧧 Lì Xì — red envelopes raining from top of full screen
  static List<Component> createLiXi({
    required double screenWidth,
    required double screenHeight,
  }) {
    final components = <Component>[];
    for (int i = 0; i < 10; i++) {
      final sx = _rng.nextDouble() * screenWidth;

      components.add(
        ParticleSystemComponent(
          position: Vector2(sx, -30),
          particle: fp.Particle.generate(
            count: 1,
            lifespan: 3.0,
            generator: (_) {
              final dx = (_rng.nextDouble() - 0.5) * 40;
              final dy = _rng.nextDouble() * 60 + 40;

              return fp.AcceleratedParticle(
                speed: Vector2(dx, dy),
                acceleration: Vector2(0, 20),
                child: fp.ComputedParticle(
                  renderer: (canvas, particle) {
                    final t = particle.progress;
                    final opacity = t < 0.1 ? t * 10 : (1.0 - t).clamp(0.0, 1.0);
                    final sway = sin(t * pi * 6) * 10;

                    canvas.save();
                    canvas.translate(sway, 0);
                    canvas.rotate(sin(t * pi * 3) * 0.15);

                    // Envelope body
                    canvas.drawRRect(
                      RRect.fromRectAndRadius(
                        const Rect.fromLTWH(-12, -16, 24, 32),
                        const Radius.circular(4),
                      ),
                      Paint()..color = const Color(0xFFFF0000).withValues(alpha: opacity),
                    );
                    // Gold decoration
                    canvas.drawCircle(
                      Offset.zero, 6,
                      Paint()..color = const Color(0xFFFFD700).withValues(alpha: opacity),
                    );
                    canvas.drawRect(
                      const Rect.fromLTWH(-8, -2.5, 16, 5),
                      Paint()..color = const Color(0xFFFFD700).withValues(alpha: opacity),
                    );
                    // Gold border
                    canvas.drawRRect(
                      RRect.fromRectAndRadius(
                        const Rect.fromLTWH(-12, -16, 24, 32),
                        const Radius.circular(4),
                      ),
                      Paint()
                        ..color = const Color(0xFFFFD700).withValues(alpha: opacity * 0.6)
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1.5,
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

  /// 🏮 Lanterns — float up from both sides of screen
  static List<Component> createLanterns({
    required double screenWidth,
    required double screenHeight,
  }) {
    final components = <Component>[];
    for (int i = 0; i < 10; i++) {
      // Spawn from left and right edges
      final fromLeft = i < 5;
      final sx = fromLeft
          ? _rng.nextDouble() * screenWidth * 0.3
          : screenWidth * 0.7 + _rng.nextDouble() * screenWidth * 0.3;

      components.add(
        ParticleSystemComponent(
          position: Vector2(sx, screenHeight + 30),
          particle: fp.Particle.generate(
            count: 1,
            lifespan: 4.0,
            generator: (_) {
              final dx = (_rng.nextDouble() - 0.5) * 15;
              final dy = -(_rng.nextDouble() * 40 + 30);

              return fp.AcceleratedParticle(
                speed: Vector2(dx, dy),
                acceleration: Vector2(0, -5),
                child: fp.ComputedParticle(
                  renderer: (canvas, particle) {
                    final t = particle.progress;
                    final opacity = t < 0.1 ? t * 10 : (t > 0.8 ? (1.0 - t) * 5 : 1.0);
                    final sway = sin(t * pi * 5) * 8;

                    canvas.save();
                    canvas.translate(sway, 0);

                    final isRed = _rng.nextBool();
                    final bodyColor = isRed ? const Color(0xFFFF0000) : const Color(0xFFFFD700);

                    // Glow
                    canvas.drawCircle(
                      Offset.zero, 24,
                      Paint()
                        ..color = bodyColor.withValues(alpha: opacity * 0.35)
                        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
                    );
                    // Lantern body
                    canvas.drawOval(
                      const Rect.fromLTWH(-14, -18, 28, 36),
                      Paint()..color = bodyColor.withValues(alpha: opacity * 0.9),
                    );
                    // String
                    canvas.drawLine(
                      const Offset(0, -13),
                      const Offset(0, -20),
                      Paint()
                        ..color = const Color(0xFFFFD700).withValues(alpha: opacity)
                        ..strokeWidth = 1.5,
                    );
                    // Bottom tassel
                    canvas.drawLine(
                      const Offset(0, 13),
                      const Offset(0, 20),
                      Paint()
                        ..color = const Color(0xFFFFD700).withValues(alpha: opacity)
                        ..strokeWidth = 1,
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

  /// 🎇 High Score celebration — fireworks everywhere
  static List<Component> createHighScoreFireworks({
    required double screenWidth,
    required double screenHeight,
  }) {
    return createFirework(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      intensity: EffectIntensity.extreme,
    );
  }

  // ═══════════════ MASTER TRIGGER ═══════════════

  /// Spawn all effects for a line clear, scaled by intensity
  /// Returns list of Components to add to game
  static List<Component> spawnClearEffects({
    required double screenWidth,
    required double screenHeight,
    required double centerX,
    required double centerY,
    required double cellSize,
    required int streak,
    required int linesCleared,
    required bool tetEnabled,
  }) {
    final components = <Component>[];
    final intensity = getIntensity(streak, linesCleared);
    final pitch = getPitchMultiplier(streak);

    // ── Random basic effect ──
    final effectType = _rng.nextInt(4);
    switch (effectType) {
      case 0:
        components.addAll(createFirework(
          screenWidth: screenWidth, screenHeight: screenHeight, intensity: intensity,
        ));
        break;
      case 1:
        components.addAll(createSparkle(
          screenWidth: screenWidth, screenHeight: screenHeight, intensity: intensity,
        ));
        break;
      case 2:
        components.addAll(createShockwave(
          screenWidth: screenWidth, screenHeight: screenHeight,
          centerX: centerX, centerY: centerY, intensity: intensity,
        ));
        break;
      case 3:
        components.addAll(createBlockExplosion(
          screenWidth: screenWidth, screenHeight: screenHeight,
          centerX: centerX, centerY: centerY,
          cellSize: cellSize, intensity: intensity,
        ));
        break;
    }
    _playBasicSound(effectType, pitch);

    // ── Screen flash for medium+ ──
    if (intensity.index >= EffectIntensity.medium.index) {
      components.add(ScreenFlashComponent(
        color: const Color(0xFFFFD700),
        duration: 0.35,
      ));
      // Double-strobe for extreme
      if (intensity == EffectIntensity.extreme) {
        components.add(ScreenFlashComponent(
          color: const Color(0xFFFF4500),
          duration: 0.25,
        ));
      }
    }

    // ── Combo effects ──
    if (streak >= 8) {
      // EXTREME: everything at once!
      components.addAll(createFirePillar(
        screenWidth: screenWidth, screenHeight: screenHeight, centerX: centerX,
      ));
      components.addAll(createLightning(
        screenWidth: screenWidth, screenHeight: screenHeight,
      ));
      components.addAll(createRainbowWave(
        screenWidth: screenWidth, screenHeight: screenHeight,
      ));
      AudioService.instance.playLightningSound(pitch);
      AudioService.instance.playRainbowSound(pitch);
    } else if (streak >= 5) {
      // Lightning
      components.addAll(createLightning(
        screenWidth: screenWidth, screenHeight: screenHeight,
      ));
      AudioService.instance.playLightningSound(pitch);
    } else if (streak >= 3) {
      // Fire Pillar
      components.addAll(createFirePillar(
        screenWidth: screenWidth, screenHeight: screenHeight, centerX: centerX,
      ));
      AudioService.instance.playFirePillarSound(pitch);
    }

    // ── Rainbow Wave on mega clear ──
    if (linesCleared >= 4 && streak < 8) {
      components.addAll(createRainbowWave(
        screenWidth: screenWidth, screenHeight: screenHeight,
      ));
      AudioService.instance.playRainbowSound(pitch);
    }

    // ── Tết specials ──
    if (tetEnabled) {
      if (linesCleared >= 3) {
        components.addAll(createLanterns(
          screenWidth: screenWidth, screenHeight: screenHeight,
        ));
        AudioService.instance.playLanternSound();
      }
    }

    return components;
  }

  // ═══════════════ AUDIO HELPERS ═══════════════

  static void _playBasicSound(int effectType, double pitch) {
    final audio = AudioService.instance;
    switch (effectType) {
      case 0: audio.playFireworkSound(pitch); break;
      case 1: audio.playSparkleSound(pitch); break;
      case 2: audio.playShockwaveSound(pitch); break;
      case 3: audio.playExplosionSound(pitch); break;
    }
  }
}
