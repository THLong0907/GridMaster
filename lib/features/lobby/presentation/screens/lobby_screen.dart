import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:grid_master/features/game/domain/models/game_mode.dart';
import 'package:grid_master/shared/services/high_score_service.dart';
import 'package:grid_master/shared/widgets/animated_block_background.dart';

/// Lobby screen with 5 game mode selection cards
class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key});

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  Map<GameMode, int> _highScores = {};

  @override
  void initState() {
    super.initState();
    _loadHighScores();
  }

  Future<void> _loadHighScores() async {
    final scores = await HighScoreService.loadAll();
    if (mounted) setState(() => _highScores = scores);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated block background
          const AnimatedBlockBackground(
            accentColor: Color(0xFF6C5CE7),
            bgColor1: Color(0xFF0D0D1A),
            bgColor2: Color(0xFF2D1B69),
            shapeCount: 16,
          ),

          // Content
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 32),
                          _buildTitle(),
                          const SizedBox(height: 32),
                          _buildModeGrid(context),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE), Color(0xFF74B9FF)],
          ).createShader(bounds),
          child: const Text(
            'GRID',
            style: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 12,
              height: 1.0,
            ),
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53), Color(0xFFFFC107)],
          ).createShader(bounds),
          child: const Text(
            'MASTER',
            style: TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 16,
              height: 1.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModeGrid(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          children: [
            // Top row: Easy + Classic
            Row(
              children: [
                Expanded(
                  child: _buildModeCard(
                    context,
                    GameMode.easy,
                    const Color(0xFF00B894),
                    Icons.sentiment_satisfied_alt,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildModeCard(
                    context,
                    GameMode.classic,
                    const Color(0xFFFDCB6E),
                    Icons.grid_on,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Mid row: Master + Memory
            Row(
              children: [
                Expanded(
                  child: _buildModeCard(
                    context,
                    GameMode.master,
                    const Color(0xFFE17055),
                    Icons.local_fire_department,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildModeCard(
                    context,
                    GameMode.memory,
                    const Color(0xFFA29BFE),
                    Icons.psychology,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Bottom: Zen (full width)
            _buildModeCard(
              context,
              GameMode.zen,
              const Color(0xFF55EFC4),
              Icons.self_improvement,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeCard(
    BuildContext context,
    GameMode mode,
    Color color,
    IconData icon,
  ) {
    final highScore = _highScores[mode] ?? 0;

    return GestureDetector(
      onTap: () => context.go('/game/${mode.name}'),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.15),
              blurRadius: 12,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        mode.displayName,
                        style: TextStyle(
                          color: color,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${mode.gridSize}×${mode.gridSize}',
                          style: TextStyle(
                            color: color.withValues(alpha: 0.8),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    mode.description,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12,
                    ),
                  ),
                  if (highScore > 0)
                    Text(
                      'Best: $highScore',
                      style: TextStyle(
                        color: color.withValues(alpha: 0.6),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: color.withValues(alpha: 0.5),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
