import 'package:flutter_test/flutter_test.dart';
import 'package:grid_master/features/game/domain/models/grid_model.dart';
import 'package:grid_master/features/game/domain/models/block_piece.dart';
import 'package:grid_master/features/game/domain/logic/grid_logic.dart';

void main() {
  // Helper: create a simple 1x1 piece
  BlockPiece singlePiece([int color = 1]) => BlockPiece(
        shape: [
          [true]
        ],
        colorIndex: color,
      );

  // Helper: create a 1x3 horizontal piece
  BlockPiece hLine3([int color = 2]) => BlockPiece(
        shape: [
          [true, true, true]
        ],
        colorIndex: color,
      );

  // Helper: create a 2x2 square piece
  BlockPiece square2x2([int color = 3]) => BlockPiece(
        shape: [
          [true, true],
          [true, true],
        ],
        colorIndex: color,
      );

  // Helper: create an L-shaped piece
  BlockPiece lPiece([int color = 4]) => BlockPiece(
        shape: [
          [true, false],
          [true, false],
          [true, true],
        ],
        colorIndex: color,
      );

  group('GridLogic.canPlace', () {
    test('can place single piece on empty grid', () {
      final grid = GridModel.empty(8);
      expect(GridLogic.canPlace(grid, singlePiece(), 0, 0), true);
      expect(GridLogic.canPlace(grid, singlePiece(), 7, 7), true);
      expect(GridLogic.canPlace(grid, singlePiece(), 4, 3), true);
    });

    test('cannot place piece out of bounds', () {
      final grid = GridModel.empty(8);
      expect(GridLogic.canPlace(grid, singlePiece(), -1, 0), false);
      expect(GridLogic.canPlace(grid, singlePiece(), 0, -1), false);
      expect(GridLogic.canPlace(grid, singlePiece(), 8, 0), false);
      expect(GridLogic.canPlace(grid, singlePiece(), 0, 8), false);
    });

    test('cannot place horizontal line piece that extends beyond grid', () {
      final grid = GridModel.empty(8);
      // hLine3 is 1x3, placing at col 6 means cols 6,7,8 → 8 is out of bounds
      expect(GridLogic.canPlace(grid, hLine3(), 0, 6), false);
      // But col 5 is fine (5,6,7)
      expect(GridLogic.canPlace(grid, hLine3(), 0, 5), true);
    });

    test('cannot place piece on occupied cell', () {
      final grid = GridModel.empty(8);
      grid.cells[3][3] = 1;
      expect(GridLogic.canPlace(grid, singlePiece(), 3, 3), false);
    });

    test('can place piece adjacent to occupied cell', () {
      final grid = GridModel.empty(8);
      grid.cells[3][3] = 1;
      expect(GridLogic.canPlace(grid, singlePiece(), 3, 4), true);
      expect(GridLogic.canPlace(grid, singlePiece(), 4, 3), true);
    });

    test('L piece placement checks all cells', () {
      final grid = GridModel.empty(8);
      // Place L piece at (0,0) — occupies (0,0),(1,0),(2,0),(2,1)
      expect(GridLogic.canPlace(grid, lPiece(), 0, 0), true);

      // Block one of L's cells
      grid.cells[2][1] = 5;
      expect(GridLogic.canPlace(grid, lPiece(), 0, 0), false);
    });
  });

  group('GridLogic.placePiece', () {
    test('places single piece correctly', () {
      final grid = GridModel.empty(8);
      final result = GridLogic.placePiece(grid, singlePiece(5), 3, 4);

      expect(result.getCell(3, 4), 5);
      // Original grid unchanged
      expect(grid.getCell(3, 4), 0);
    });

    test('places 2x2 square correctly', () {
      final grid = GridModel.empty(8);
      final result = GridLogic.placePiece(grid, square2x2(3), 1, 1);

      expect(result.getCell(1, 1), 3);
      expect(result.getCell(1, 2), 3);
      expect(result.getCell(2, 1), 3);
      expect(result.getCell(2, 2), 3);
      // Adjacent cells remain empty
      expect(result.getCell(0, 0), 0);
      expect(result.getCell(3, 3), 0);
    });

    test('places L piece correctly', () {
      final grid = GridModel.empty(8);
      final result = GridLogic.placePiece(grid, lPiece(7), 0, 0);

      expect(result.getCell(0, 0), 7); // top-left of L
      expect(result.getCell(1, 0), 7); // middle-left
      expect(result.getCell(2, 0), 7); // bottom-left
      expect(result.getCell(2, 1), 7); // bottom-right
      expect(result.getCell(0, 1), 0); // not part of L shape
      expect(result.getCell(1, 1), 0); // not part of L shape
    });
  });

  group('GridLogic.checkAndClearLines', () {
    test('no lines cleared returns zero', () {
      final grid = GridModel.empty(3);
      grid.cells[0][0] = 1;

      final result = GridLogic.checkAndClearLines(grid, 1, 0);
      expect(result.linesCleared, 0);
      expect(result.clearedRows, isEmpty);
      expect(result.clearedCols, isEmpty);
    });

    test('full row is cleared', () {
      final grid = GridModel.empty(3);
      // Fill row 0
      grid.cells[0][0] = 1;
      grid.cells[0][1] = 2;
      grid.cells[0][2] = 3;

      final result = GridLogic.checkAndClearLines(grid, 1, 0);
      expect(result.linesCleared, 1);
      expect(result.clearedRows, [0]);
      // Row should be cleared
      expect(result.grid.isEmpty(0, 0), true);
      expect(result.grid.isEmpty(0, 1), true);
      expect(result.grid.isEmpty(0, 2), true);
    });

    test('full column is cleared', () {
      final grid = GridModel.empty(3);
      // Fill column 1
      grid.cells[0][1] = 1;
      grid.cells[1][1] = 2;
      grid.cells[2][1] = 3;

      final result = GridLogic.checkAndClearLines(grid, 1, 0);
      expect(result.linesCleared, 1);
      expect(result.clearedCols, [1]);
      // Column should be cleared
      expect(result.grid.isEmpty(0, 1), true);
      expect(result.grid.isEmpty(1, 1), true);
      expect(result.grid.isEmpty(2, 1), true);
    });

    test('simultaneous row and column clear', () {
      final grid = GridModel.empty(3);
      // Fill row 0 and column 0
      for (int i = 0; i < 3; i++) {
        grid.cells[0][i] = 1; // row 0
        grid.cells[i][0] = 2; // col 0
      }
      // Fill remaining cells to avoid cross-overlap issues
      grid.cells[0][0] = 3; // intersection

      final result = GridLogic.checkAndClearLines(grid, 1, 0);
      expect(result.linesCleared, 2); // 1 row + 1 col
      expect(result.clearedRows, contains(0));
      expect(result.clearedCols, contains(0));
    });

    test('scoring with single clear has correct points', () {
      final grid = GridModel.empty(3);
      // Fill row 0
      for (int i = 0; i < 3; i++) {
        grid.cells[0][i] = 1;
      }

      // cellsPlaced=1, streak=0
      final result = GridLogic.checkAndClearLines(grid, 1, 0);
      expect(result.pointsEarned, greaterThan(0));
      expect(result.linesCleared, 1);
    });

    test('higher streak gives more points', () {
      final grid3a = GridModel.empty(3);
      final grid3b = GridModel.empty(3);

      // Fill row 0 in both
      for (int i = 0; i < 3; i++) {
        grid3a.cells[0][i] = 1;
        grid3b.cells[0][i] = 1;
      }

      final resultStreak0 = GridLogic.checkAndClearLines(grid3a, 1, 0);
      final resultStreak3 = GridLogic.checkAndClearLines(grid3b, 1, 3);

      expect(resultStreak3.pointsEarned,
          greaterThan(resultStreak0.pointsEarned));
    });

    test('double clear gives more points than single', () {
      // Single clear
      final gridSingle = GridModel.empty(3);
      for (int i = 0; i < 3; i++) {
        gridSingle.cells[0][i] = 1;
      }
      final resultSingle = GridLogic.checkAndClearLines(gridSingle, 1, 0);

      // Double clear (2 rows)
      final gridDouble = GridModel.empty(3);
      for (int i = 0; i < 3; i++) {
        gridDouble.cells[0][i] = 1;
        gridDouble.cells[1][i] = 2;
      }
      final resultDouble = GridLogic.checkAndClearLines(gridDouble, 1, 0);

      expect(resultDouble.pointsEarned,
          greaterThan(resultSingle.pointsEarned));
      expect(resultDouble.linesCleared, 2);
    });

    test('non-full row is not cleared', () {
      final grid = GridModel.empty(3);
      grid.cells[0][0] = 1;
      grid.cells[0][1] = 2;
      // grid.cells[0][2] is empty

      final result = GridLogic.checkAndClearLines(grid, 1, 0);
      expect(result.linesCleared, 0);
      // Cells remain
      expect(result.grid.getCell(0, 0), 1);
      expect(result.grid.getCell(0, 1), 2);
    });
  });

  group('GridLogic.isGameOver', () {
    test('empty grid is not game over', () {
      final grid = GridModel.empty(8);
      final pieces = [singlePiece()];
      expect(GridLogic.isGameOver(grid, pieces), false);
    });

    test('empty piece list is game over', () {
      final grid = GridModel.empty(8);
      expect(GridLogic.isGameOver(grid, []), true);
    });

    test('full grid with no space is game over', () {
      final grid = GridModel.empty(3);
      for (int r = 0; r < 3; r++) {
        for (int c = 0; c < 3; c++) {
          grid.cells[r][c] = 1;
        }
      }
      expect(GridLogic.isGameOver(grid, [singlePiece()]), true);
    });

    test('nearly full grid with one space is not game over for 1x1 piece', () {
      final grid = GridModel.empty(3);
      for (int r = 0; r < 3; r++) {
        for (int c = 0; c < 3; c++) {
          grid.cells[r][c] = 1;
        }
      }
      grid.cells[2][2] = 0; // One empty cell
      expect(GridLogic.isGameOver(grid, [singlePiece()]), false);
    });

    test('nearly full grid is game over for large piece that doesnt fit', () {
      final grid = GridModel.empty(3);
      for (int r = 0; r < 3; r++) {
        for (int c = 0; c < 3; c++) {
          grid.cells[r][c] = 1;
        }
      }
      grid.cells[2][2] = 0; // One empty cell
      // 2x2 piece cannot fit
      expect(GridLogic.isGameOver(grid, [square2x2()]), true);
    });
  });

  group('GridLogic.pixelToGrid', () {
    test('converts pixel position to grid position', () {
      final result = GridLogic.pixelToGrid(50, 50, 40, 10, 10, 8);
      expect(result, isNotNull);
      expect(result!.$1, 1); // row
      expect(result.$2, 1); // col
    });

    test('returns null for out-of-bounds position', () {
      final result = GridLogic.pixelToGrid(5, 5, 40, 10, 10, 8);
      // (5-10)/40 = negative → should be null
      expect(result, isNull);
    });

    test('returns null for position beyond grid', () {
      // Grid is 8x8 with cellSize=40, origin at (10,10)
      // Max valid pixel: 10 + 8*40 = 330
      final result = GridLogic.pixelToGrid(350, 350, 40, 10, 10, 8);
      expect(result, isNull);
    });
  });
}
