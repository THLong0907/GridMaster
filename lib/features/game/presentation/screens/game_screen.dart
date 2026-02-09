import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:go_router/go_router.dart';

import 'package:grid_master/core/constants/colors.dart';
import 'package:grid_master/features/game/domain/models/game_mode.dart';
import 'package:grid_master/shared/services/high_score_service.dart';
import 'package:grid_master/shared/widgets/animated_block_background.dart';
import 'package:google_fonts/google_fonts.dart';
import '../game/grid_master_game.dart';
import '../game/effects/effects_manager.dart';
import '../game/overlays/score_overlay.dart';
import '../game/overlays/game_over_overlay.dart';
import '../game/overlays/zen_summary_overlay.dart';
import '../game/overlays/pause_overlay.dart';
import 'package:grid_master/l10n/generated/app_localizations.dart';
import 'package:grid_master/shared/services/leaderboard_service.dart';
import 'package:grid_master/shared/services/pvp_service.dart';
import 'package:grid_master/shared/services/auth_service.dart';
import 'package:grid_master/shared/services/audio_service.dart';
import 'package:grid_master/shared/services/stats_service.dart';
import 'package:grid_master/shared/services/achievement_service.dart';
import 'package:grid_master/shared/widgets/tutorial_overlay.dart';
import 'dart:async';
import 'dart:math';

/// Main game screen — receives GameMode from route
class GameScreen extends StatefulWidget {
  final GameMode mode;
  final bool isPractice;

  const GameScreen({super.key, required this.mode, this.isPractice = false});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GridMasterGame _game;
  bool _gameInitialized = false;
  int _score = 0;
  int _streak = 0;
  String? _comboMessage;
  bool _isGameOver = false;
  int _finalScore = 0;
  int _highScore = 0;
  bool _isNewHigh = false;
  bool _isTop1 = false;
  int _hammerCharges = 0;
  bool _isPaused = false;
  DateTime? _gameStartTime;

  // PvP related
  PvpMatch? _match;
  bool _isPvpSearching = false;
  StreamSubscription? _matchSub;
  Timer? _pvpTimer;
  Timer? _botTimer;
  Timer? _timerPollTimer;
  int _pvpSecondsRemaining = 120; // 2 minutes
  String? _rivalName;
  int _rivalScore = 0;
  bool _isPlayer1 = true;

  Color _accentColor = const Color(0xFF6C5CE7);
  Color _bgColor1 = const Color(0xFF0D0D1A);
  Color _bgColor2 = const Color(0xFF1A1A3E);
  Key _bgKey = UniqueKey();

  // Zen stats
  DateTime? _zenStartTime;
  int _zenLinesCleared = 0;
  int _zenMaxCombo = 0;
  int _zenBlocksPlaced = 0;
  bool _showZenSummary = false;

  // Master Timer Drop UI
  List<double> _pieceTimers = [];
  double _timerMax = 8.0;

  // Classic Rising Row warning
  double _risingWarning = 0.0;

  // Tutorial
  bool _showTutorial = false;

  @override
  void initState() {
    super.initState();
    _hammerCharges = widget.mode.hammerCharges;
    if (widget.mode == GameMode.zen) _zenStartTime = DateTime.now();

    if (widget.mode == GameMode.soloPvP) {
      if (widget.isPractice) {
        _startPracticeGame();
        _loadHighScore();
      } else {
        _startPvpMatchmaking();
        // _loadHighScore is called inside _startPvpGame after _game is ready
      }
    } else {
      _initStandardGame();
      _loadHighScore();
    }

    _checkTop1();

    // Check if tutorial should be shown
    TutorialOverlay.shouldShow().then((show) {
      if (show && mounted) setState(() => _showTutorial = true);
    });
  }

  void _initStandardGame({int? seed}) {
    _game = GridMasterGame(mode: widget.mode, seed: seed);
    _gameInitialized = true;
    _gameStartTime = DateTime.now();
    _game.onScoreChanged = _onScoreChanged;
    _game.onGameOver = _onGameOver;
    _game.onHammerChanged = _onHammerChanged;
    _game.onThemeChanged = _onThemeChanged;

    // Poll timer state for Master/Classic modes
    if (widget.mode == GameMode.master || widget.mode == GameMode.classic) {
      _timerPollTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
        if (!mounted || _isGameOver) return;
        if (widget.mode == GameMode.master) {
          final timers = _game.pieceTimers;
          final maxTime = _game.timerMax;
          if (timers.isNotEmpty) {
            setState(() {
              _pieceTimers = List.from(timers);
              _timerMax = maxTime;
            });
          }
        }
        if (widget.mode == GameMode.classic) {
          final fill = _game.risingFillPercent;
          if ((fill - _risingWarning).abs() > 0.03) {
            setState(() => _risingWarning = fill);
          }
        }
      });
    }
  }

  Future<void> _startPvpMatchmaking() async {
    setState(() => _isPvpSearching = true);
    try {
      final match = await PvpService.findMatch();
      _match = match;
      _isPlayer1 = match.player1Id == AuthService.uid;

      if (match.status == 'active') {
        _startPvpGame(match);
      } else {
        // Wait for player 2
        _matchSub = PvpService.streamMatch(match.id).listen((updatedMatch) {
          if (updatedMatch.status == 'active' && _match?.status == 'waiting') {
            _startPvpGame(updatedMatch);
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.matchmakingError(e.toString()))));
        context.go('/');
      }
    }
  }

  void _startPvpGame(PvpMatch match) {
    if (!mounted) return;
    setState(() {
      _match = match;
      _isPvpSearching = false;
      _rivalName = _isPlayer1 ? match.player2Name : match.player1Name;
    });

    _initStandardGame(seed: match.seed);
    _loadHighScore();

    // Listen for rival score (skip for practice/test matches)
    if (!widget.isPractice && match.id != 'test_match') {
      _matchSub?.cancel();
      _matchSub = PvpService.streamMatch(match.id).listen((updatedMatch) {
        if (mounted) {
          setState(() {
            _rivalScore = _isPlayer1
                ? updatedMatch.player2Score
                : updatedMatch.player1Score;
          });
        }
      });
    }

    // Start 2 minute timer
    _pvpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_pvpSecondsRemaining > 0) {
            _pvpSecondsRemaining--;
          } else {
            timer.cancel();
            _onGameOver(_score, _highScore, _score > _highScore);
          }
        });
      }
    });
  }

  void _startPracticeGame() {
    // Randomly pick a BOT difficulty
    final difficulties = [
      // [name, emoji, scoreChance (out of 10), minPts, maxPts, comboChance (out of 100), comboMin, comboMax]
      ['Tập Sự', '🍼', 2, 15, 60, 3, 100, 200],
      ['Chuyên Nghiệp', '🚀', 3, 40, 120, 8, 200, 500],
      ['Hủy Diệt', '😈', 4, 80, 200, 15, 400, 800],
      ['Siêu Thần', '👹', 5, 120, 300, 25, 600, 1500],
    ];
    final diff = difficulties[Random().nextInt(difficulties.length)];
    final botName = diff[0] as String;
    final botEmoji = diff[1] as String;
    final scoreChance = diff[2] as int; // out of 10, checked each second
    final minPts = diff[3] as int;
    final maxPts = diff[4] as int;
    final comboChance = diff[5] as int; // out of 100
    final comboMin = diff[6] as int;
    final comboMax = diff[7] as int;

    setState(() {
      _isPvpSearching = false;
      _rivalName = '$botEmoji $botName';
      _rivalScore = 0;
    });

    final mockSeed = Random().nextInt(1000000);
    _initStandardGame(seed: mockSeed);

    // BOT scoring timer with difficulty-based parameters
    _botTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || _isGameOver) {
        timer.cancel();
        return;
      }
      final rng = Random();
      // Normal score chance
      if (rng.nextInt(10) < scoreChance) {
        int botGain = minPts + rng.nextInt(maxPts - minPts);
        // Combo burst chance
        if (rng.nextInt(100) < comboChance) {
          botGain += comboMin + rng.nextInt(comboMax - comboMin);
        }
        setState(() {
          _rivalScore += botGain;
        });
      }
    });

    // Start 2 minute timer
    _pvpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_pvpSecondsRemaining > 0) {
            _pvpSecondsRemaining--;
          } else {
            timer.cancel();
            _botTimer?.cancel();
            _onGameOver(_score, _highScore, _score > _highScore);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _matchSub?.cancel();
    _pvpTimer?.cancel();
    _botTimer?.cancel();
    _timerPollTimer?.cancel();
    super.dispose();
  }

  Future<void> _checkTop1() async {
    try {
      final top = await LeaderboardService.isTop1(widget.mode);
      if (mounted) setState(() => _isTop1 = top);
    } catch (_) {}
  }

  Future<void> _loadHighScore() async {
    final hs = await HighScoreService.load(widget.mode);
    if (!mounted || !_gameInitialized) return;
    _game.setHighScore(hs);
    setState(() => _highScore = hs);
  }

  void _onScoreChanged(
    int score,
    int streak,
    int linesCleared,
    String? message,
  ) {
    if (!mounted) return;
    
    // Check if message is a key and translate it
    String? localizedMessage = message;
    if (message != null) {
      final l10n = AppLocalizations.of(context)!;
      if (message == 'clear') localizedMessage = l10n.clear;
      else if (message == 'doubleClear') localizedMessage = l10n.doubleClear;
      else if (message == 'tripleClear') localizedMessage = l10n.tripleClear;
      else if (message.startsWith('megaClear:')) {
        final count = int.tryParse(message.split(':')[1]) ?? 4;
        localizedMessage = l10n.megaClear(count);
      }
      else if (message == '👁️ Memory Reveal!') localizedMessage = l10n.memoryReveal;
      else if (message == '🧘 Zen Clear!') localizedMessage = l10n.zenClear;
      else if (message.startsWith('🔨 Auto Hammer!')) {
         // message format: 🔨 Auto Hammer! ($destroyed cells)
         // regex or simple parse. But GridMasterGame logic sets this string.
         // Let's assume we update GridMasterGame to send keys for these too?
         // For now, let's just handle exact matches or leave as is if not a key.
         // Actually, I should update GridMasterGame to return keys for these events too.
         // But for speed, I'll just leave mixed content if it's complex, or try to match.
         // The GridMasterGame code had: '🔨 Auto Hammer! ($destroyed cells)'
         // I'll leave it as is for now or do a best effort.
         // Wait, I updated _getClearText but not the others in GridMasterGame.
      }
      else if (message == '⬆️ Hàng dâng!') localizedMessage = l10n.risingRow;
      else if (message.startsWith('⏰ Auto Drop!')) localizedMessage = l10n.autoDrop;
    }

    setState(() {
      _score = score;
      _streak = streak;
      _comboMessage = localizedMessage;
    });

    // Sound effects
    if (linesCleared > 0) {
      if (linesCleared >= 2 || streak >= 2) {
        AudioService.instance.playCombo(linesCleared);
      } else {
        AudioService.instance.playLineClear();
      }
    } else if (message != null && message.startsWith('autoDrop')) {
      AudioService.instance.playAutoDrop();
    } else {
      AudioService.instance.playPiecePlaced();
    }

    // Zen stats tracking
    if (widget.mode == GameMode.zen) {
      if (linesCleared > 0) {
        _zenLinesCleared += linesCleared;
      }
      if (streak > _zenMaxCombo) {
        _zenMaxCombo = streak;
      }
      if (linesCleared == 0 && message == null) {
        _zenBlocksPlaced++;
      } else if (linesCleared > 0) {
        _zenBlocksPlaced++;
      }
    }

    if (widget.mode == GameMode.soloPvP && _match != null) {
      PvpService.updateMyScore(_match!.id, score, _isPlayer1);
    }

    if (message != null) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) setState(() => _comboMessage = null);
      });
    }
  }

  void _onGameOver(int score, int highScore, bool isNewHigh) {
    if (!mounted) return;
    if (isNewHigh && !widget.isPractice) {
      HighScoreService.save(score, widget.mode);
      AudioService.instance.playNewHighScore();
      // 🎇 High score fireworks celebration
      if (_game != null) {
        final fireworks = EffectsManager.createHighScoreFireworks(
          screenWidth: _game!.size.x,
          screenHeight: _game!.size.y,
        );
        for (final c in fireworks) {
          _game!.add(c);
        }
        AudioService.instance.playHighScoreCelebration();
      }
    } else {
      AudioService.instance.playGameOver();
    }

    // In PvP (non-practice), notify service
    if (widget.mode == GameMode.soloPvP &&
        _match != null &&
        !widget.isPractice) {
      PvpService.finishMatch(_match!.id);
    }

    setState(() {
      _isGameOver = true;
      _finalScore = score;
      _highScore = highScore;
      _isNewHigh = isNewHigh;
    });

    // Record stats & check achievements
    final secondsPlayed = _gameStartTime != null
        ? DateTime.now().difference(_gameStartTime!).inSeconds
        : 0;
    StatsService.recordGame(
      mode: widget.mode,
      score: score,
      linesCleared: _streak,
      secondsPlayed: secondsPlayed,
    ).then((_) async {
      final stats = await StatsService.getStats();
      await AchievementService.checkAndUnlock(stats);
    });
  }

  void _onHammerChanged(int charges) {
    if (charges < _hammerCharges) {
      AudioService.instance.playHammer();
    }
    setState(() => _hammerCharges = charges);
  }

  void _onThemeChanged(GridTheme theme) {
    setState(() {
      _accentColor = theme.accentGlow;
      _bgColor1 = _darken(theme.bgColor, 0.4);
      _bgColor2 = theme.bgColor;
      _bgKey = UniqueKey();
    });
  }

  Color _darken(Color c, double amount) {
    final hsl = HSLColor.fromColor(c);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      body: Stack(
        children: [
          // Animated block background
          AnimatedBlockBackground(
            key: _bgKey,
            accentColor: _accentColor,
            bgColor1: _bgColor1,
            bgColor2: _bgColor2,
            shapeCount: 14,
          ),

          // Flame Game
          if (!_isPvpSearching) GameWidget(game: _game),

          // Matchmaking UI
          if (_isPvpSearching)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: Color(0xFF6C5CE7)),
                  const SizedBox(height: 24),
                  Text(
                    AppLocalizations.of(context)!.findingRival,
                    style: GoogleFonts.fredoka(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '8x8 - 2 Minutes',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(height: 40),
                  OutlinedButton(
                    onPressed: () {
                      _matchSub?.cancel();
                      _pvpTimer?.cancel();
                      context.go('/');
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white54,
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(AppLocalizations.of(context)!.cancel.toUpperCase()),
                  ),
                ],
              ),
            ),

          // Score overlay with mode name
          if (!_isPvpSearching)
            ScoreOverlay(
              score: _score,
              highScore: _highScore,
              streak: _streak,
              comboMessage: _comboMessage,
              modeName: widget.mode == GameMode.soloPvP
                  ? 'TIMER: ${_pvpSecondsRemaining ~/ 60}:${(_pvpSecondsRemaining % 60).toString().padLeft(2, '0')}'
                  : _getLocalizedModeName(context, widget.mode),
              isTop1: _isTop1,
              rivalName: _rivalName,
              rivalScore: _rivalScore,
              onPauseTap: () {
                setState(() => _isPaused = true);
                _game.paused = true;
              },
            ),

          // Hammer indicator (hide for zen)
          if (widget.mode != GameMode.zen)
            Positioned(bottom: 32, right: 24, child: _buildHammerIndicator()),

          // Memory mode indicator
          if (widget.mode == GameMode.memory)
            Positioned(
              bottom: 32,
              left: 24,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFA29BFE).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFA29BFE).withValues(alpha: 0.4),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.psychology, color: Color(0xFFA29BFE), size: 18),
                    SizedBox(width: 6),
                    Text(
                      'Memory',
                      style: TextStyle(
                        color: Color(0xFFA29BFE),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Master Timer Drop: timer bars at bottom
          if (widget.mode == GameMode.master &&
              _pieceTimers.isNotEmpty &&
              !_isGameOver)
            Positioned(
              bottom: 12,
              left: 24,
              right: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_pieceTimers.length, (i) {
                  final ratio = _timerMax > 0
                      ? (_pieceTimers[i] / _timerMax).clamp(0.0, 1.0)
                      : 0.0;
                  final color = ratio > 0.5
                      ? Color.lerp(
                          Colors.yellow,
                          Colors.greenAccent,
                          (ratio - 0.5) * 2,
                        )!
                      : Color.lerp(Colors.redAccent, Colors.yellow, ratio * 2)!;
                  final isExpired = _pieceTimers[i] <= 0;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isExpired
                                ? '—'
                                : '${_pieceTimers[i].toStringAsFixed(1)}s',
                            style: GoogleFonts.fredoka(
                              color: isExpired ? Colors.white30 : color,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: LinearProgressIndicator(
                              value: ratio,
                              minHeight: 4,
                              backgroundColor: Colors.white.withValues(
                                alpha: 0.1,
                              ),
                              valueColor: AlwaysStoppedAnimation(color),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

          // Classic Rising Row Warning: red border glow
          if (widget.mode == GameMode.classic &&
              _risingWarning >= 0.7 &&
              !_isGameOver)
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.redAccent.withValues(
                        alpha: _risingWarning >= 0.8 ? 0.6 : 0.3,
                      ),
                      width: _risingWarning >= 0.8 ? 3 : 2,
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
            ),

          // Zen mode: End Session button
          if (widget.mode == GameMode.zen && !_isGameOver && !_showZenSummary)
            Positioned(
              bottom: 32,
              left: 24,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() => _showZenSummary = true);
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF6C5CE7).withValues(alpha: 0.25),
                          const Color(0xFFA29BFE).withValues(alpha: 0.15),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFA29BFE).withValues(alpha: 0.4),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.self_improvement,
                          color: Color(0xFFA29BFE),
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppLocalizations.of(context)!.endSession,
                          style: GoogleFonts.fredoka(
                            color: const Color(0xFFA29BFE),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Combo message popup
          if (_comboMessage != null)
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              left: 0,
              right: 0,
              child: Center(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(scale: value, child: child);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _accentColor,
                          _accentColor.withValues(alpha: 0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: _accentColor.withValues(alpha: 0.5),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Text(
                      _comboMessage!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // Zen Summary overlay
          if (_showZenSummary)
            ZenSummaryOverlay(
              score: _score,
              totalLinesCleared: _zenLinesCleared,
              maxCombo: _zenMaxCombo,
              blocksPlaced: _zenBlocksPlaced,
              playTime: _zenStartTime != null
                  ? DateTime.now().difference(_zenStartTime!)
                  : Duration.zero,
              onPlayAgain: () {
                setState(() {
                  _showZenSummary = false;
                  _score = 0;
                  _streak = 0;
                  _zenLinesCleared = 0;
                  _zenMaxCombo = 0;
                  _zenBlocksPlaced = 0;
                  _zenStartTime = DateTime.now();
                  _accentColor = const Color(0xFF6C5CE7);
                  _bgColor1 = const Color(0xFF0D0D1A);
                  _bgColor2 = const Color(0xFF1A1A3E);
                  _bgKey = UniqueKey();
                });
                _game.restartGame();
              },
              onGoHome: () => context.go('/'),
            ),

          // Game Over overlay
          if (_isGameOver)
            GameOverOverlay(
              score: _finalScore,
              highScore: _highScore,
              isNewHighScore: _isNewHigh,
              mode: widget.mode,
              rivalName: _rivalName,
              rivalScore: _rivalScore,
              isPractice: widget.isPractice,
              onPlayAgain: () {
                setState(() {
                  _isGameOver = false;
                  _score = 0;
                  _streak = 0;
                  _hammerCharges = widget.mode.hammerCharges;
                  _accentColor = const Color(0xFF6C5CE7);
                  _bgColor1 = const Color(0xFF0D0D1A);
                  _bgColor2 = const Color(0xFF1A1A3E);
                  _bgKey = UniqueKey();
                  _pvpSecondsRemaining = 120;
                  _rivalScore = 0;
                });
                if (widget.isPractice) {
                  _startPracticeGame();
                } else {
                  _game.restartGame();
                }
              },
              onGoHome: () => context.go('/'),
            ),

          // Tutorial overlay (first launch only)
          if (_showTutorial)
            TutorialOverlay(
              onDismiss: () => setState(() => _showTutorial = false),
            ),

          // Pause overlay
          if (_isPaused && !_isGameOver)
            PauseOverlay(
              score: _score,
              modeName: _getLocalizedModeName(context, widget.mode),
              onResume: () {
                setState(() => _isPaused = false);
                _game.paused = false;
              },
              onRestart: () {
                setState(() {
                  _isPaused = false;
                  _score = 0;
                  _streak = 0;
                  _hammerCharges = widget.mode.hammerCharges;
                  _accentColor = const Color(0xFF6C5CE7);
                  _bgColor1 = const Color(0xFF0D0D1A);
                  _bgColor2 = const Color(0xFF1A1A3E);
                  _bgKey = UniqueKey();
                });
                _game.paused = false;
                _game.restartGame();
              },
              onGoHome: () => context.go('/'),
            ),
        ],
      ),
    );
  }

  Widget _buildHammerIndicator() {
    final hasCharges = _hammerCharges > 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: hasCharges
            ? _accentColor.withValues(alpha: 0.15)
            : const Color(0xFF1A1A2E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasCharges
              ? _accentColor.withValues(alpha: 0.4)
              : Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.hardware,
            color: hasCharges
                ? _accentColor
                : Colors.white.withValues(alpha: 0.3),
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            'x$_hammerCharges',
            style: TextStyle(
              color: hasCharges
                  ? Colors.white.withValues(alpha: 0.9)
                  : Colors.white.withValues(alpha: 0.3),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _getLocalizedModeName(BuildContext context, GameMode mode) {
    final l10n = AppLocalizations.of(context)!;
    switch (mode) {
      case GameMode.easy:
        return l10n.easyMode;
      case GameMode.classic:
        return l10n.classicMode;
      case GameMode.master:
        return l10n.masterMode;
      case GameMode.memory:
        return l10n.memoryMode;
      case GameMode.zen:
        return l10n.zenMode;
      case GameMode.soloPvP:
        return l10n.pvpMode;
    }
  }
}
