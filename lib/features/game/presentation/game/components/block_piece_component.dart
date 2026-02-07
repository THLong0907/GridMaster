import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:grid_master/core/constants/game_constants.dart';
import 'package:grid_master/features/game/domain/models/block_piece.dart';
import 'block_cell.dart';

/// Callback types for drag events
typedef PieceDragStartCallback = void Function(BlockPieceComponent comp);
typedef PieceDragUpdateCallback =
    void Function(BlockPieceComponent comp, Vector2 worldPos);
typedef PieceDragEndCallback =
    void Function(BlockPieceComponent comp, Vector2 worldPos);

/// A draggable block piece in the pieces panel
class BlockPieceComponent extends PositionComponent with DragCallbacks {
  final BlockPiece piece;
  final int index; // 0, 1, or 2
  final double cellSize;
  final PieceDragUpdateCallback onPieceDragUpdate;
  final PieceDragEndCallback onPieceDragEnd;
  final PieceDragStartCallback onPieceDragStart;

  bool _isDragging = false;
  Vector2 _originalPosition = Vector2.zero();
  bool _used = false;

  BlockPieceComponent({
    required this.piece,
    required this.index,
    required this.cellSize,
    required this.onPieceDragUpdate,
    required this.onPieceDragEnd,
    required this.onPieceDragStart,
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

    final drawScale = _isDragging ? 1.0 : 0.7;
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
            opacity: _isDragging ? 0.85 : 1.0,
          );
        }
      }
    }
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    if (_used) return;
    _isDragging = true;
    onPieceDragStart(this);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    if (!_isDragging) return;
    position += event.localDelta;
    // Apply finger offset — show block above touch point
    onPieceDragUpdate(
      this,
      Vector2(position.x, position.y - GameConstants.fingerOffset),
    );
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    if (!_isDragging) return;
    _isDragging = false;
    onPieceDragEnd(
      this,
      Vector2(position.x, position.y - GameConstants.fingerOffset),
    );
  }

  /// Reset to original position
  void resetPosition() {
    position = _originalPosition.clone();
  }
}
