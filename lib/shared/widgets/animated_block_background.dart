import 'dart:math';
import 'package:flutter/material.dart';
import 'package:grid_master/core/constants/colors.dart';

/// Animated background with floating block shapes
/// Used on both lobby and game screens
class AnimatedBlockBackground extends StatefulWidget {
  /// Accent color for tinting (defaults to purple)
  final Color accentColor;

  /// Background gradient colors
  final Color bgColor1;
  final Color bgColor2;

  /// Number of block shapes to scatter
  final int shapeCount;

  const AnimatedBlockBackground({
    super.key,
    this.accentColor = const Color(0xFF6C5CE7),
    this.bgColor1 = const Color(0xFF0D0D1A),
    this.bgColor2 = const Color(0xFF1A1A3E),
    this.shapeCount = 14,
  });

  @override
  State<AnimatedBlockBackground> createState() =>
      _AnimatedBlockBackgroundState();
}

class _AnimatedBlockBackgroundState extends State<AnimatedBlockBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_BgBlockShape> _shapes;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat();

    _regenerateShapes();
  }

  /// Generate new random shapes — called each time widget is built
  void _regenerateShapes() {
    final rng = Random();
    _shapes = List.generate(
      widget.shapeCount,
      (_) => _BgBlockShape.random(rng),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient background
        AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [widget.bgColor1, widget.bgColor2, widget.bgColor1],
            ),
          ),
        ),

        // Floating block shapes
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return CustomPaint(
              size: MediaQuery.of(context).size,
              painter: _BgBlocksPainter(
                shapes: _shapes,
                t: _controller.value,
                accentColor: widget.accentColor,
              ),
            );
          },
        ),
      ],
    );
  }
}

// ============ BLOCK SHAPE DEFINITIONS ============

class _ShapeDefs {
  static const List<List<List<int>>> shapes = [
    // L-block
    [
      [1, 0],
      [1, 0],
      [1, 1],
    ],
    // Reverse L
    [
      [0, 1],
      [0, 1],
      [1, 1],
    ],
    // T-block
    [
      [1, 1, 1],
      [0, 1, 0],
    ],
    // S-block
    [
      [0, 1, 1],
      [1, 1, 0],
    ],
    // Z-block
    [
      [1, 1, 0],
      [0, 1, 1],
    ],
    // O-block
    [
      [1, 1],
      [1, 1],
    ],
    // I-block horizontal
    [
      [1, 1, 1, 1],
    ],
    // I-block vertical
    [
      [1],
      [1],
      [1],
      [1],
    ],
    // Corner
    [
      [1, 1],
      [1, 0],
    ],
    // Plus
    [
      [0, 1, 0],
      [1, 1, 1],
      [0, 1, 0],
    ],
    // Big square
    [
      [1, 1, 1],
      [1, 1, 1],
      [1, 1, 1],
    ],
    // 3-line
    [
      [1, 1, 1],
    ],
    // Single
    [
      [1],
    ],
    // 2-dot
    [
      [1, 1],
    ],
  ];
}

// ============ BACKGROUND SHAPE DATA ============

class _BgBlockShape {
  final double x;
  final double y;
  final double rotation;
  final double scale;
  final double driftSpeedX;
  final double driftSpeedY;
  final double rotateSpeed;
  final double phase;
  final int shapeIndex;
  final int colorIndex;

  _BgBlockShape({
    required this.x,
    required this.y,
    required this.rotation,
    required this.scale,
    required this.driftSpeedX,
    required this.driftSpeedY,
    required this.rotateSpeed,
    required this.phase,
    required this.shapeIndex,
    required this.colorIndex,
  });

  factory _BgBlockShape.random(Random rng) {
    return _BgBlockShape(
      x: rng.nextDouble(),
      y: rng.nextDouble(),
      rotation: rng.nextDouble() * 3.14159 * 2,
      scale: 0.7 + rng.nextDouble() * 0.9,
      driftSpeedX: (rng.nextDouble() - 0.5) * 0.2,
      driftSpeedY: (rng.nextDouble() - 0.5) * 0.15,
      rotateSpeed: (rng.nextDouble() - 0.5) * 0.4,
      phase: rng.nextDouble() * 6.28,
      shapeIndex: rng.nextInt(_ShapeDefs.shapes.length),
      colorIndex: rng.nextInt(BlockColors.colorCount) + 1,
    );
  }
}

// ============ PAINTER ============

class _BgBlocksPainter extends CustomPainter {
  final List<_BgBlockShape> shapes;
  final double t;
  final Color accentColor;

  _BgBlocksPainter({
    required this.shapes,
    required this.t,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const cellSize = 26.0;

    for (final shape in shapes) {
      final shapeData = _ShapeDefs.shapes[shape.shapeIndex];
      final rows = shapeData.length;
      final cols = shapeData[0].length;

      // Animated position with wrapping
      final cx =
          ((shape.x +
                  shape.driftSpeedX * t +
                  _sin(t * 6.28 + shape.phase) * 0.03) %
              1.0) *
          size.width;
      final cy =
          ((shape.y +
                  shape.driftSpeedY * t +
                  _cos(t * 6.28 + shape.phase * 1.3) * 0.02) %
              1.0) *
          size.height;
      final rotation = shape.rotation + shape.rotateSpeed * t * 6.28;

      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate(rotation);
      canvas.scale(shape.scale);

      final colors = BlockColors.getColor(shape.colorIndex);
      final fillPaint = Paint()
        ..color = colors.main.withValues(alpha: 0.12)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
      final borderPaint = Paint()
        ..color = colors.light.withValues(alpha: 0.08)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;

      final offsetX = -cols * cellSize / 2;
      final offsetY = -rows * cellSize / 2;

      for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
          if (shapeData[r][c] == 1) {
            final rect = RRect.fromRectAndRadius(
              Rect.fromLTWH(
                offsetX + c * cellSize + 1,
                offsetY + r * cellSize + 1,
                cellSize - 2,
                cellSize - 2,
              ),
              const Radius.circular(4),
            );
            canvas.drawRRect(rect, fillPaint);
            canvas.drawRRect(rect, borderPaint);
          }
        }
      }

      canvas.restore();
    }
  }

  double _sin(double v) {
    v = v % 6.28318;
    if (v > 3.14159) v -= 6.28318;
    return v - (v * v * v) / 6 + (v * v * v * v * v) / 120;
  }

  double _cos(double v) => _sin(v + 1.5708);

  @override
  bool shouldRepaint(covariant _BgBlocksPainter old) => true;
}
