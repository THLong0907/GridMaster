import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:go_router/go_router.dart';

import 'package:grid_master/core/constants/colors.dart';
import 'package:grid_master/features/game/domain/models/game_mode.dart';
import 'package:grid_master/shared/services/high_score_service.dart';
import 'package:grid_master/shared/widgets/animated_block_background.dart';
import '../game/grid_master_game.dart';
import '../game/overlays/score_overlay.dart';
import '../game/overlays/game_over_overlay.dart';

/// Main game screen — receives GameMode from route
class GameScreen extends StatefulWidget {
  final GameMode mode;

  const GameScreen({super.key, required this.mode});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final GridMasterGame _game;
  int _score = 0;
  int _streak = 0;
  String? _comboMessage;
  bool _isGameOver = false;
  int _finalScore = 0;
  int _highScore = 0;
  bool _isNewHigh = false;
  int _hammerCharges = 0;

  Color _accentColor = const Color(0xFF6C5CE7);
  Color _bgColor1 = const Color(0xFF0D0D1A);
  Color _bgColor2 = const Color(0xFF1A1A3E);
  Key _bgKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _hammerCharges = widget.mode.hammerCharges;
    _game = GridMasterGame(mode: widget.mode);
    _game.onScoreChanged = _onScoreChanged;
    _game.onGameOver = _onGameOver;
    _game.onHammerChanged = _onHammerChanged;
    _game.onThemeChanged = _onThemeChanged;

    _loadHighScore();
  }

  Future<void> _loadHighScore() async {
    final hs = await HighScoreService.load(widget.mode);
    _game.setHighScore(hs);
    setState(() => _highScore = hs);
  }

  void _onScoreChanged(
    int score,
    int streak,
    int linesCleared,
    String? message,
  ) {
    setState(() {
      _score = score;
      _streak = streak;
      _comboMessage = message;
    });

    if (message != null) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) setState(() => _comboMessage = null);
      });
    }
  }

  void _onGameOver(int score, int highScore, bool isNewHigh) {
    if (isNewHigh) HighScoreService.save(score, widget.mode);
    setState(() {
      _isGameOver = true;
      _finalScore = score;
      _highScore = highScore;
      _isNewHigh = isNewHigh;
    });
  }

  void _onHammerChanged(int charges) {
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
          GameWidget(game: _game),

          // Score overlay with mode name
          ScoreOverlay(
            score: _score,
            streak: _streak,
            comboMessage: _comboMessage,
            modeName: widget.mode.displayName,
            onHomeTap: () => context.go('/'),
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

          // Game Over overlay
          if (_isGameOver)
            GameOverOverlay(
              score: _finalScore,
              highScore: _highScore,
              isNewHighScore: _isNewHigh,
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
                });
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
}
