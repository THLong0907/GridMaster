import 'package:grid_master/features/game/domain/models/grid_model.dart';
import 'package:grid_master/features/game/domain/models/block_piece.dart';
import 'package:grid_master/core/constants/game_constants.dart';

/// Result of placing a piece and checking for line clears
class PlaceResult {
  final GridModel grid;
  final int linesCleared;
  final List<int> clearedRows;
  final List<int> clearedCols;
  final int pointsEarned;

  const PlaceResult({
    required this.grid,
    required this.linesCleared,
    required this.clearedRows,
    required this.clearedCols,
    required this.pointsEarned,
  });
}

/// Core game logic — pure functions, no UI dependency
class GridLogic {
  GridLogic._();

  /// Check if a piece can be placed at (row, col) on the grid
  static bool canPlace(GridModel grid, BlockPiece piece, int row, int col) {
    for (int r = 0; r < piece.rows; r++) {
      for (int c = 0; c < piece.cols; c++) {
        if (!piece.shape[r][c]) continue;
        final gr = row + r;
        final gc = col + c;
        if (!grid.inBounds(gr, gc)) return false;
        if (!grid.isEmpty(gr, gc)) return false;
      }
    }
    return true;
  }

  /// Place a piece on the grid (assumes canPlace was checked)
  static GridModel placePiece(
    GridModel grid,
    BlockPiece piece,
    int row,
    int col,
  ) {
    final newGrid = grid.copy();
    for (int r = 0; r < piece.rows; r++) {
      for (int c = 0; c < piece.cols; c++) {
        if (piece.shape[r][c]) {
          newGrid.cells[row + r][col + c] = piece.colorIndex;
        }
      }
    }
    return newGrid;
  }

  /// Check for completed rows and columns, clear them, return result
  static PlaceResult checkAndClearLines(
    GridModel grid,
    int cellsPlaced,
    int streak,
  ) {
    final size = GameConstants.gridSize;
    final clearedRows = <int>[];
    final clearedCols = <int>[];

    // Check rows
    for (int r = 0; r < size; r++) {
      bool full = true;
      for (int c = 0; c < size; c++) {
        if (grid.isEmpty(r, c)) {
          full = false;
          break;
        }
      }
      if (full) clearedRows.add(r);
    }

    // Check columns
    for (int c = 0; c < size; c++) {
      bool full = true;
      for (int r = 0; r < size; r++) {
        if (grid.isEmpty(r, c)) {
          full = false;
          break;
        }
      }
      if (full) clearedCols.add(c);
    }

    final totalLinesCleared = clearedRows.length + clearedCols.length;

    // Clear the lines
    GridModel newGrid = grid;
    if (totalLinesCleared > 0) {
      final cells = grid.copy().cells;
      for (final r in clearedRows) {
        for (int c = 0; c < size; c++) {
          cells[r][c] = 0;
        }
      }
      for (final c in clearedCols) {
        for (int r = 0; r < size; r++) {
          cells[r][c] = 0;
        }
      }
      newGrid = GridModel(cells);
    }

    // Calculate points
    final clearMultiplier = GameConstants.getClearMultiplier(totalLinesCleared);
    final streakMultiplier = GameConstants.getStreakMultiplier(streak);
    final cellPoints = cellsPlaced * GameConstants.basePointsPerCell;
    final clearBonus =
        (totalLinesCleared *
                size *
                GameConstants.basePointsPerCell *
                clearMultiplier)
            .toInt();
    final totalPoints = ((cellPoints + clearBonus) * streakMultiplier).toInt();

    return PlaceResult(
      grid: newGrid,
      linesCleared: totalLinesCleared,
      clearedRows: clearedRows,
      clearedCols: clearedCols,
      pointsEarned: totalPoints,
    );
  }

  /// Check if any of the available pieces can be placed anywhere on the grid
  static bool isGameOver(GridModel grid, List<BlockPiece> availablePieces) {
    for (final piece in availablePieces) {
      for (int r = 0; r <= GameConstants.gridSize - piece.rows; r++) {
        for (int c = 0; c <= GameConstants.gridSize - piece.cols; c++) {
          if (canPlace(grid, piece, r, c)) {
            return false;
          }
        }
      }
    }
    return true;
  }

  /// Find the grid position (row, col) from a pixel position on the grid
  static (int row, int col)? pixelToGrid(
    double px,
    double py,
    double cellSize,
    double gridOriginX,
    double gridOriginY,
  ) {
    final col = ((px - gridOriginX) / cellSize).floor();
    final row = ((py - gridOriginY) / cellSize).floor();
    if (row >= 0 &&
        row < GameConstants.gridSize &&
        col >= 0 &&
        col < GameConstants.gridSize) {
      return (row, col);
    }
    return null;
  }
}
