import 'package:flutter_test/flutter_test.dart';
import 'package:grid_master/features/game/domain/models/grid_model.dart';

void main() {
  group('GridModel', () {
    test('empty() creates grid of correct size', () {
      final grid = GridModel.empty(8);
      expect(grid.gridSize, 8);
      expect(grid.cells.length, 8);
      expect(grid.cells[0].length, 8);
    });

    test('empty() fills all cells with 0', () {
      final grid = GridModel.empty(5);
      for (int r = 0; r < 5; r++) {
        for (int c = 0; c < 5; c++) {
          expect(grid.cells[r][c], 0);
        }
      }
    });

    test('isEmpty() returns true for empty cells', () {
      final grid = GridModel.empty(3);
      expect(grid.isEmpty(0, 0), true);
      expect(grid.isEmpty(2, 2), true);
    });

    test('isEmpty() returns false for filled cells', () {
      final grid = GridModel.empty(3);
      grid.cells[1][1] = 3;
      expect(grid.isEmpty(1, 1), false);
    });

    test('getCell() returns correct value', () {
      final grid = GridModel.empty(3);
      grid.cells[0][2] = 5;
      expect(grid.getCell(0, 2), 5);
      expect(grid.getCell(0, 0), 0);
    });

    test('inBounds() returns true for valid positions', () {
      final grid = GridModel.empty(8);
      expect(grid.inBounds(0, 0), true);
      expect(grid.inBounds(7, 7), true);
      expect(grid.inBounds(4, 3), true);
    });

    test('inBounds() returns false for invalid positions', () {
      final grid = GridModel.empty(8);
      expect(grid.inBounds(-1, 0), false);
      expect(grid.inBounds(0, -1), false);
      expect(grid.inBounds(8, 0), false);
      expect(grid.inBounds(0, 8), false);
      expect(grid.inBounds(8, 8), false);
    });

    test('setCell() returns new grid with updated value', () {
      final grid = GridModel.empty(3);
      final updated = grid.setCell(1, 1, 7);

      // Original unchanged
      expect(grid.getCell(1, 1), 0);
      // New grid has the value
      expect(updated.getCell(1, 1), 7);
    });

    test('copy() creates deep copy', () {
      final grid = GridModel.empty(3);
      grid.cells[0][0] = 1;
      grid.cells[2][2] = 5;

      final copied = grid.copy();

      // Values match
      expect(copied.getCell(0, 0), 1);
      expect(copied.getCell(2, 2), 5);
      expect(copied.gridSize, 3);

      // Modifying copy doesn't affect original
      copied.cells[0][0] = 9;
      expect(grid.getCell(0, 0), 1);
      expect(copied.getCell(0, 0), 9);
    });

    test('filledCount returns correct count', () {
      final grid = GridModel.empty(3);
      expect(grid.filledCount, 0);

      grid.cells[0][0] = 1;
      grid.cells[1][1] = 2;
      grid.cells[2][2] = 3;
      expect(grid.filledCount, 3);
    });

    test('filledCount works with full grid', () {
      final grid = GridModel.empty(3);
      for (int r = 0; r < 3; r++) {
        for (int c = 0; c < 3; c++) {
          grid.cells[r][c] = 1;
        }
      }
      expect(grid.filledCount, 9);
    });

    test('toString() represents grid correctly', () {
      final grid = GridModel.empty(3);
      grid.cells[0][0] = 1;
      grid.cells[1][1] = 2;
      final str = grid.toString();
      expect(str.contains('1'), true);
      expect(str.contains('2'), true);
      expect(str.contains('.'), true);
    });
  });
}
