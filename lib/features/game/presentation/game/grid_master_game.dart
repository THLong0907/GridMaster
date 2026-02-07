import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'dart:ui';

import 'package:grid_master/core/constants/game_constants.dart';
import 'package:grid_master/features/game/domain/models/grid_model.dart';
import 'package:grid_master/features/game/domain/models/block_piece.dart';
import 'package:grid_master/features/game/domain/logic/grid_logic.dart';
import 'package:grid_master/shared/services/haptic_service.dart';
import 'components/grid_component.dart';
import 'components/block_piece_component.dart';
import 'effects/clear_effect.dart';

/// Main Grid Master game powered by Flame Engine
class GridMasterGame extends FlameGame {
  // State
  late GridModel _grid;
  late List<BlockPiece> _currentPieces;
  late List<bool> _usedPieces;
  int _score = 0;
  int _highScore = 0;
  int _streak = 0;
  int _hammerCharges = GameConstants.maxHammerCharges;
  bool _hammerMode = false;

  // Components
  late GridComponent _gridComponent;
  final List<BlockPieceComponent> _pieceComponents = [];

  // Layout
  late double _cellSize;
  late double _gridOriginX;
  late double _gridOriginY;

  // Callbacks to Flutter overlay
  Function(int score, int streak, int linesCleared, String? message)?
  onScoreChanged;
  Function(int score, int highScore, bool isNewHigh)? onGameOver;
  Function()? onPiecePlaced;
  Function(int hammerCharges)? onHammerChanged;

  int get score => _score;
  int get highScore => _highScore;
  int get streak => _streak;
  int get hammerCharges => _hammerCharges;
  bool get isHammerMode => _hammerMode;

  void setHighScore(int value) => _highScore = value;

  @override
  Color backgroundColor() => const Color(0xFF0D0D1A);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _startNewGame();
  }

  void _startNewGame() {
    _grid = GridModel.empty();
    _score = 0;
    _streak = 0;
    _hammerCharges = GameConstants.maxHammerCharges;
    _hammerMode = false;
    _currentPieces = BlockPiece.generateRandom(GameConstants.piecesPerRound);
    _usedPieces = List.filled(GameConstants.piecesPerRound, false);

    _layoutComponents();
    onHammerChanged?.call(_hammerCharges);
  }

  void _layoutComponents() {
    // Remove old components (preserve particle effects)
    final particlesToKeep = children
        .whereType<ParticleSystemComponent>()
        .toList();
    removeAll(children.toList());
    _pieceComponents.clear();

    // Calculate cell size to fit screen
    final screenW = size.x;
    final screenH = size.y;
    final gridMaxSize = screenW * 0.9;
    _cellSize = gridMaxSize / GameConstants.gridSize;
    final gridPixelSize = _cellSize * GameConstants.gridSize;

    _gridOriginX = (screenW - gridPixelSize) / 2;
    _gridOriginY = screenH * 0.12;

    // Create grid component
    _gridComponent = GridComponent(
      grid: _grid,
      cellSize: _cellSize,
      position: Vector2(_gridOriginX, _gridOriginY),
    );
    add(_gridComponent);

    // Re-add particle effects
    for (final p in particlesToKeep) {
      add(p);
    }

    // Create piece components below the grid
    final panelY = _gridOriginY + gridPixelSize + screenH * 0.06;
    final panelWidth = screenW * 0.85;
    final pieceSlotWidth = panelWidth / GameConstants.piecesPerRound;

    for (int i = 0; i < _currentPieces.length; i++) {
      if (_usedPieces[i]) continue;
      final piece = _currentPieces[i];
      final pieceComp = BlockPieceComponent(
        piece: piece,
        index: i,
        cellSize: _cellSize,
        position: Vector2(
          (screenW - panelWidth) / 2 + pieceSlotWidth * i + pieceSlotWidth / 2,
          panelY + _cellSize * 2,
        ),
        onPieceDragStart: _onPieceDragStart,
        onPieceDragUpdate: _onPieceDragUpdate,
        onPieceDragEnd: _onPieceDragEnd,
      );
      _pieceComponents.add(pieceComp);
      add(pieceComp);
    }
  }

  // Drag handlers
  void _onPieceDragStart(BlockPieceComponent comp) {
    HapticService.lightTap();
  }

  void _onPieceDragUpdate(BlockPieceComponent comp, Vector2 worldPos) {
    final piece = comp.piece;
    final gridLocalX = worldPos.x - _gridOriginX - (piece.cols * _cellSize / 2);
    final gridLocalY = worldPos.y - _gridOriginY - (piece.rows * _cellSize / 2);

    final startCol = (gridLocalX / _cellSize).round();
    final startRow = (gridLocalY / _cellSize).round();

    final cells = <(int, int)>[];
    for (int r = 0; r < piece.rows; r++) {
      for (int c = 0; c < piece.cols; c++) {
        if (piece.shape[r][c]) {
          cells.add((startRow + r, startCol + c));
        }
      }
    }

    final valid = GridLogic.canPlace(_grid, piece, startRow, startCol);
    _gridComponent.setGhost(cells, piece.colorIndex, valid);
  }

  void _onPieceDragEnd(BlockPieceComponent comp, Vector2 worldPos) {
    _gridComponent.clearGhost();

    final piece = comp.piece;
    final gridLocalX = worldPos.x - _gridOriginX - (piece.cols * _cellSize / 2);
    final gridLocalY = worldPos.y - _gridOriginY - (piece.rows * _cellSize / 2);

    final startCol = (gridLocalX / _cellSize).round();
    final startRow = (gridLocalY / _cellSize).round();

    if (GridLogic.canPlace(_grid, piece, startRow, startCol)) {
      // Place piece
      _grid = GridLogic.placePiece(_grid, piece, startRow, startCol);
      _usedPieces[comp.index] = true;
      comp.used = true;
      HapticService.piecePlaced();

      // Check & clear lines
      final result = GridLogic.checkAndClearLines(
        _grid,
        piece.cellCount,
        _streak,
      );
      _grid = result.grid;
      _score += result.pointsEarned;

      String? message;
      if (result.linesCleared > 0) {
        _streak++;
        message = _getClearText(result.linesCleared);

        // === PARTICLE EFFECTS ===
        _spawnClearParticles(
          result.clearedRows,
          result.clearedCols,
          isTriple: result.linesCleared >= 3,
        );

        // === HAPTIC FEEDBACK ===
        if (result.linesCleared >= 3) {
          HapticService.tripleClear();
        } else {
          HapticService.lineClear();
        }
      } else {
        _streak = 0;
      }

      _gridComponent.grid = _grid;
      onScoreChanged?.call(_score, _streak, result.linesCleared, message);
      onPiecePlaced?.call();

      // Check if all 3 pieces used — generate new set
      if (_usedPieces.every((u) => u)) {
        _currentPieces = BlockPiece.generateRandom(
          GameConstants.piecesPerRound,
        );
        _usedPieces = List.filled(GameConstants.piecesPerRound, false);
        _layoutComponents();
      } else {
        _pieceComponents.remove(comp);
        comp.removeFromParent();
      }

      // Check game over
      _checkGameOver();
    } else {
      comp.resetPosition();
    }
  }

  /// Spawn particle effects for cleared lines
  void _spawnClearParticles(
    List<int> clearedRows,
    List<int> clearedCols, {
    bool isTriple = false,
  }) {
    final gridSize = GameConstants.gridSize;

    // Cell burst particles for each cleared cell
    for (final r in clearedRows) {
      for (int c = 0; c < gridSize; c++) {
        add(
          ClearEffectFactory.createCellBurst(
            x: _gridOriginX + c * _cellSize,
            y: _gridOriginY + r * _cellSize,
            cellSize: _cellSize,
            colorIndex: 1 + (c % 8),
            isTriple: isTriple,
          ),
        );
      }
    }
    for (final c in clearedCols) {
      for (int r = 0; r < gridSize; r++) {
        // Skip cells already handled by row clears
        if (!clearedRows.contains(r)) {
          add(
            ClearEffectFactory.createCellBurst(
              x: _gridOriginX + c * _cellSize,
              y: _gridOriginY + r * _cellSize,
              cellSize: _cellSize,
              colorIndex: 1 + (r % 8),
              isTriple: isTriple,
            ),
          );
        }
      }
    }

    // Confetti for triple clear
    if (isTriple) {
      final confetti = ClearEffectFactory.createConfetti(
        centerX: size.x / 2,
        centerY: _gridOriginY + (_cellSize * gridSize / 2),
        width: size.x,
      );
      for (final c in confetti) {
        add(c);
      }
    }
  }

  // =================== HAMMER FEATURE ===================

  /// Toggle hammer mode
  void toggleHammerMode() {
    if (_hammerCharges <= 0) return;
    _hammerMode = !_hammerMode;
    if (_hammerMode) {
      _gridComponent.setHammerMode(true);
      HapticService.selectionClick();
    } else {
      _gridComponent.setHammerMode(false);
    }
  }

  /// Use hammer at a grid position (called from tap on grid)
  void useHammerAt(double tapX, double tapY) {
    if (!_hammerMode || _hammerCharges <= 0) return;

    // Convert tap to grid coords
    final col = ((tapX - _gridOriginX) / _cellSize).floor();
    final row = ((tapY - _gridOriginY) / _cellSize).floor();

    if (row < 0 ||
        row >= GameConstants.gridSize ||
        col < 0 ||
        col >= GameConstants.gridSize) {
      return;
    }

    // Check if there's anything to destroy
    bool hasCells = false;
    final radius = GameConstants.hammerRadius;
    final startR = (row - radius ~/ 2).clamp(0, GameConstants.gridSize - 1);
    final startC = (col - radius ~/ 2).clamp(0, GameConstants.gridSize - 1);
    final endR = (row + radius ~/ 2).clamp(0, GameConstants.gridSize - 1);
    final endC = (col + radius ~/ 2).clamp(0, GameConstants.gridSize - 1);

    for (int r = startR; r <= endR; r++) {
      for (int c = startC; c <= endC; c++) {
        if (!_grid.isEmpty(r, c)) hasCells = true;
      }
    }

    if (!hasCells) {
      HapticService.error();
      return;
    }

    // Deduct score cost
    _score = (_score - GameConstants.hammerScoreCost).clamp(0, 999999);
    _hammerCharges--;

    // Destroy the 3x3 area with particle effects
    GridModel newGrid = _grid.copy();
    for (int r = startR; r <= endR; r++) {
      for (int c = startC; c <= endC; c++) {
        if (!_grid.isEmpty(r, c)) {
          // Spawn particle for destroyed cell
          add(
            ClearEffectFactory.createCellBurst(
              x: _gridOriginX + c * _cellSize,
              y: _gridOriginY + r * _cellSize,
              cellSize: _cellSize,
              colorIndex: _grid.getCell(r, c),
            ),
          );
          newGrid.cells[r][c] = 0;
        }
      }
    }

    _grid = newGrid;
    _gridComponent.grid = _grid;
    _hammerMode = false;
    _gridComponent.setHammerMode(false);

    HapticService.lineClear();
    onScoreChanged?.call(_score, _streak, 0, '🔨 Hammer!');
    onHammerChanged?.call(_hammerCharges);
  }

  void _checkGameOver() {
    final remainingPieces = <BlockPiece>[];
    for (int i = 0; i < _currentPieces.length; i++) {
      if (!_usedPieces[i]) remainingPieces.add(_currentPieces[i]);
    }
    if (GridLogic.isGameOver(_grid, remainingPieces)) {
      final isNewHigh = _score > _highScore;
      if (isNewHigh) _highScore = _score;
      onGameOver?.call(_score, _highScore, isNewHigh);
    }
  }

  String _getClearText(int lines) {
    switch (lines) {
      case 1:
        return 'Clear!';
      case 2:
        return 'Double Clear!';
      case 3:
        return 'TRIPLE CLEAR!';
      default:
        return 'MEGA CLEAR! x$lines';
    }
  }

  /// Start a new game (called from UI)
  void restartGame() {
    _startNewGame();
    onScoreChanged?.call(0, 0, 0, null);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    if (isLoaded) {
      _layoutComponents();
    }
  }
}
