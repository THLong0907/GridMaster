import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:grid_master/features/game/domain/models/block_piece.dart';
import 'package:grid_master/features/game/domain/models/game_mode.dart';

void main() {
  group('BlockPiece', () {
    test('cellCount calculates correctly for single piece', () {
      final piece = BlockPiece(
        shape: [
          [true]
        ],
        colorIndex: 1,
      );
      expect(piece.cellCount, 1);
    });

    test('cellCount calculates correctly for L piece', () {
      final piece = BlockPiece(
        shape: [
          [true, false],
          [true, false],
          [true, true],
        ],
        colorIndex: 1,
      );
      expect(piece.cellCount, 4);
    });

    test('cellCount calculates correctly for 3x3 square', () {
      final piece = BlockPiece(
        shape: [
          [true, true, true],
          [true, true, true],
          [true, true, true],
        ],
        colorIndex: 1,
      );
      expect(piece.cellCount, 9);
    });

    test('rows and cols return correct dimensions', () {
      final piece = BlockPiece(
        shape: [
          [true, true, true],
          [false, true, false],
        ],
        colorIndex: 1,
      );
      expect(piece.rows, 2);
      expect(piece.cols, 3);
    });

    test('empty shape has 0 cols', () {
      final piece = BlockPiece(shape: [], colorIndex: 1);
      expect(piece.rows, 0);
      expect(piece.cols, 0);
    });
  });

  group('BlockPiece.randomForMode', () {
    test('generates piece with valid colorIndex (1-8)', () {
      final rng = Random(42);
      for (int i = 0; i < 50; i++) {
        final piece = BlockPiece.randomForMode(GameMode.easy, rng);
        expect(piece.colorIndex, greaterThanOrEqualTo(1));
        expect(piece.colorIndex, lessThanOrEqualTo(8));
      }
    });

    test('generates piece with non-empty shape', () {
      final rng = Random(42);
      for (final mode in GameMode.values) {
        for (int i = 0; i < 20; i++) {
          final piece = BlockPiece.randomForMode(mode, rng);
          expect(piece.rows, greaterThan(0));
          expect(piece.cols, greaterThan(0));
          expect(piece.cellCount, greaterThan(0));
        }
      }
    });

    test('pieces fit within their mode grid size', () {
      final rng = Random(42);
      for (final mode in GameMode.values) {
        for (int i = 0; i < 20; i++) {
          final piece = BlockPiece.randomForMode(mode, rng);
          expect(piece.rows, lessThanOrEqualTo(mode.gridSize));
          expect(piece.cols, lessThanOrEqualTo(mode.gridSize));
        }
      }
    });
  });

  group('BlockPiece.generateForMode', () {
    test('generates correct number of pieces', () {
      final pieces = BlockPiece.generateForMode(3, GameMode.easy);
      expect(pieces.length, 3);
    });

    test('generates 0 pieces when count is 0', () {
      final pieces = BlockPiece.generateForMode(0, GameMode.easy);
      expect(pieces.length, 0);
    });

    test('generates deterministic pieces with same seed', () {
      final pieces1 = BlockPiece.generateForMode(5, GameMode.easy, Random(99));
      final pieces2 = BlockPiece.generateForMode(5, GameMode.easy, Random(99));

      for (int i = 0; i < 5; i++) {
        expect(pieces1[i].colorIndex, pieces2[i].colorIndex);
        expect(pieces1[i].rows, pieces2[i].rows);
        expect(pieces1[i].cols, pieces2[i].cols);
      }
    });
  });
}
