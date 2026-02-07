import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:go_router/go_router.dart';

import 'package:grid_master/shared/services/high_score_service.dart';
import '../game/grid_master_game.dart';
import '../game/overlays/score_overlay.dart';
import '../game/overlays/game_over_overlay.dart';

/// Main game screen that wraps the Flame GameWidget
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

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
  int _hammerCharges = 3;

  @override
  void initState() {
    super.initState();
    _game = GridMasterGame();
    _game.onScoreChanged = _onScoreChanged;
    _game.onGameOver = _onGameOver;
    _game.onHammerChanged = _onHammerChanged;

    // Load high score
    _loadHighScore();
  }

  Future<void> _loadHighScore() async {
    final hs = await HighScoreService.load();
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

    // Clear combo message after delay
    if (message != null) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _comboMessage = null);
        }
      });
    }
  }

  void _onGameOver(int score, int highScore, bool isNewHigh) {
    // Persist high score
    if (isNewHigh) {
      HighScoreService.save(score);
    }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      body: Stack(
        children: [
          // Flame Game — wrapped in GestureDetector for hammer taps
          GestureDetector(
            onTapUp: (details) {
              if (_game.isHammerMode) {
                _game.useHammerAt(
                  details.localPosition.dx,
                  details.localPosition.dy,
                );
              }
            },
            child: GameWidget(game: _game),
          ),

          // Score overlay
          ScoreOverlay(
            score: _score,
            streak: _streak,
            comboMessage: _comboMessage,
            onHomeTap: () => context.go('/'),
          ),

          // Hammer button (bottom right)
          Positioned(bottom: 32, right: 24, child: _buildHammerButton()),

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
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF6B6B).withValues(alpha: 0.5),
                          blurRadius: 15,
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
                  _hammerCharges = 3;
                });
                _game.restartGame();
              },
              onGoHome: () => context.go('/'),
            ),
        ],
      ),
    );
  }

  Widget _buildHammerButton() {
    final isActive = _game.isHammerMode;
    final hasCharges = _hammerCharges > 0;

    return GestureDetector(
      onTap: hasCharges
          ? () {
              _game.toggleHammerMode();
              setState(() {});
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: isActive
              ? const LinearGradient(
                  colors: [Color(0xFFFF8E53), Color(0xFFFF6B6B)],
                )
              : LinearGradient(
                  colors: hasCharges
                      ? [const Color(0xFF2D2D5E), const Color(0xFF3D3D7E)]
                      : [const Color(0xFF1A1A2E), const Color(0xFF1A1A2E)],
                ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive
                ? const Color(0xFFFF8E53)
                : hasCharges
                ? Colors.white.withValues(alpha: 0.2)
                : Colors.white.withValues(alpha: 0.05),
            width: isActive ? 2 : 1,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: const Color(0xFFFF8E53).withValues(alpha: 0.5),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.hardware,
              color: hasCharges
                  ? Colors.white.withValues(alpha: isActive ? 1.0 : 0.7)
                  : Colors.white.withValues(alpha: 0.2),
              size: 28,
            ),
            // Charge count badge
            Positioned(
              top: 4,
              right: 4,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: hasCharges
                      ? const Color(0xFFFF6B6B)
                      : Colors.grey.shade800,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$_hammerCharges',
                    style: TextStyle(
                      color: Colors.white.withValues(
                        alpha: hasCharges ? 1.0 : 0.4,
                      ),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
