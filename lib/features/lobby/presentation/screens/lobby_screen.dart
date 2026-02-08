import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:grid_master/features/game/domain/models/game_mode.dart';
import 'package:grid_master/shared/services/auth_service.dart';
import 'package:grid_master/shared/services/high_score_service.dart';
import 'package:grid_master/shared/services/leaderboard_service.dart';
import 'package:grid_master/shared/widgets/animated_block_background.dart';
import 'package:grid_master/shared/widgets/crown_widget.dart';
import 'package:grid_master/l10n/generated/app_localizations.dart';

/// Lobby screen with 5 game mode selection cards
class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key});

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  Map<GameMode, int> _highScores = {};
  Map<GameMode, bool> _top1Status = {};
  bool _isAnyTop1 = false;
  String _displayName = 'Player';

  @override
  void initState() {
    super.initState();
    _initLobby();
  }

  Future<void> _initLobby() async {
    await _loadHighScores();
    final name = await AuthService.getDisplayName();
    if (mounted) setState(() => _displayName = name);
    _checkAllTop1();
  }

  Future<void> _checkAllTop1() async {
    for (final mode in GameMode.values) {
      final isTop = await LeaderboardService.isTop1(mode);
      if (mounted) {
        setState(() {
          _top1Status[mode] = isTop;
          if (isTop) _isAnyTop1 = true;
        });
      }
    }
  }

  Future<void> _loadHighScores() async {
    final scores = await HighScoreService.loadAll();
    if (mounted) setState(() => _highScores = scores);
  }

  void _showNameChangeDialog() {
    final controller = TextEditingController(text: _displayName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A3E),
        title: Text(AppLocalizations.of(context)!.changeName, style: GoogleFonts.fredoka()),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.enterName,
            labelStyle: const TextStyle(color: Colors.white70),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) {
                await AuthService.setDisplayName(newName);
                if (mounted) setState(() => _displayName = newName);
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
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
                          const SizedBox(height: 16),
                          _buildProfileBar(),
                          const SizedBox(height: 24),
                          _buildLeaderboardButton(),
                          const SizedBox(height: 12),
                          _buildSettingsButton(),
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
        FittedBox(
          fit: BoxFit.scaleDown,
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE), Color(0xFF74B9FF)],
            ).createShader(bounds),
            child: Text(
              'GRID',
              style: GoogleFonts.fredoka(
                fontSize: 100,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 16,
                height: 1.0,
              ),
            ),
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53), Color(0xFFFFC107)],
            ).createShader(bounds),
            child: Text(
              'MASTER',
              style: GoogleFonts.fredoka(
                fontSize: 80,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 12,
                height: 1.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileBar() {
    return GestureDetector(
      onTap: _showNameChangeDialog,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.person, size: 16, color: Color(0xFF6C5CE7)),
            const SizedBox(width: 8),
            Text(
              _displayName,
              style: GoogleFonts.fredoka(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (_isAnyTop1) ...[
              const SizedBox(width: 8),
              const CrownWidget(size: 16),
            ],
            const SizedBox(width: 4),
            const Icon(Icons.edit, size: 12, color: Colors.white24),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6C5CE7).withValues(alpha: 0.1),
        foregroundColor: const Color(0xFFA29BFE),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: Color(0xFF6C5CE7), width: 1.5),
        ),
      ),
      onPressed: () => context.push('/leaderboard'),
      icon: const Icon(Icons.leaderboard),
      label: Text(
        AppLocalizations.of(context)!.leaderboard.toUpperCase(),
        style: GoogleFonts.fredoka(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingsButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withValues(alpha: 0.05),
        foregroundColor: Colors.white.withValues(alpha: 0.7),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
      ),
      onPressed: () => context.push('/settings'),
      icon: const Icon(Icons.settings_rounded, size: 18),
      label: Text(
        AppLocalizations.of(context)!.settings.toUpperCase(),
        style: GoogleFonts.fredoka(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildModeGrid(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          children: [
            // Top row: Easy + Classic
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _buildModeCard(
                      context,
                      GameMode.easy,
                      const Color(0xFF00B894),
                      Icons.stars,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildModeCard(
                      context,
                      GameMode.classic,
                      const Color(0xFFFDCB6E),
                      Icons.rocket_launch,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Mid row: Master + Memory
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _buildModeCard(
                      context,
                      GameMode.master,
                      const Color(0xFFE17055),
                      Icons.timer,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildModeCard(
                      context,
                      GameMode.memory,
                      const Color(0xFFA29BFE),
                      Icons.visibility_off,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Bottom row: Zen + Solo PvP
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _buildModeCard(
                      context,
                      GameMode.zen,
                      const Color(0xFF55EFC4),
                      Icons.spa,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildModeCard(
                      context,
                      GameMode.soloPvP,
                      const Color(0xFFFD79A8),
                      Icons.sports_kabaddi,
                    ),
                  ),
                ],
              ),
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
      onTap: () {
        if (mode == GameMode.soloPvP) {
          _showPvpSelectionDialog();
        } else {
          context.go('/game/${mode.name}');
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
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
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 8),
            if (_top1Status[mode] == true)
              const Padding(
                padding: EdgeInsets.only(right: 4),
                child: CrownWidget(size: 14),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${mode.displayName} ${mode.gridSize}×${mode.gridSize}', // Mode names need localization
                    style: GoogleFonts.fredoka(
                      color: color,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    mode.description,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    highScore > 0 ? 'Best: $highScore' : ' ',
                    style: TextStyle(
                      color: color.withValues(alpha: 0.6),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPvpSelectionDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Color(0xFF1A1A3E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
              Text(
                'SOLO PVP', // Keep or localize?
                style: GoogleFonts.fredoka(
                color: const Color(0xFFFD79A8),
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '8×8 Grid • 2 Minutes',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 28),
            // Ranked Match button
            _buildPvpOption(
              icon: Icons.people,
              title: AppLocalizations.of(ctx)!.pvpMode, // Or specialized key
              subtitle: 'Ghép ngẫu nhiên với người chơi thật', // Need to add to ARB or keep hardcoded? User said "chỉnh lại thành tiếng việt hết".
              color: const Color(0xFF6C5CE7),
              onTap: () {
                Navigator.pop(ctx);
                context.go('/game/soloPvP');
              },
            ),
            const SizedBox(height: 12),
            // Practice button
            _buildPvpOption(
              icon: Icons.sports_esports,
              title: AppLocalizations.of(ctx)!.practiceMode,
              subtitle: 'Chơi solo với BOT • Không tính xếp hạng',
              color: const Color(0xFF00B894),
              onTap: () {
                Navigator.pop(ctx);
                context.go('/game/soloPvP?practice=true');
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildPvpOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.fredoka(
                      color: color,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: color.withValues(alpha: 0.6)),
          ],
        ),
      ),
    );
  }
}
