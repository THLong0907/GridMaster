import 'dart:ui';
import 'package:flame/components.dart';
import 'package:grid_master/features/game/domain/models/block_piece.dart';
import 'block_cell.dart';

/// A block piece in the pieces panel (no longer draggable by itself)
class BlockPieceComponent extends PositionComponent {
  final BlockPiece piece;
  final int index; // 0, 1, or 2
  final double cellSize;

  bool isDragging = false;
  Vector2 _originalPosition = Vector2.zero();
  bool _used = false;

  BlockPieceComponent({
    required this.piece,
    required this.index,
    required this.cellSize,
    required Vector2 position,
  }) : super(
         position: position,
         size: Vector2(piece.cols * cellSize, piece.rows * cellSize),
         anchor: Anchor.center,
       );

  bool get isUsed => _used;
  set used(bool value) => _used = value;

  @override
  void onMount() {
    super.onMount();
    _originalPosition = position.clone();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (_used) return;

    final drawScale = isDragging ? 1.0 : 0.7;
    final drawCellSize = cellSize * drawScale;

    // Center in component
    final offsetX = (size.x - piece.cols * drawCellSize) / 2;
    final offsetY = (size.y - piece.rows * drawCellSize) / 2;

    for (int r = 0; r < piece.rows; r++) {
      for (int c = 0; c < piece.cols; c++) {
        if (piece.shape[r][c]) {
          BlockCellRenderer.drawCell(
            canvas,
            offsetX + c * drawCellSize,
            offsetY + r * drawCellSize,
            drawCellSize,
            piece.colorIndex,
            opacity: isDragging ? 0.85 : 1.0,
          );
        }
      }
    }
  }

  /// Reset to original position
  void resetPosition() {
    isDragging = false;
    position = _originalPosition.clone();
  }

  /// Check if a world position is within this component
  bool containsWorldPoint(Vector2 worldPos) {
    if (_used) return false;
    final halfW = size.x / 2;
    final halfH = size.y / 2;
    return worldPos.x >= position.x - halfW &&
        worldPos.x <= position.x + halfW &&
        worldPos.y >= position.y - halfH &&
        worldPos.y <= position.y + halfH;
  }
}
