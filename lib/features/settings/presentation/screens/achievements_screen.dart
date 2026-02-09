import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grid_master/shared/services/achievement_service.dart';
import 'package:grid_master/shared/widgets/animated_block_background.dart';

/// Achievements screen showing unlocked/locked achievements
class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  Set<String> _unlocked = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final u = await AchievementService.getUnlocked();
    if (mounted) setState(() { _unlocked = u; _loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    final total = AchievementService.achievements.length;
    final unlockCount = _unlocked.length;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      body: Stack(
        children: [
          const AnimatedBlockBackground(),
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.white70),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '🏆 ACHIEVEMENTS',
                        style: GoogleFonts.fredoka(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD700)
                              .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFFFD700)
                                .withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          '$unlockCount/$total',
                          style: GoogleFonts.fredoka(
                            color: const Color(0xFFFFD700),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Progress bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: total > 0 ? unlockCount / total : 0,
                      minHeight: 8,
                      backgroundColor:
                          Colors.white.withValues(alpha: 0.1),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFFFFD700),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Achievements list
                Expanded(
                  child: _loading
                      ? const Center(
                          child: CircularProgressIndicator(
                              color: Color(0xFF6C5CE7)))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16),
                          itemCount: total,
                          itemBuilder: (context, index) {
                            final a =
                                AchievementService.achievements[index];
                            final isUnlocked =
                                _unlocked.contains(a.id);
                            return _achievementCard(a, isUnlocked);
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _achievementCard(Achievement a, bool isUnlocked) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnlocked
            ? const Color(0xFFFFD700).withValues(alpha: 0.08)
            : const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(16),
        border: isUnlocked
            ? Border.all(
                color: const Color(0xFFFFD700).withValues(alpha: 0.3))
            : null,
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isUnlocked
                  ? const Color(0xFFFFD700).withValues(alpha: 0.15)
                  : Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                isUnlocked ? a.icon : '🔒',
                style: TextStyle(
                  fontSize: 24,
                  color: isUnlocked ? null : Colors.white24,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Title + description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  a.title,
                  style: GoogleFonts.fredoka(
                    color: isUnlocked ? Colors.white : Colors.white54,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  a.description,
                  style: GoogleFonts.fredoka(
                    color: isUnlocked
                        ? Colors.white.withValues(alpha: 0.6)
                        : Colors.white.withValues(alpha: 0.3),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Checkmark
          if (isUnlocked)
            const Icon(Icons.check_circle, color: Color(0xFFFFD700), size: 24),
        ],
      ),
    );
  }
}
