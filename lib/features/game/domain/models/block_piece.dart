import 'dart:math';
import 'package:grid_master/core/constants/colors.dart';
import 'package:grid_master/features/game/domain/models/game_mode.dart';

/// Represents a block piece shape that the player can place on the grid.
class BlockPiece {
  /// 2D shape matrix (true = filled cell)
  final List<List<bool>> shape;

  /// Color index (1-8, matching BlockColors)
  final int colorIndex;

  const BlockPiece({required this.shape, required this.colorIndex});

  int get rows => shape.length;
  int get cols => shape.isEmpty ? 0 : shape[0].length;

  /// Count of filled cells in this piece
  int get cellCount {
    int count = 0;
    for (final row in shape) {
      for (final cell in row) {
        if (cell) count++;
      }
    }
    return count;
  }

  // ============ SHAPE DEFINITIONS ============

  static List<List<bool>> _parse(List<List<int>> raw) {
    return raw.map((row) => row.map((v) => v == 1).toList()).toList();
  }

  static final _single = _parse([
    [1],
  ]);

  static final _dot2H = _parse([
    [1, 1],
  ]);
  static final _dot2V = _parse([
    [1],
    [1],
  ]);

  static final _dot3H = _parse([
    [1, 1, 1],
  ]);
  static final _dot3V = _parse([
    [1],
    [1],
    [1],
  ]);

  static final _iBlockH = _parse([
    [1, 1, 1, 1],
  ]);
  static final _iBlockV = _parse([
    [1],
    [1],
    [1],
    [1],
  ]);

  // 1×5 (Classic + Master only)
  static final _dot5H = _parse([
    [1, 1, 1, 1, 1],
  ]);
  static final _dot5V = _parse([
    [1],
    [1],
    [1],
    [1],
    [1],
  ]);

  static final _oBlock = _parse([
    [1, 1],
    [1, 1],
  ]);

  static final _lBlock1 = _parse([
    [1, 0],
    [1, 0],
    [1, 1],
  ]);
  static final _lBlock2 = _parse([
    [0, 1],
    [0, 1],
    [1, 1],
  ]);
  static final _lBlock3 = _parse([
    [1, 1],
    [1, 0],
    [1, 0],
  ]);
  static final _lBlock4 = _parse([
    [1, 1],
    [0, 1],
    [0, 1],
  ]);

  static final _tBlock1 = _parse([
    [1, 1, 1],
    [0, 1, 0],
  ]);
  static final _tBlock2 = _parse([
    [0, 1, 0],
    [1, 1, 1],
  ]);
  static final _tBlock3 = _parse([
    [1, 0],
    [1, 1],
    [1, 0],
  ]);
  static final _tBlock4 = _parse([
    [0, 1],
    [1, 1],
    [0, 1],
  ]);

  static final _sBlock1 = _parse([
    [0, 1, 1],
    [1, 1, 0],
  ]);
  static final _sBlock2 = _parse([
    [1, 0],
    [1, 1],
    [0, 1],
  ]);

  static final _zBlock1 = _parse([
    [1, 1, 0],
    [0, 1, 1],
  ]);
  static final _zBlock2 = _parse([
    [0, 1],
    [1, 1],
    [1, 0],
  ]);

  static final _corner1 = _parse([
    [1, 1],
    [1, 0],
  ]);
  static final _corner2 = _parse([
    [1, 1],
    [0, 1],
  ]);
  static final _corner3 = _parse([
    [1, 0],
    [1, 1],
  ]);
  static final _corner4 = _parse([
    [0, 1],
    [1, 1],
  ]);

  static final _bigSquare = _parse([
    [1, 1, 1],
    [1, 1, 1],
    [1, 1, 1],
  ]);

  // ============ PER-MODE WEIGHTED POOLS ============

  /// Easy: 65% small pieces
  static final List<List<List<bool>>> _easyPool = [
    _single,
    _single,
    _single,
    _single,
    _dot2H,
    _dot2H,
    _dot2H,
    _dot2V,
    _dot2V,
    _dot2V,
    _dot3H,
    _dot3H,
    _dot3H,
    _dot3V,
    _dot3V,
    _dot3V,
    _corner1,
    _corner1,
    _corner2,
    _corner2,
    _corner3,
    _corner3,
    _corner4,
    _corner4,
    _iBlockH,
    _iBlockH,
    _iBlockV,
    _iBlockV,
    _oBlock,
    _oBlock,
    _tBlock1,
    _tBlock2,
    _tBlock3,
    _tBlock4,
    _sBlock1,
    _sBlock2,
    _zBlock1,
    _zBlock2,
    _lBlock1,
    _lBlock2,
    _lBlock3,
    _lBlock4,
    _bigSquare,
  ];

  /// Classic: balanced + 1×5 pieces
  static final List<List<List<bool>>> _classicPool = [
    _single, _single,
    _dot2H, _dot2V,
    _dot3H, _dot3V,
    _iBlockH, _iBlockV,
    _dot5H, _dot5V, // 1×5 lines!
    _oBlock,
    _lBlock1, _lBlock2, _lBlock3, _lBlock4,
    _tBlock1, _tBlock2, _tBlock3, _tBlock4,
    _sBlock1, _sBlock2, _zBlock1, _zBlock2,
    _corner1, _corner2, _corner3, _corner4,
    _bigSquare,
  ];

  /// Master: more big pieces
  static final List<List<List<bool>>> _masterPool = [
    _single,
    _dot2H,
    _dot2V,
    _dot3H,
    _dot3V,
    _iBlockH,
    _iBlockH,
    _iBlockV,
    _iBlockV,
    _dot5H,
    _dot5H,
    _dot5V,
    _dot5V,
    _oBlock,
    _oBlock,
    _lBlock1,
    _lBlock1,
    _lBlock2,
    _lBlock2,
    _lBlock3,
    _lBlock3,
    _lBlock4,
    _lBlock4,
    _tBlock1,
    _tBlock2,
    _tBlock3,
    _tBlock4,
    _sBlock1,
    _sBlock2,
    _zBlock1,
    _zBlock2,
    _corner1,
    _corner2,
    _corner3,
    _corner4,
    _bigSquare,
    _bigSquare,
  ];

  /// Get the pool for a given mode
  static List<List<List<bool>>> _poolForMode(GameMode mode) {
    switch (mode) {
      case GameMode.easy:
      case GameMode.memory:
      case GameMode.zen:
      case GameMode.soloPvP:
        return _easyPool;
      case GameMode.classic:
        return _classicPool;
      case GameMode.master:
        return _masterPool;
    }
  }

  /// Generate a random piece for a given mode
  static BlockPiece randomForMode(GameMode mode, [Random? rng]) {
    final random = rng ?? Random();
    final pool = _poolForMode(mode);
    final shape = pool[random.nextInt(pool.length)];
    final colorIndex = random.nextInt(BlockColors.colorCount) + 1;
    return BlockPiece(shape: shape, colorIndex: colorIndex);
  }

  /// Generate a random BlockPiece (legacy, uses easy pool)
  static BlockPiece random([Random? rng]) {
    return randomForMode(GameMode.easy, rng);
  }

  /// Generate N random pieces for a mode
  static List<BlockPiece> generateForMode(
    int count,
    GameMode mode, [
    Random? rng,
  ]) {
    return List.generate(count, (_) => randomForMode(mode, rng));
  }

  /// Generate N random pieces (legacy)
  static List<BlockPiece> generateRandom(
    int count, {
    int score = 0,
    Random? rng,
  }) {
    return List.generate(count, (_) => random(rng));
  }
}
