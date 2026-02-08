import 'dart:ui';
import 'package:flame/components.dart';
import 'package:grid_master/core/constants/game_constants.dart';
import 'package:grid_master/core/constants/colors.dart';
import 'package:grid_master/features/game/domain/models/grid_model.dart';
import 'block_cell.dart';

/// Renders the game grid with placed blocks and dynamic theme
class GridComponent extends PositionComponent {
  GridModel _grid;
  final double cellSize;
  final int gridSize;

  // Ghost block state
  List<(int, int)>? ghostCells;
  int ghostColorIndex = 0;
  bool ghostValid = true;

  // Theme
  GridTheme _theme = GridTheme.themes[0];

  // Memory mode: which cells are visible
  bool memoryMode = false;
  Set<(int, int)> visibleCells = {};

  GridComponent({
    required GridModel grid,
    required this.cellSize,
    required this.gridSize,
    required Vector2 position,
  }) : _grid = grid,
       super(position: position, size: Vector2.all(cellSize * gridSize));

  set grid(GridModel value) => _grid = value;
  GridModel get grid => _grid;

  double get gridPixelSize => cellSize * gridSize;

  void setTheme(GridTheme theme) {
    _theme = theme;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Draw grid background with theme color
    final bgPaint = Paint()..color = _theme.bgColor;
    final bgRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(-4, -4, gridPixelSize + 8, gridPixelSize + 8),
      const Radius.circular(12),
    );
    canvas.drawRRect(bgRRect, bgPaint);

    // Accent glow border
    final glowPaint = Paint()
      ..color = _theme.accentGlow.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 6);
    canvas.drawRRect(bgRRect, glowPaint);

    // Grid border
    final borderPaint = Paint()
      ..color = _theme.borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(bgRRect, borderPaint);

    // Draw grid lines (thicker for visibility)
    final linePaint = Paint()
      ..color = _theme.gridLineColor
      ..strokeWidth = 1.5;
    for (int i = 1; i < gridSize; i++) {
      final pos = i * cellSize;
      canvas.drawLine(Offset(pos, 0), Offset(pos, gridPixelSize), linePaint);
      canvas.drawLine(Offset(0, pos), Offset(gridPixelSize, pos), linePaint);
    }

    // Draw cell dot pattern for empty cells
    final dotPaint = Paint()
      ..color = _theme.gridLineColor.withValues(alpha: 0.5);
    for (int r = 0; r < gridSize; r++) {
      for (int c = 0; c < gridSize; c++) {
        if (_grid.isEmpty(r, c)) {
          canvas.drawCircle(
            Offset(c * cellSize + cellSize / 2, r * cellSize + cellSize / 2),
            2.0,
            dotPaint,
          );
        }
      }
    }

    // Draw placed blocks
    for (int r = 0; r < gridSize; r++) {
      for (int c = 0; c < gridSize; c++) {
        final value = _grid.getCell(r, c);
        if (value != 0) {
          // Memory mode: only render visible cells
          if (memoryMode && !visibleCells.contains((r, c))) {
            continue;
          }
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
      final opacity = ghostValid
          ? GameConstants.ghostOpacity
          : GameConstants.ghostOpacity * 0.5;
      for (final (r, c) in ghostCells!) {
        if (r >= 0 && r < gridSize && c >= 0 && c < gridSize) {
          BlockCellRenderer.drawCell(
            canvas,
            c * cellSize,
            r * cellSize,
            cellSize,
            ghostColorIndex,
            opacity: opacity,
          );
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

  /// Memory mode: make all cells visible temporarily
  void revealAll() {
    for (int r = 0; r < gridSize; r++) {
      for (int c = 0; c < gridSize; c++) {
        if (!_grid.isEmpty(r, c)) {
          visibleCells.add((r, c));
        }
      }
    }
  }

  /// Memory mode: hide all cells
  void hideAll() {
    visibleCells.clear();
  }
}
