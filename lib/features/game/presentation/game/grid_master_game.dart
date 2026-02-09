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
import 'package:grid_master/shared/services/audio_service.dart';
import 'components/grid_component.dart';
import 'components/block_piece_component.dart';
import 'effects/clear_effect.dart';
import 'effects/effects_manager.dart';
import 'effects/screen_effects.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // Classic Rising Rows
  int _totalPiecesPlaced = 0;
  int _piecesUntilRise = 10;
  bool _isRising = false;

  // Master Timer Drop
  List<double> _pieceTimers = [];
  double _currentTimerMax = 8.0;
  int _timerPiecesPlaced = 0;

  // Components
  late GridComponent _gridComponent;
  final List<BlockPieceComponent> _pieceComponents = [];

  // Drag state
  BlockPieceComponent? _draggedPiece;

  // Layout
  late double _cellSize;
  late double _gridOriginX;
  late double _gridOriginY;
  Vector2? _lastLayoutSize;

  // Random
  late final Random _rng;

  // Memory mode: per-cell expiration timestamps
  Map<(int, int), int> _memoryCellExpiry = {};
  int? _nextPeriodicRevealMs;

  // Effects system
  bool _tetEffectsEnabled = true;
  int _lastMilestone = 0;
  final ScreenShakeManager _shakeManager = ScreenShakeManager();
  GlowTrailComponent? _glowTrail;
  HoaDaoComponent? _hoaDaoComponent;
  int _clearCountSinceThemeChange = 0;

  // Callbacks to Flutter overlay
  Function(int score, int streak, int linesCleared, String? message)?
  onScoreChanged;
  Function(int score, int highScore, bool isNewHigh)? onGameOver;
  Function()? onPiecePlaced;
  Function(int hammerCharges)? onHammerChanged;
  Function(GridTheme theme)? onThemeChanged;

  GridMasterGame({this.mode = GameMode.easy, int? seed}) {
    _rng = Random(seed);
  }

  int get score => _score;
  int get highScore => _highScore;
  int get streak => _streak;
  int get hammerCharges => _hammerCharges;

  // Public getters for polling (Master Timer Drop & Classic Rising Rows)
  List<double> get pieceTimers => _pieceTimers;
  double get timerMax => _currentTimerMax;
  double get risingFillPercent =>
      _grid.filledCount / (mode.gridSize * mode.gridSize);

  void setHighScore(int value) => _highScore = value;

  @override
  Color backgroundColor() => const Color(0x00000000);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Load Tết effects preference
    final prefs = await SharedPreferences.getInstance();
    _tetEffectsEnabled = prefs.getBool('tet_effects_enabled') ?? true;
    _startNewGame();

    // Add glow trail (persistent component)
    _glowTrail = GlowTrailComponent();
    add(_glowTrail!);

    // Add hoa đào if Tết effects enabled
    if (_tetEffectsEnabled) {
      _hoaDaoComponent = HoaDaoComponent();
      add(_hoaDaoComponent!);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    _shakeManager.update(dt);

    // Memory mode logic
    if (mode == GameMode.memory) {
      final now = DateTime.now().millisecondsSinceEpoch;

      // Remove expired cells individually
      if (_memoryCellExpiry.isNotEmpty) {
        final expired = <(int, int)>[];
        for (final entry in _memoryCellExpiry.entries) {
          if (now >= entry.value) {
            expired.add(entry.key);
          }
        }
        if (expired.isNotEmpty) {
          for (final cell in expired) {
            _memoryCellExpiry.remove(cell);
            _gridComponent.visibleCells.remove(cell);
          }
        }
      }

      // Periodic 30s auto-reveal
      if (_nextPeriodicRevealMs != null && now >= _nextPeriodicRevealMs!) {
        final revealExpiry = now + GameConstants.memoryPeriodicShowMs;
        for (int r = 0; r < mode.gridSize; r++) {
          for (int c = 0; c < mode.gridSize; c++) {
            if (!_grid.isEmpty(r, c)) {
              _memoryCellExpiry[(r, c)] = revealExpiry;
              _gridComponent.visibleCells.add((r, c));
            }
          }
        }
        _nextPeriodicRevealMs = now + GameConstants.memoryPeriodicRevealMs;
        onScoreChanged?.call(_score, _streak, 0, 'memoryReveal');
      }
    }

    // Master Timer Drop logic
    if (mode == GameMode.master && _pieceTimers.isNotEmpty && !_isRising) {
      for (int i = 0; i < _pieceTimers.length; i++) {
        if (!_usedPieces[i] && _pieceTimers[i] > 0) {
          _pieceTimers[i] -= dt;
          if (_pieceTimers[i] <= 0) {
            _pieceTimers[i] = 0;
            _autoPlacePiece(i);
            break; // handle one at a time
          }
        }
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
        // Lift block above finger so it's visible while dragging
        comp.position.y -= GameConstants.dragLiftOffset;
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

    // Glow trail when dragging
    _glowTrail?.addPoint(comp.position);

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

      // Memory mode: show placed cells with individual 5s timers
      if (mode == GameMode.memory) {
        final expiry =
            DateTime.now().millisecondsSinceEpoch +
            GameConstants.memoryShowDurationMs;
        for (int r = 0; r < piece.rows; r++) {
          for (int c = 0; c < piece.cols; c++) {
            if (piece.shape[r][c]) {
              final cell = (startRow + r, startCol + c);
              _memoryCellExpiry[cell] = expiry;
              _gridComponent.visibleCells.add(cell);
            }
          }
        }
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

        // Enhanced particle effects
        _spawnClearParticles(
          result.clearedRows,
          result.clearedCols,
          linesCleared: result.linesCleared,
        );

        // Haptic
        if (result.linesCleared >= 3) {
          HapticService.tripleClear();
        } else {
          HapticService.lineClear();
        }

        // Theme change every 10 clears
        _clearCountSinceThemeChange += result.linesCleared;
        if (_clearCountSinceThemeChange >= 10) {
          _clearCountSinceThemeChange = 0;
          final newTheme =
              GridTheme.themes[_rng.nextInt(GridTheme.themes.length)];
          _gridComponent.setTheme(newTheme);
          onThemeChanged?.call(newTheme);
        }
        // Memory mode: reveal ALL cells for 5s on combo
        if (mode == GameMode.memory) {
          final comboExpiry =
              DateTime.now().millisecondsSinceEpoch +
              GameConstants.memoryComboShowDurationMs;
          for (int r = 0; r < mode.gridSize; r++) {
            for (int c = 0; c < mode.gridSize; c++) {
              if (!_grid.isEmpty(r, c)) {
                _memoryCellExpiry[(r, c)] = comboExpiry;
                _gridComponent.visibleCells.add((r, c));
              }
            }
          }
        }
      } else {
        _streak = 0;
      }

      _gridComponent.grid = _grid;
      onScoreChanged?.call(_score, _streak, result.linesCleared, message);
      onPiecePlaced?.call();

      // Classic Rising Rows: track pieces & trigger rise
      if (mode == GameMode.classic) {
        _totalPiecesPlaced++;
        _piecesUntilRise--;
        if (_piecesUntilRise <= 0) {
          _pushGridUp();
          // Escalation: after 50 pieces → every 8, after 100 → every 6
          if (_totalPiecesPlaced >= 100) {
            _piecesUntilRise = 6;
          } else if (_totalPiecesPlaced >= 50) {
            _piecesUntilRise = 8;
          } else {
            _piecesUntilRise = 10;
          }
        }
      }

      // Master Timer Drop: track pieces for speed escalation
      if (mode == GameMode.master) {
        _timerPiecesPlaced++;
        if (_timerPiecesPlaced >= 60) {
          _currentTimerMax = 5.0;
        } else if (_timerPiecesPlaced >= 30) {
          _currentTimerMax = 6.0;
        }
      }

      // Check if all pieces used → new round
      if (_usedPieces.every((u) => u)) {
        _currentPieces = BlockPiece.generateForMode(
          GameConstants.piecesPerRound,
          mode,
        );
        _usedPieces = List.filled(GameConstants.piecesPerRound, false);
        if (mode == GameMode.master) {
          _pieceTimers = List.filled(
            GameConstants.piecesPerRound,
            _currentTimerMax,
          );
        }
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
    onScoreChanged?.call(_score, _streak, 0, 'zenClear');
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
    onScoreChanged?.call(_score, _streak, 0, 'autoHammer:$destroyed');
    onHammerChanged?.call(_hammerCharges);

    Future.delayed(const Duration(milliseconds: 500), () {
      _checkGameOver();
    });
  }

  // =================== CLASSIC RISING ROWS ===================

  /// Push entire grid up 1 row, add a new random row at bottom with gaps
  void _pushGridUp() {
    _isRising = true;
    final gridSize = mode.gridSize;
    final newGrid = _grid.copy();

    // Check if top row has any filled cells → game over
    for (int c = 0; c < gridSize; c++) {
      if (!_grid.isEmpty(0, c)) {
        // Cell would be pushed off the top → game over
        _isRising = false;
        final isNewHigh = _score > _highScore;
        if (isNewHigh) _highScore = _score;
        onGameOver?.call(_score, _highScore, isNewHigh);
        return;
      }
    }

    // Shift all rows up by 1
    for (int r = 0; r < gridSize - 1; r++) {
      for (int c = 0; c < gridSize; c++) {
        newGrid.cells[r][c] = _grid.cells[r + 1][c];
      }
    }

    // Generate new bottom row with random colors and gaps
    final gapCount = mode.risingRowGaps > 0 ? mode.risingRowGaps : 3;
    final gapPositions = <int>{};
    while (gapPositions.length < gapCount) {
      gapPositions.add(_rng.nextInt(gridSize));
    }

    for (int c = 0; c < gridSize; c++) {
      if (gapPositions.contains(c)) {
        newGrid.cells[gridSize - 1][c] = 0; // gap
      } else {
        newGrid.cells[gridSize - 1][c] = 1 + _rng.nextInt(8); // random color
      }
    }

    _grid = newGrid;
    _gridComponent.grid = _grid;

    HapticService.lineClear();
    onScoreChanged?.call(_score, _streak, 0, 'risingRow');

    _isRising = false;

    // Check lines after rise (bottom row might complete)
    final result = GridLogic.checkAndClearLines(_grid, 0, _streak);
    if (result.linesCleared > 0) {
      _grid = result.grid;
      _score += result.pointsEarned;
      _streak++;
      _gridComponent.grid = _grid;
      _spawnClearParticles(result.clearedRows, result.clearedCols);
      onScoreChanged?.call(
        _score,
        _streak,
        result.linesCleared,
        _getClearText(result.linesCleared),
      );
    }
  }

  // =================== MASTER TIMER DROP ===================

  /// Auto-place a piece at a random valid position when timer expires
  void _autoPlacePiece(int pieceIndex) {
    if (pieceIndex >= _currentPieces.length || _usedPieces[pieceIndex]) return;

    final piece = _currentPieces[pieceIndex];
    final gridSize = mode.gridSize;

    // Find all valid positions
    final validPositions = <(int, int)>[];
    for (int r = 0; r <= gridSize - piece.rows; r++) {
      for (int c = 0; c <= gridSize - piece.cols; c++) {
        if (GridLogic.canPlace(_grid, piece, r, c)) {
          validPositions.add((r, c));
        }
      }
    }

    if (validPositions.isEmpty) {
      // No valid position → game over (deferred to avoid setState during build)
      final isNewHigh = _score > _highScore;
      if (isNewHigh) _highScore = _score;
      Future.delayed(Duration.zero, () {
        onGameOver?.call(_score, _highScore, isNewHigh);
      });
      return;
    }

    // Pick random position
    final pos = validPositions[_rng.nextInt(validPositions.length)];
    _grid = GridLogic.placePiece(_grid, piece, pos.$1, pos.$2);
    _usedPieces[pieceIndex] = true;

    // Remove the piece component from UI
    final comp = _pieceComponents
        .where((c) => c.index == pieceIndex)
        .firstOrNull;
    if (comp != null) {
      comp.used = true;
      _pieceComponents.remove(comp);
      comp.removeFromParent();
    }

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
      _spawnClearParticles(
        result.clearedRows,
        result.clearedCols,
        linesCleared: result.linesCleared,
      );
      // Theme change every 10 clears
      _clearCountSinceThemeChange += result.linesCleared;
      if (_clearCountSinceThemeChange >= 10) {
        _clearCountSinceThemeChange = 0;
        final newTheme =
            GridTheme.themes[_rng.nextInt(GridTheme.themes.length)];
        _gridComponent.setTheme(newTheme);
        Future.delayed(Duration.zero, () {
          onThemeChanged?.call(newTheme);
        });
      }
    } else {
      _streak = 0;
    }

    _gridComponent.grid = _grid;

    // Defer ALL UI callbacks to avoid setState during Flame's build phase
    final scoreSnapshot = _score;
    final streakSnapshot = _streak;
    final linesCleared = result.linesCleared;
    final autoMsg = 'autoDrop:${message ?? ""}';
    Future.delayed(Duration.zero, () {
      onScoreChanged?.call(
        scoreSnapshot,
        streakSnapshot,
        linesCleared,
        autoMsg,
      );
      onPiecePlaced?.call();
    });

    // Master Timer Drop: track pieces for speed escalation
    _timerPiecesPlaced++;
    if (_timerPiecesPlaced >= 60) {
      _currentTimerMax = 5.0;
    } else if (_timerPiecesPlaced >= 30) {
      _currentTimerMax = 6.0;
    }

    // Check if all pieces used → new round
    if (_usedPieces.every((u) => u)) {
      _currentPieces = BlockPiece.generateForMode(
        GameConstants.piecesPerRound,
        mode,
      );
      _usedPieces = List.filled(GameConstants.piecesPerRound, false);
      _pieceTimers = List.filled(
        GameConstants.piecesPerRound,
        _currentTimerMax,
      );
      _layoutComponents();
    }

    _checkGameOver();
  }

  // =================== GAME LIFECYCLE ===================

  void _startNewGame() {
    final gridSize = mode.gridSize;
    _grid = GridModel.empty(gridSize);
    _score = 0;
    _streak = 0;
    _hammerCharges = mode.hammerCharges;
    _draggedPiece = null;
    _memoryCellExpiry.clear();
    _currentPieces = BlockPiece.generateForMode(
      GameConstants.piecesPerRound,
      mode,
    );
    _usedPieces = List.filled(GameConstants.piecesPerRound, false);

    // Classic Rising Rows: reset counters
    _totalPiecesPlaced = 0;
    _piecesUntilRise = mode.risingRowInterval > 0 ? mode.risingRowInterval : 10;
    _isRising = false;

    // Master Timer Drop: init timers
    _timerPiecesPlaced = 0;
    _currentTimerMax = mode.timerDropSeconds > 0 ? mode.timerDropSeconds : 8.0;
    if (mode == GameMode.master) {
      _pieceTimers = List.filled(
        GameConstants.piecesPerRound,
        _currentTimerMax,
      );
    } else {
      _pieceTimers = [];
    }

    // Memory mode: start periodic reveal timer
    if (mode == GameMode.memory) {
      _nextPeriodicRevealMs =
          DateTime.now().millisecondsSinceEpoch +
          GameConstants.memoryPeriodicRevealMs;
    } else {
      _nextPeriodicRevealMs = null;
    }

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
    final aspectRatio = screenH / screenW;

    // Responsive margins — tall screens need much more top space for score overlay
    final bool isTallScreen = aspectRatio > 1.4;
    // Top: must clear score overlay (mode name + fire score + home btn)
    final topMargin = isTallScreen
        ? (screenH * 0.24).clamp(150.0, 240.0)
        : (screenH * 0.18).clamp(120.0, 180.0);
    // Bottom: space for 3 pieces
    final bottomReserve = isTallScreen
        ? (screenH * 0.22).clamp(100.0, 250.0)
        : (screenH * 0.20).clamp(80.0, 200.0);
    final availableHeight = screenH - topMargin - bottomReserve;
    final availableWidth = screenW * 0.85;

    final gridMaxSize = availableHeight < availableWidth
        ? availableHeight
        : availableWidth;
    _cellSize = gridMaxSize / gridSize;
    final gridPixelSize = _cellSize * gridSize;

    _gridOriginX = (screenW - gridPixelSize) / 2;
    _gridOriginY = topMargin;

    // Create grid component (preserve memory visibility state)
    _gridComponent = GridComponent(
      grid: _grid,
      cellSize: _cellSize,
      gridSize: gridSize,
      position: Vector2(_gridOriginX, _gridOriginY),
    );
    _gridComponent.memoryMode = (mode == GameMode.memory);
    if (mode == GameMode.memory) {
      // Restore visible cells from per-cell expiry map
      _gridComponent.visibleCells = _memoryCellExpiry.keys.toSet();
    }
    add(_gridComponent);

    // Re-add particle effects
    for (final p in particlesToKeep) {
      add(p);
    }

    // Create piece components below grid
    final gridBottom = _gridOriginY + gridPixelSize;
    final spaceBelow = screenH - gridBottom;
    // Piece cells use full cellSize (render method applies 0.7x scale for non-drag)
    final pieceCellSize = _cellSize;
    // Center pieces vertically in the bottom area
    final panelCenterY = gridBottom + spaceBelow * 0.7;
    final panelWidth = screenW * 0.85;
    final pieceSlotWidth = panelWidth / GameConstants.piecesPerRound;

    for (int i = 0; i < _currentPieces.length; i++) {
      if (_usedPieces[i]) continue;
      final piece = _currentPieces[i];
      final pieceComp = BlockPieceComponent(
        piece: piece,
        index: i,
        cellSize: pieceCellSize,
        position: Vector2(
          (screenW - panelWidth) / 2 + pieceSlotWidth * i + pieceSlotWidth / 2,
          panelCenterY,
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
    int linesCleared = 1,
  }) {
    final gridSize = mode.gridSize;
    final intensity = EffectsManager.getIntensity(_streak, linesCleared);

    // Always spawn basic cell burst particles
    for (final r in clearedRows) {
      for (int c = 0; c < gridSize; c++) {
        add(
          ClearEffectFactory.createCellBurst(
            x: _gridOriginX + c * _cellSize,
            y: _gridOriginY + r * _cellSize,
            cellSize: _cellSize,
            colorIndex: 1 + (c % 8),
            isTriple: linesCleared >= 3,
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
              isTriple: linesCleared >= 3,
            ),
          );
        }
      }
    }

    // ═══ USE MASTER TRIGGER — full-screen effects + audio ═══
    final centerX = size.x / 2;
    final centerY = _gridOriginY + (_cellSize * gridSize / 2);

    final effects = EffectsManager.spawnClearEffects(
      screenWidth: size.x,
      screenHeight: size.y,
      centerX: centerX,
      centerY: centerY,
      cellSize: _cellSize,
      streak: _streak,
      linesCleared: linesCleared,
      tetEnabled: _tetEffectsEnabled,
    );
    for (final c in effects) {
      add(c);
    }

    // ═══ Screen shake for strong+ ═══
    if (intensity.index >= EffectIntensity.medium.index) {
      final shakeIntensity = switch (intensity) {
        EffectIntensity.extreme => 14.0,
        EffectIntensity.strong => 10.0,
        EffectIntensity.medium => 6.0,
        _ => 3.0,
      };
      _shakeManager.shake(intensity: shakeIntensity, duration: 0.3);
      AudioService.instance.playShakeRumble(
        EffectsManager.getPitchMultiplier(_streak),
      );
    }

    // ═══ Combo text animation ═══
    if (_streak >= 2) {
      add(
        ComboTextComponent(
          text: 'x${_streak} COMBO!',
          x: centerX,
          y: centerY - 60,
          color: _streak >= 8
              ? const Color(0xFFFF0000)
              : _streak >= 5
              ? const Color(0xFF00BFFF)
              : const Color(0xFFFFD700),
        ),
      );
    }

    // ═══ Star burst on score milestones ═══
    if (_tetEffectsEnabled) {
      final milestone = (_score ~/ 500) * 500;
      if (milestone > _lastMilestone && milestone > 0) {
        _lastMilestone = milestone;
        add(StarBurstComponent(centerX: size.x * 0.5, centerY: 50, count: 20));
        AudioService.instance.playLiXiSound();
      }
    }

    // Triple+ confetti from original
    if (linesCleared >= 3) {
      final confetti = ClearEffectFactory.createConfetti(
        centerX: centerX,
        centerY: centerY,
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
        return 'clear';
      case 2:
        return 'doubleClear';
      case 3:
        return 'tripleClear';
      default:
        return 'megaClear:$lines'; // Special format to parse later or just return key and handle args in UI
    }
  }

  void restartGame() {
    _startNewGame();
    onScoreChanged?.call(0, 0, 0, null);
  }

  @override
  void render(Canvas canvas) {
    // Apply screen shake offset
    if (_shakeManager.isShaking) {
      canvas.save();
      canvas.translate(_shakeManager.offset.x, _shakeManager.offset.y);
      super.render(canvas);
      canvas.restore();
    } else {
      super.render(canvas);
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    if (isLoaded) {
      // Only rebuild if size changed meaningfully (>1px)
      if (_lastLayoutSize == null || (size - _lastLayoutSize!).length > 1.0) {
        _lastLayoutSize = size.clone();
        _layoutComponents();
      }
    }
  }
}
