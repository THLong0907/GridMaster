import 'dart:math';
import 'package:grid_master/core/constants/colors.dart';

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

  // Single dot
  static final _single = _parse([
    [1],
  ]);

  // 1x2
  static final _dot2H = _parse([
    [1, 1],
  ]);
  static final _dot2V = _parse([
    [1],
    [1],
  ]);

  // 1x3
  static final _dot3H = _parse([
    [1, 1, 1],
  ]);
  static final _dot3V = _parse([
    [1],
    [1],
    [1],
  ]);

  // 1x4 (I-block)
  static final _iBlockH = _parse([
    [1, 1, 1, 1],
  ]);
  static final _iBlockV = _parse([
    [1],
    [1],
    [1],
    [1],
  ]);

  // 1x5
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

  // 2x2 (O-block)
  static final _oBlock = _parse([
    [1, 1],
    [1, 1],
  ]);

  // L-blocks
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

  // T-block
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

  // S-block
  static final _sBlock1 = _parse([
    [0, 1, 1],
    [1, 1, 0],
  ]);
  static final _sBlock2 = _parse([
    [1, 0],
    [1, 1],
    [0, 1],
  ]);

  // Z-block
  static final _zBlock1 = _parse([
    [1, 1, 0],
    [0, 1, 1],
  ]);
  static final _zBlock2 = _parse([
    [0, 1],
    [1, 1],
    [1, 0],
  ]);

  // Corner blocks (2x2 with one cell removed)
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

  // 3x3 big square
  static final _bigSquare = _parse([
    [1, 1, 1],
    [1, 1, 1],
    [1, 1, 1],
  ]);

  /// All available shape templates
  static final List<List<List<bool>>> allShapes = [
    _single,
    _dot2H,
    _dot2V,
    _dot3H,
    _dot3V,
    _iBlockH,
    _iBlockV,
    _dot5H,
    _dot5V,
    _oBlock,
    _lBlock1,
    _lBlock2,
    _lBlock3,
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
  ];

  /// Generate a random BlockPiece
  static BlockPiece random([Random? rng]) {
    final random = rng ?? Random();
    final shape = allShapes[random.nextInt(allShapes.length)];
    final colorIndex = random.nextInt(BlockColors.colorCount) + 1;
    return BlockPiece(shape: shape, colorIndex: colorIndex);
  }

  /// Generate N random pieces
  static List<BlockPiece> generateRandom(int count, [Random? rng]) {
    return List.generate(count, (_) => random(rng));
  }
}
