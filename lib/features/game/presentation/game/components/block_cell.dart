import 'dart:ui';
import 'package:grid_master/core/constants/colors.dart';
import 'package:grid_master/core/constants/game_constants.dart';

/// Renders a single glossy block cell on the canvas
class BlockCellRenderer {
  BlockCellRenderer._();

  /// Draw a glossy block cell at the given position
  static void drawCell(
    Canvas canvas,
    double x,
    double y,
    double size,
    int colorIndex, {
    double opacity = 1.0,
  }) {
    final colors = BlockColors.getColor(colorIndex);
    final cellPadding = size * 0.08;
    final cellSize = size - cellPadding * 2;
    final cx = x + cellPadding;
    final cy = y + cellPadding;
    final radius = GameConstants.cellBorderRadius;
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(cx, cy, cellSize, cellSize),
      Radius.circular(radius),
    );

    // Shadow
    final shadowPaint = Paint()
      ..color = colors.dark.withValues(alpha: 0.5 * opacity)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
    canvas.drawRRect(rrect.shift(const Offset(2, 2)), shadowPaint);

    // Dark base
    final basePaint = Paint()..color = colors.dark.withValues(alpha: opacity);
    canvas.drawRRect(rrect, basePaint);

    // Main face (slightly smaller)
    final faceRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(cx + 1, cy + 1, cellSize - 2, cellSize - 2),
      Radius.circular(radius - 0.5),
    );
    final facePaint = Paint()..color = colors.main.withValues(alpha: opacity);
    canvas.drawRRect(faceRect, facePaint);

    // Glossy highlight (top gradient)
    final highlightRect = Rect.fromLTWH(
      cx + 2,
      cy + 2,
      cellSize - 4,
      cellSize * 0.45,
    );
    final highlightRRect = RRect.fromRectAndRadius(
      highlightRect,
      Radius.circular(radius - 1),
    );
    final highlightPaint = Paint()
      ..shader = Gradient.linear(
        Offset(highlightRect.left, highlightRect.top),
        Offset(highlightRect.left, highlightRect.bottom),
        [
          colors.light.withValues(alpha: 0.7 * opacity),
          colors.light.withValues(alpha: 0.0),
        ],
      );
    canvas.drawRRect(highlightRRect, highlightPaint);

    // Inner glow dot
    final glowPaint = Paint()
      ..color = const Color.fromRGBO(255, 255, 255, 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawCircle(
      Offset(cx + cellSize * 0.35, cy + cellSize * 0.3),
      cellSize * 0.12,
      glowPaint,
    );
  }
}
