import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'dart:ui';

import 'package:grid_master/core/constants/game_constants.dart';
import 'package:grid_master/core/constants/colors.dart';
import 'package:grid_master/features/game/domain/models/grid_model.dart';
import 'package:grid_master/features/game/domain/models/block_piece.dart';
import 'package:grid_master/features/game/domain/models/game_mode.dart';
import 'package:grid_master/features/game/domain/logic/grid_logic.dart';
import 'package:grid_master/shared/services/haptic_service.dart';
import 'components/grid_component.dart';
import 'components/block_piece_component.dart';
import 'effects/clear_effect.dart';

/// Main Grid Master game powered by Flame Engine
/// Supports 5 game modes with different grid sizes and mechanics
class GridMasterGame extends FlameGame with PanDetector {
  final GameMode mode;

  // State
  late GridModel _grid;
  late List<BlockPiece> _currentPieces;
  late List<bool> _usedPieces;
  int _score = 0;
  int _highScore = 0;
  int _streak = 0;
  late int _hammerCharges;

  // Components
  late GridComponent _gridComponent;
  final List<BlockPieceComponent> _pieceComponents = [];

  // Drag state
  BlockPieceComponent? _draggedPiece;

  // Layout
  late double _cellSize;
  late double _gridOriginX;
  late double _gridOriginY;

  // Random
  final _rng = Random();

  // Memory mode timers
  int? _memoryRevealEndMs;

  // Callbacks to Flutter overlay
  Function(int score, int streak, int linesCleared, String? message)?
  onScoreChanged;
  Function(int score, int highScore, bool isNewHigh)? onGameOver;
  Function()? onPiecePlaced;
  Function(int hammerCharges)? onHammerChanged;
  Function(GridTheme theme)? onThemeChanged;

  GridMasterGame({this.mode = GameMode.easy});

  int get score => _score;
  int get highScore => _highScore;
  int get streak => _streak;
  int get hammerCharges => _hammerCharges;

  void setHighScore(int value) => _highScore = value;

  @override
  Color backgroundColor() => const Color(0x00000000);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _startNewGame();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Memory mode: auto-hide cells after timeout
    if (mode == GameMode.memory && _memoryRevealEndMs != null) {
      final now = DateTime.now().millisecondsSinceEpoch;
      if (now >= _memoryRevealEndMs!) {
        _memoryRevealEndMs = null;
        _gridComponent.hideAll();
      }
    }
  }

  // =================== PAN/DRAG ===================

  @override
  void onPanStart(DragStartInfo info) {
    final pos = info.eventPosition.global;
    for (final comp in _pieceComponents) {
      if (comp.containsWorldPoint(pos)) {
        _draggedPiece = comp;
        comp.isDragging = true;
        HapticService.lightTap();
        return;
      }
    }
    _draggedPiece = null;
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    final comp = _draggedPiece;
    if (comp == null) return;

    comp.position += info.delta.global;

    final piece = comp.piece;
    final worldPos = Vector2(
      comp.position.x,
      comp.position.y - GameConstants.fingerOffset,
    );
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

  @override
  void onPanEnd(DragEndInfo info) {
    final comp = _draggedPiece;
    if (comp == null) return;
    _draggedPiece = null;

    _gridComponent.clearGhost();

    final piece = comp.piece;
    final worldPos = Vector2(
      comp.position.x,
      comp.position.y - GameConstants.fingerOffset,
    );
    final gridLocalX = worldPos.x - _gridOriginX - (piece.cols * _cellSize / 2);
    final gridLocalY = worldPos.y - _gridOriginY - (piece.rows * _cellSize / 2);

    final startCol = (gridLocalX / _cellSize).round();
    final startRow = (gridLocalY / _cellSize).round();

    if (GridLogic.canPlace(_grid, piece, startRow, startCol)) {
      _grid = GridLogic.placePiece(_grid, piece, startRow, startCol);
      _usedPieces[comp.index] = true;
      comp.used = true;
      HapticService.piecePlaced();

      // Memory mode: show placed cells briefly
      if (mode == GameMode.memory) {
        for (int r = 0; r < piece.rows; r++) {
          for (int c = 0; c < piece.cols; c++) {
            if (piece.shape[r][c]) {
              _gridComponent.visibleCells.add((startRow + r, startCol + c));
            }
          }
        }
        _memoryRevealEndMs =
            DateTime.now().millisecondsSinceEpoch +
            GameConstants.memoryShowDurationMs;
      }

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

        // Particle effects
        _spawnClearParticles(
          result.clearedRows,
          result.clearedCols,
          isTriple: result.linesCleared >= 3,
        );

        // Haptic
        if (result.linesCleared >= 3) {
          HapticService.tripleClear();
        } else {
          HapticService.lineClear();
        }

        // Theme change on clear
        final newTheme =
            GridTheme.themes[_rng.nextInt(GridTheme.themes.length)];
        _gridComponent.setTheme(newTheme);
        onThemeChanged?.call(newTheme);

        // Memory mode: reveal ALL cells for 5s on combo
        if (mode == GameMode.memory) {
          _gridComponent.revealAll();
          _memoryRevealEndMs =
              DateTime.now().millisecondsSinceEpoch +
              GameConstants.memoryComboShowDurationMs;
        }
      } else {
        _streak = 0;
      }

      _gridComponent.grid = _grid;
      onScoreChanged?.call(_score, _streak, result.linesCleared, message);
      onPiecePlaced?.call();

      // Check if all pieces used → new round
      if (_usedPieces.every((u) => u)) {
        _currentPieces = BlockPiece.generateForMode(
          GameConstants.piecesPerRound,
          mode,
        );
        _usedPieces = List.filled(GameConstants.piecesPerRound, false);
        _layoutComponents();
      } else {
        _pieceComponents.remove(comp);
        comp.removeFromParent();
      }

      _checkGameOver();
    } else {
      comp.resetPosition();
    }
  }

  // =================== GAME OVER / ZEN ===================

  void _checkGameOver() {
    final remainingPieces = <BlockPiece>[];
    for (int i = 0; i < _currentPieces.length; i++) {
      if (!_usedPieces[i]) remainingPieces.add(_currentPieces[i]);
    }

    if (!GridLogic.isGameOver(_grid, remainingPieces)) return;

    // Zen mode: auto-clear 2 random rows, never game over
    if (mode == GameMode.zen) {
      _zenAutoClean();
      return;
    }

    // Auto-hammer rescue
    if (_hammerCharges > 0) {
      _autoHammerRescue();
      return;
    }

    // Real game over
    final isNewHigh = _score > _highScore;
    if (isNewHigh) _highScore = _score;
    onGameOver?.call(_score, _highScore, isNewHigh);
  }

  /// Zen mode: clear 2 random rows to make space
  void _zenAutoClean() {
    final gridSize = mode.gridSize;
    final newGrid = _grid.copy();

    // Find rows that have filled cells
    final filledRows = <int>[];
    for (int r = 0; r < gridSize; r++) {
      for (int c = 0; c < gridSize; c++) {
        if (!_grid.isEmpty(r, c)) {
          filledRows.add(r);
          break;
        }
      }
    }

    if (filledRows.isEmpty) return;

    // Clear up to 2 rows
    final toClear = filledRows.length >= 2
        ? (filledRows.toList()..shuffle(_rng)).take(2).toList()
        : filledRows;

    for (final r in toClear) {
      for (int c = 0; c < gridSize; c++) {
        if (!_grid.isEmpty(r, c)) {
          add(
            ClearEffectFactory.createCellBurst(
              x: _gridOriginX + c * _cellSize,
              y: _gridOriginY + r * _cellSize,
              cellSize: _cellSize,
              colorIndex: _grid.getCell(r, c),
            ),
          );
        }
        newGrid.cells[r][c] = 0;
      }
    }

    _grid = newGrid;
    _gridComponent.grid = _grid;

    HapticService.lineClear();
    onScoreChanged?.call(_score, _streak, 0, '🧘 Zen Clear!');
  }

  /// Auto-hammer rescue: destroy a 3x3 area
  void _autoHammerRescue() {
    _hammerCharges--;
    final gridSize = mode.gridSize;

    final filledCells = <(int, int)>[];
    for (int r = 0; r < gridSize; r++) {
      for (int c = 0; c < gridSize; c++) {
        if (!_grid.isEmpty(r, c)) {
          filledCells.add((r, c));
        }
      }
    }

    if (filledCells.isEmpty) return;

    final center = filledCells[_rng.nextInt(filledCells.length)];
    final centerR = center.$1;
    final centerC = center.$2;

    final radius = GameConstants.hammerRadius;
    final startR = (centerR - radius ~/ 2).clamp(0, gridSize - 1);
    final startC = (centerC - radius ~/ 2).clamp(0, gridSize - 1);
    final endR = (centerR + radius ~/ 2).clamp(0, gridSize - 1);
    final endC = (centerC + radius ~/ 2).clamp(0, gridSize - 1);

    GridModel newGrid = _grid.copy();
    int destroyed = 0;
    for (int r = startR; r <= endR; r++) {
      for (int c = startC; c <= endC; c++) {
        if (!_grid.isEmpty(r, c)) {
          add(
            ClearEffectFactory.createCellBurst(
              x: _gridOriginX + c * _cellSize,
              y: _gridOriginY + r * _cellSize,
              cellSize: _cellSize,
              colorIndex: _grid.getCell(r, c),
            ),
          );
          newGrid.cells[r][c] = 0;
          destroyed++;
        }
      }
    }

    _grid = newGrid;
    _gridComponent.grid = _grid;

    HapticService.lineClear();
    onScoreChanged?.call(
      _score,
      _streak,
      0,
      '🔨 Auto Hammer! ($destroyed cells)',
    );
    onHammerChanged?.call(_hammerCharges);

    Future.delayed(const Duration(milliseconds: 500), () {
      _checkGameOver();
    });
  }

  // =================== GAME LIFECYCLE ===================

  void _startNewGame() {
    final gridSize = mode.gridSize;
    _grid = GridModel.empty(gridSize);
    _score = 0;
    _streak = 0;
    _hammerCharges = mode.hammerCharges;
    _draggedPiece = null;
    _currentPieces = BlockPiece.generateForMode(
      GameConstants.piecesPerRound,
      mode,
    );
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

    final screenW = size.x;
    final screenH = size.y;
    final gridSize = mode.gridSize;

    final topMargin = screenH * 0.10;
    final bottomReserve = screenH * 0.30;
    final availableHeight = screenH - topMargin - bottomReserve;
    final availableWidth = screenW * 0.9;

    final gridMaxSize = availableHeight < availableWidth
        ? availableHeight
        : availableWidth;
    _cellSize = gridMaxSize / gridSize;
    final gridPixelSize = _cellSize * gridSize;

    _gridOriginX = (screenW - gridPixelSize) / 2;
    _gridOriginY = topMargin;

    // Create grid component
    _gridComponent = GridComponent(
      grid: _grid,
      cellSize: _cellSize,
      gridSize: gridSize,
      position: Vector2(_gridOriginX, _gridOriginY),
    );
    _gridComponent.memoryMode = (mode == GameMode.memory);
    add(_gridComponent);

    // Re-add particle effects
    for (final p in particlesToKeep) {
      add(p);
    }

    // Create piece components below grid
    final panelY = _gridOriginY + gridPixelSize + screenH * 0.03;
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
      );
      _pieceComponents.add(pieceComp);
      add(pieceComp);
    }
  }

  // =================== PARTICLES ===================

  void _spawnClearParticles(
    List<int> clearedRows,
    List<int> clearedCols, {
    bool isTriple = false,
  }) {
    final gridSize = mode.gridSize;

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

  // =================== UTILS ===================

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
