import 'package:flutter_test/flutter_test.dart';
import 'package:grid_master/features/game/domain/models/game_mode.dart';

void main() {
  group('GameMode', () {
    test('all modes have valid grid sizes', () {
      for (final mode in GameMode.values) {
        expect(mode.gridSize, greaterThanOrEqualTo(8));
        expect(mode.gridSize, lessThanOrEqualTo(12));
      }
    });

    test('specific grid sizes are correct', () {
      expect(GameMode.easy.gridSize, 8);
      expect(GameMode.classic.gridSize, 10);
      expect(GameMode.master.gridSize, 12);
      expect(GameMode.memory.gridSize, 8);
      expect(GameMode.zen.gridSize, 8);
      expect(GameMode.soloPvP.gridSize, 8);
    });

    test('hammer charges are correct', () {
      expect(GameMode.easy.hammerCharges, 3);
      expect(GameMode.classic.hammerCharges, 3);
      expect(GameMode.master.hammerCharges, 5);
      expect(GameMode.memory.hammerCharges, 3);
      expect(GameMode.zen.hammerCharges, 0);
      expect(GameMode.soloPvP.hammerCharges, 0);
    });

    test('all modes have non-empty display names', () {
      for (final mode in GameMode.values) {
        expect(mode.displayName.isNotEmpty, true);
      }
    });

    test('rising row interval only for classic', () {
      expect(GameMode.classic.risingRowInterval, 10);
      expect(GameMode.easy.risingRowInterval, 0);
      expect(GameMode.master.risingRowInterval, 0);
      expect(GameMode.zen.risingRowInterval, 0);
    });

    test('timer drop seconds only for master', () {
      expect(GameMode.master.timerDropSeconds, 8.0);
      expect(GameMode.easy.timerDropSeconds, 0);
      expect(GameMode.classic.timerDropSeconds, 0);
    });

    test('fromString parses correctly', () {
      expect(GameMode.fromString('easy'), GameMode.easy);
      expect(GameMode.fromString('classic'), GameMode.classic);
      expect(GameMode.fromString('master'), GameMode.master);
      expect(GameMode.fromString('memory'), GameMode.memory);
      expect(GameMode.fromString('zen'), GameMode.zen);
      expect(GameMode.fromString('soloPvP'), GameMode.soloPvP);
    });

    test('fromString returns easy for invalid input', () {
      expect(GameMode.fromString('invalid'), GameMode.easy);
      expect(GameMode.fromString(''), GameMode.easy);
    });
  });
}
