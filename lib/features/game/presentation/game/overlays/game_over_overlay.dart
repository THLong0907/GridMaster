import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:grid_master/l10n/generated/app_localizations.dart';
import 'package:grid_master/features/game/domain/models/game_mode.dart';
import 'package:grid_master/shared/services/leaderboard_service.dart';

/// Game Over overlay shown when no more moves are available
class GameOverOverlay extends StatefulWidget {
  final int score;
  final int highScore;
  final bool isNewHighScore;
  final GameMode mode;
  final VoidCallback onPlayAgain;
  final VoidCallback onGoHome;
  final String? rivalName;
  final int rivalScore;
  final bool isPractice;

  const GameOverOverlay({
    super.key,
    required this.score,
    required this.highScore,
    required this.isNewHighScore,
    required this.mode,
    required this.onPlayAgain,
    required this.onGoHome,
    this.rivalName,
    this.rivalScore = 0,
    this.isPractice = false,
  });

  @override
  State<GameOverOverlay> createState() => _GameOverOverlayState();
}

class _GameOverOverlayState extends State<GameOverOverlay> {
  bool _isUploading = false;
  bool _uploadSuccess = false;

  Future<void> _submitScore() async {
    setState(() => _isUploading = true);
    try {
      await LeaderboardService.uploadScore(widget.score, widget.mode);
      if (mounted) {
        setState(() {
          _isUploading = false;
          _uploadSuccess = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isUploading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.uploadFailed),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1A1A3E), Color(0xFF2D1B69)],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Game Over title
              Text(
                AppLocalizations.of(context)!.gameOver,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.mode.displayName.toUpperCase(),
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 24),

              // PvP Result Banner
              if (widget.rivalName != null) _buildPvpResult(),

              // New high score badge
              if (widget.isNewHighScore)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppLocalizations.of(context)!.newHighScore,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

              // Score
              Text(
                AppLocalizations.of(context)!.score,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 14,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${widget.score}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // High score
              Text(
                '${AppLocalizations.of(context)!.highScore}: ${widget.highScore}',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),

              // Leaderboard upload (hide for practice)
              if (!widget.isPractice && widget.rivalName == null)
                if (!_uploadSuccess)
                  _buildButton(
                    _isUploading ? AppLocalizations.of(context)!.uploading : AppLocalizations.of(context)!.uploadToLeaderboard,
                    [
                      const Color(0xFFFFD700).withValues(alpha: 0.2),
                      const Color(0xFFFFA500).withValues(alpha: 0.1),
                    ],
                    _isUploading ? () {} : _submitScore,
                    textColor: Colors.orangeAccent,
                    icon: _isUploading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(
                                Colors.orangeAccent,
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.cloud_upload,
                            size: 18,
                            color: Colors.orangeAccent,
                          ),
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppLocalizations.of(context)!.scoreUploaded,
                        style: TextStyle(
                          color: Colors.green.shade300,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

              const SizedBox(height: 32),

              // Play Again button
              _buildButton(AppLocalizations.of(context)!.playAgain, const [
                Color(0xFF6C5CE7),
                Color(0xFFA29BFE),
              ], widget.onPlayAgain),
              const SizedBox(height: 12),

              // Share button
              _buildButton(
                AppLocalizations.of(context)!.shareScore,
                [
                  const Color(0xFF00B894).withValues(alpha: 0.2),
                  const Color(0xFF00CC76).withValues(alpha: 0.1),
                ],
                () {
                  final l10n = AppLocalizations.of(context)!;
                  final text =
                      'Grid Master - ${widget.mode.displayName}\n'
                      '${l10n.score}: ${widget.score}\n'
                      '${l10n.highScore}: ${widget.highScore}\n'
                      '${widget.isNewHighScore ? '${l10n.newHighScore}\n' : ''}'
                      'Can you beat me?';
                  SharePlus.instance.share(ShareParams(text: text));
                },
                textColor: const Color(0xFF00B894),
              ),
              const SizedBox(height: 12),

              // Home button
              _buildButton(
                AppLocalizations.of(context)!.home,
                [
                  Colors.white.withValues(alpha: 0.1),
                  Colors.white.withValues(alpha: 0.05),
                ],
                widget.onGoHome,
                textColor: Colors.white70,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    String text,
    List<Color> gradientColors,
    VoidCallback onTap, {
    Color textColor = Colors.white,
    Widget? icon,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradientColors),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[icon, const SizedBox(width: 8)],
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPvpResult() {
    final l10n = AppLocalizations.of(context)!;
    final isWin = widget.score > widget.rivalScore;
    final isDraw = widget.score == widget.rivalScore;
    final resultText = isDraw ? l10n.pvpDraw : (isWin ? l10n.pvpWin : l10n.pvpLose);
    final resultColor = isDraw
        ? Colors.amber
        : (isWin ? const Color(0xFF00B894) : const Color(0xFFFF6B6B));
    final resultIcon = isDraw
        ? Icons.handshake
        : (isWin ? Icons.emoji_events : Icons.sentiment_dissatisfied);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: resultColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: resultColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(resultIcon, color: resultColor, size: 40),
          const SizedBox(height: 8),
          Text(
            resultText,
            style: TextStyle(
              color: resultColor,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildScoreColumn(l10n.you, widget.score, isWin || isDraw),
              Text(
                'VS',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.3),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildScoreColumn(
                widget.rivalName ?? l10n.rival,
                widget.rivalScore,
                !isWin || isDraw,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScoreColumn(String name, int score, bool isHigher) {
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$score',
          style: TextStyle(
            color: isHigher
                ? Colors.white
                : Colors.white.withValues(alpha: 0.5),
            fontSize: isHigher ? 28 : 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
