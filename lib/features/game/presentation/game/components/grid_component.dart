import 'dart:ui';
import 'package:flame/components.dart';
import 'package:grid_master/core/constants/game_constants.dart';
import 'package:grid_master/features/game/domain/models/grid_model.dart';
import 'block_cell.dart';

/// Renders the 10x10 game grid with placed blocks
class GridComponent extends PositionComponent {
  GridModel _grid;
  final double cellSize;

  // Ghost block state
  List<(int, int)>? ghostCells;
  int ghostColorIndex = 0;
  bool ghostValid = true;

  // Hammer mode visual
  bool _hammerMode = false;

  GridComponent({
    required GridModel grid,
    required this.cellSize,
    required Vector2 position,
  }) : _grid = grid,
       super(
         position: position,
         size: Vector2.all(cellSize * GameConstants.gridSize),
       );

  set grid(GridModel value) => _grid = value;
  GridModel get grid => _grid;

  double get gridPixelSize => cellSize * GameConstants.gridSize;

  void setHammerMode(bool enabled) {
    _hammerMode = enabled;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final size = GameConstants.gridSize;

    // Draw grid background
    final bgPaint = Paint()..color = const Color(0xFF1A1A2E);
    final bgRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(-4, -4, gridPixelSize + 8, gridPixelSize + 8),
      const Radius.circular(12),
    );
    canvas.drawRRect(bgRRect, bgPaint);

    // Draw grid border (orange in hammer mode)
    final borderPaint = Paint()
      ..color = _hammerMode ? const Color(0xFFFF8E53) : const Color(0xFF2D2D5E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = _hammerMode ? 3 : 2;
    canvas.drawRRect(bgRRect, borderPaint);

    // Draw grid lines
    final linePaint = Paint()
      ..color = const Color(0xFF2A2A4A)
      ..strokeWidth = 0.5;
    for (int i = 1; i < size; i++) {
      final pos = i * cellSize;
      canvas.drawLine(Offset(pos, 0), Offset(pos, gridPixelSize), linePaint);
      canvas.drawLine(Offset(0, pos), Offset(gridPixelSize, pos), linePaint);
    }

    // Draw placed blocks
    for (int r = 0; r < size; r++) {
      for (int c = 0; c < size; c++) {
        final value = _grid.getCell(r, c);
        if (value != 0) {
          BlockCellRenderer.drawCell(
            canvas,
            c * cellSize,
            r * cellSize,
            cellSize,
            value,
          );
        }
      }
    }

    // Draw ghost block
    if (ghostCells != null) {
      for (final (r, c) in ghostCells!) {
        if (r >= 0 && r < size && c >= 0 && c < size) {
          if (ghostValid) {
            BlockCellRenderer.drawCell(
              canvas,
              c * cellSize,
              r * cellSize,
              cellSize,
              ghostColorIndex,
              opacity: GameConstants.ghostOpacity,
            );
          } else {
            final paint = Paint()..color = const Color(0x44FF0000);
            canvas.drawRRect(
              RRect.fromRectAndRadius(
                Rect.fromLTWH(
                  c * cellSize + 2,
                  r * cellSize + 2,
                  cellSize - 4,
                  cellSize - 4,
                ),
                const Radius.circular(4),
              ),
              paint,
            );
          }
        }
      }
    }
  }

  /// Update ghost block position
  void setGhost(List<(int, int)>? cells, int colorIndex, bool valid) {
    ghostCells = cells;
    ghostColorIndex = colorIndex;
    ghostValid = valid;
  }

  /// Clear ghost block
  void clearGhost() {
    ghostCells = null;
  }
}
