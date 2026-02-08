import 'dart:math';
import 'dart:ui';
import 'package:flutter/painting.dart' show TextPainter, TextSpan, TextStyle, TextDirection;
import 'package:flame/components.dart';
import 'package:flame/particles.dart' as fp;
import 'package:flame/effects.dart';
import 'package:flame/game.dart';

/// ━━━━━━━━━━━ SCREEN FLASH ━━━━━━━━━━━
/// Full-screen white/gold overlay that fades out
class ScreenFlashComponent extends Component with HasGameRef<FlameGame> {
  final Color color;
  final double duration;
  double _elapsed = 0;

  ScreenFlashComponent({
    this.color = const Color(0xFFFFFFFF),
    this.duration = 0.3,
  });

  @override
  void update(double dt) {
    super.update(dt);
    _elapsed += dt;
    if (_elapsed >= duration) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    final progress = (_elapsed / duration).clamp(0.0, 1.0);
    final opacity = (1.0 - progress) * 0.8;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, gameRef.size.x, gameRef.size.y),
      Paint()..color = color.withValues(alpha: opacity),
    );
  }
}

/// ━━━━━━━━━━━ SCREEN SHAKE ━━━━━━━━━━━
/// Stores shake state — the game's render() applies the offset
class ScreenShakeManager {
  double _shakeIntensity = 0;
  double _shakeDuration = 0;
  double _shakeElapsed = 0;
  final Random _rng = Random();
  Vector2 offset = Vector2.zero();

  bool get isShaking => _shakeElapsed < _shakeDuration;

  void shake({double intensity = 8, double duration = 0.3}) {
    _shakeIntensity = intensity;
    _shakeDuration = duration;
    _shakeElapsed = 0;
  }

  void update(double dt) {
    if (_shakeElapsed < _shakeDuration) {
      _shakeElapsed += dt;
      final progress = (_shakeElapsed / _shakeDuration).clamp(0.0, 1.0);
      final decay = 1.0 - progress;
      offset = Vector2(
        (_rng.nextDouble() - 0.5) * 2 * _shakeIntensity * decay,
        (_rng.nextDouble() - 0.5) * 2 * _shakeIntensity * decay,
      );
    } else {
      offset = Vector2.zero();
    }
  }
}

/// ━━━━━━━━━━━ HOA ĐÀO (Cherry Blossom) ━━━━━━━━━━━
/// Persistent cherry blossom petals falling — Tết ambient effect
class HoaDaoComponent extends Component with HasGameRef<FlameGame> {
  final List<_Petal> _petals = [];
  final Random _rng = Random();
  final int petalCount;
  bool _initialized = false;

  HoaDaoComponent({this.petalCount = 20});

  static const _petalColors = [
    Color(0xFFFFB7C5), // Soft pink
    Color(0xFFFF69B4), // Hot pink
    Color(0xFFFFC0CB), // Pink
    Color(0xFFFFDAB9), // Peach
    Color(0xFFFF91A4), // Salmon pink
  ];

  @override
  void update(double dt) {
    super.update(dt);
    if (!_initialized) {
      for (int i = 0; i < petalCount; i++) {
        _petals.add(_Petal(
          x: _rng.nextDouble() * gameRef.size.x,
          y: _rng.nextDouble() * gameRef.size.y,
          size: _rng.nextDouble() * 8 + 4,
          speedY: _rng.nextDouble() * 30 + 15,
          speedX: _rng.nextDouble() * 20 - 10,
          rotation: _rng.nextDouble() * pi * 2,
          rotSpeed: (_rng.nextDouble() - 0.5) * 2,
          swayAmp: _rng.nextDouble() * 30 + 10,
          swayFreq: _rng.nextDouble() * 2 + 1,
          phase: _rng.nextDouble() * pi * 2,
          color: _petalColors[_rng.nextInt(_petalColors.length)],
          opacity: _rng.nextDouble() * 0.4 + 0.4,
        ));
      }
      _initialized = true;
    }

    for (final p in _petals) {
      p.y += p.speedY * dt;
      p.x += p.speedX * dt + sin(p.phase + p.y * 0.02) * p.swayAmp * dt;
      p.rotation += p.rotSpeed * dt;
      p.phase += p.swayFreq * dt;

      // Wrap around
      if (p.y > gameRef.size.y + 20) {
        p.y = -20;
        p.x = _rng.nextDouble() * gameRef.size.x;
      }
      if (p.x < -20) p.x = gameRef.size.x + 20;
      if (p.x > gameRef.size.x + 20) p.x = -20;
    }
  }

  @override
  void render(Canvas canvas) {
    for (final p in _petals) {
      canvas.save();
      canvas.translate(p.x, p.y);
      canvas.rotate(p.rotation);

      final paint = Paint()
        ..color = p.color.withValues(alpha: p.opacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1);

      // Draw petal shape (elongated oval)
      canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size * 0.6),
        paint,
      );
      // Smaller inner petal
      canvas.drawOval(
        Rect.fromCenter(center: const Offset(1, 1), width: p.size * 0.6, height: p.size * 0.35),
        Paint()..color = p.color.withValues(alpha: p.opacity * 0.5),
      );
      canvas.restore();
    }
  }
}

class _Petal {
  double x, y, size, speedY, speedX, rotation, rotSpeed, swayAmp, swayFreq, phase, opacity;
  Color color;
  _Petal({
    required this.x, required this.y, required this.size,
    required this.speedY, required this.speedX, required this.rotation,
    required this.rotSpeed, required this.swayAmp, required this.swayFreq,
    required this.phase, required this.color, required this.opacity,
  });
}

/// ━━━━━━━━━━━ GLOW TRAIL ━━━━━━━━━━━
/// Particle trail following drag position
class GlowTrailComponent extends Component with HasGameRef<FlameGame> {
  final List<_TrailParticle> _particles = [];
  final Random _rng = Random();
  Vector2 _lastPos = Vector2.zero();
  Color trailColor;

  GlowTrailComponent({this.trailColor = const Color(0xFF6C5CE7)});

  void addPoint(Vector2 pos) {
    if (pos.distanceTo(_lastPos) < 3) return;
    _lastPos = pos.clone();

    for (int i = 0; i < 3; i++) {
      _particles.add(_TrailParticle(
        x: pos.x + (_rng.nextDouble() - 0.5) * 10,
        y: pos.y + (_rng.nextDouble() - 0.5) * 10,
        size: _rng.nextDouble() * 6 + 4,
        life: 0.8,
        maxLife: 0.8,
        vx: (_rng.nextDouble() - 0.5) * 20,
        vy: (_rng.nextDouble() - 0.5) * 20,
      ));
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    _particles.removeWhere((p) => p.life <= 0);
    for (final p in _particles) {
      p.life -= dt;
      p.x += p.vx * dt;
      p.y += p.vy * dt;
      p.vx *= 0.95;
      p.vy *= 0.95;
    }
  }

  @override
  void render(Canvas canvas) {
    for (final p in _particles) {
      final progress = 1.0 - (p.life / p.maxLife);
      final opacity = (1.0 - progress).clamp(0.0, 1.0);
      final size = p.size * (1.0 - progress * 0.5);
      final paint = Paint()
        ..color = trailColor.withValues(alpha: opacity * 0.8)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7);
      canvas.drawCircle(Offset(p.x, p.y), size, paint);
    }
  }
}

class _TrailParticle {
  double x, y, size, life, maxLife, vx, vy;
  _TrailParticle({
    required this.x, required this.y, required this.size,
    required this.life, required this.maxLife,
    required this.vx, required this.vy,
  });
}

/// ━━━━━━━━━━━ COMBO TEXT ━━━━━━━━━━━
/// Animated combo text: scales up, glows, bounces, then fades
class ComboTextComponent extends Component with HasGameRef<FlameGame> {
  final String text;
  final double x, y;
  final Color color;
  double _elapsed = 0;
  static const double _totalDuration = 2.0;

  ComboTextComponent({
    required this.text,
    required this.x,
    required this.y,
    this.color = const Color(0xFFFFD700),
  });

  @override
  void update(double dt) {
    super.update(dt);
    _elapsed += dt;
    if (_elapsed >= _totalDuration) removeFromParent();
  }

  @override
  void render(Canvas canvas) {
    final progress = (_elapsed / _totalDuration).clamp(0.0, 1.0);

    // Scale: quick bounce up then settle
    double scale;
    if (progress < 0.15) {
      scale = 0.5 + (progress / 0.15) * 1.5; // 0.5 → 2.0
    } else if (progress < 0.3) {
      scale = 2.0 - ((progress - 0.15) / 0.15) * 0.7; // 2.0 → 1.3
    } else {
      scale = 1.3;
    }

    // Opacity: hold then fade
    final opacity = progress < 0.6 ? 1.0 : (1.0 - (progress - 0.6) / 0.4);

    // Y drift upward
    final yOff = -progress * 40;

    canvas.save();
    canvas.translate(x, y + yOff);
    canvas.scale(scale, scale);

    // Glow behind text
    final glowPaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 24);
    canvas.drawCircle(Offset.zero, 50, glowPaint);

    // Text
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color.withValues(alpha: opacity),
          fontSize: 36,
          fontWeight: FontWeight.w900,
          letterSpacing: 3,
          shadows: [
            Shadow(
              color: color.withValues(alpha: opacity * 0.9),
              blurRadius: 20,
            ),
            Shadow(
              color: const Color(0xFFFFFFFF).withValues(alpha: opacity * 0.4),
              blurRadius: 6,
            ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(-textPainter.width / 2, -textPainter.height / 2),
    );

    canvas.restore();
  }
}

/// ━━━━━━━━━━━ STAR BURST ━━━━━━━━━━━
/// Stars emanating from score area on milestones
class StarBurstComponent extends Component with HasGameRef<FlameGame> {
  final double centerX, centerY;
  final int count;
  final List<_Star> _stars = [];
  final Random _rng = Random();
  double _elapsed = 0;
  bool _initialized = false;
  static const double _duration = 3.0;

  static const _starColors = [
    Color(0xFFFFD700), // Gold
    Color(0xFFFFA500), // Orange
    Color(0xFFFFFF00), // Yellow
    Color(0xFFFF6347), // Tomato
  ];

  StarBurstComponent({
    required this.centerX,
    required this.centerY,
    this.count = 15,
  });

  @override
  void update(double dt) {
    super.update(dt);
    if (!_initialized) {
      for (int i = 0; i < count; i++) {
        final angle = _rng.nextDouble() * 2 * pi;
        final speed = _rng.nextDouble() * 220 + 160;
        _stars.add(_Star(
          x: 0, y: 0,
          vx: cos(angle) * speed,
          vy: sin(angle) * speed,
          rotation: _rng.nextDouble() * pi * 2,
          rotSpeed: (_rng.nextDouble() - 0.5) * 8,
          size: _rng.nextDouble() * 12 + 10,
          color: _starColors[_rng.nextInt(_starColors.length)],
        ));
      }
      _initialized = true;
    }

    _elapsed += dt;
    if (_elapsed >= _duration) {
      removeFromParent();
      return;
    }

    for (final s in _stars) {
      s.x += s.vx * dt;
      s.y += s.vy * dt;
      s.vy += 100 * dt; // gravity
      s.rotation += s.rotSpeed * dt;
      s.vx *= 0.99;
    }
  }

  @override
  void render(Canvas canvas) {
    final progress = (_elapsed / _duration).clamp(0.0, 1.0);
    final opacity = (1.0 - progress).clamp(0.0, 1.0);

    canvas.save();
    canvas.translate(centerX, centerY);

    for (final s in _stars) {
      canvas.save();
      canvas.translate(s.x, s.y);
      canvas.rotate(s.rotation);

      final paint = Paint()
        ..color = s.color.withValues(alpha: opacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

      // Draw 4-pointed star
      final path = Path();
      for (int i = 0; i < 4; i++) {
        final angle = (i * pi / 2);
        final outerX = cos(angle) * s.size;
        final outerY = sin(angle) * s.size;
        final innerAngle = angle + pi / 4;
        final innerX = cos(innerAngle) * s.size * 0.4;
        final innerY = sin(innerAngle) * s.size * 0.4;

        if (i == 0) {
          path.moveTo(outerX, outerY);
        } else {
          path.lineTo(outerX, outerY);
        }
        path.lineTo(innerX, innerY);
      }
      path.close();
      canvas.drawPath(path, paint);

      canvas.restore();
    }

    canvas.restore();
  }
}

class _Star {
  double x, y, vx, vy, rotation, rotSpeed, size;
  Color color;
  _Star({
    required this.x, required this.y, required this.vx, required this.vy,
    required this.rotation, required this.rotSpeed, required this.size,
    required this.color,
  });
}
