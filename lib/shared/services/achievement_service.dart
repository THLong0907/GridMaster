import 'package:shared_preferences/shared_preferences.dart';
import 'package:grid_master/features/game/domain/models/game_mode.dart';

/// Achievement definition
class Achievement {
  final String id;
  final String icon;
  final String title;
  final String description;
  final bool Function(Map<String, dynamic> stats) checkUnlock;

  const Achievement({
    required this.id,
    required this.icon,
    required this.title,
    required this.description,
    required this.checkUnlock,
  });
}

/// Service to manage achievements
class AchievementService {
  static const _prefix = 'achievement_';

  /// All achievements
  static final List<Achievement> achievements = [
    Achievement(
      id: 'first_game',
      icon: '🎮',
      title: 'First Steps',
      description: 'Play your first game',
      checkUnlock: (s) => (s['totalGames'] ?? 0) >= 1,
    ),
    Achievement(
      id: 'ten_games',
      icon: '🔟',
      title: 'Getting Started',
      description: 'Play 10 games',
      checkUnlock: (s) => (s['totalGames'] ?? 0) >= 10,
    ),
    Achievement(
      id: 'fifty_games',
      icon: '🏅',
      title: 'Dedicated Player',
      description: 'Play 50 games',
      checkUnlock: (s) => (s['totalGames'] ?? 0) >= 50,
    ),
    Achievement(
      id: 'hundred_games',
      icon: '💯',
      title: 'Block Master',
      description: 'Play 100 games',
      checkUnlock: (s) => (s['totalGames'] ?? 0) >= 100,
    ),
    Achievement(
      id: 'score_100',
      icon: '⭐',
      title: 'Rising Star',
      description: 'Score 100 points in a single game',
      checkUnlock: (s) {
        for (final mode in GameMode.values) {
          if ((s['${mode.name}_best'] ?? 0) >= 100) return true;
        }
        return false;
      },
    ),
    Achievement(
      id: 'score_500',
      icon: '🌟',
      title: 'Score Hunter',
      description: 'Score 500 points in a single game',
      checkUnlock: (s) {
        for (final mode in GameMode.values) {
          if ((s['${mode.name}_best'] ?? 0) >= 500) return true;
        }
        return false;
      },
    ),
    Achievement(
      id: 'score_1000',
      icon: '💫',
      title: 'Legendary Score',
      description: 'Score 1000 points in a single game',
      checkUnlock: (s) {
        for (final mode in GameMode.values) {
          if ((s['${mode.name}_best'] ?? 0) >= 1000) return true;
        }
        return false;
      },
    ),
    Achievement(
      id: 'all_modes',
      icon: '🌈',
      title: 'Explorer',
      description: 'Play every game mode at least once',
      checkUnlock: (s) {
        for (final mode in GameMode.values) {
          if ((s['${mode.name}_games'] ?? 0) < 1) return false;
        }
        return true;
      },
    ),
    Achievement(
      id: 'lines_100',
      icon: '📏',
      title: 'Line Destroyer',
      description: 'Clear 100 lines total',
      checkUnlock: (s) => (s['totalLines'] ?? 0) >= 100,
    ),
    Achievement(
      id: 'lines_500',
      icon: '🔥',
      title: 'Line Inferno',
      description: 'Clear 500 lines total',
      checkUnlock: (s) => (s['totalLines'] ?? 0) >= 500,
    ),
    Achievement(
      id: 'time_30min',
      icon: '⏰',
      title: 'Time Invested',
      description: 'Play for 30 minutes total',
      checkUnlock: (s) => (s['totalTime'] ?? 0) >= 1800,
    ),
    Achievement(
      id: 'time_2hr',
      icon: '⌛',
      title: 'Marathon Gamer',
      description: 'Play for 2 hours total',
      checkUnlock: (s) => (s['totalTime'] ?? 0) >= 7200,
    ),
  ];

  /// Check and unlock achievements based on current stats
  static Future<List<String>> checkAndUnlock(
      Map<String, dynamic> stats) async {
    final prefs = await SharedPreferences.getInstance();
    final newlyUnlocked = <String>[];

    for (final a in achievements) {
      final key = '$_prefix${a.id}';
      final wasUnlocked = prefs.getBool(key) ?? false;
      if (!wasUnlocked && a.checkUnlock(stats)) {
        await prefs.setBool(key, true);
        newlyUnlocked.add(a.id);
      }
    }

    return newlyUnlocked;
  }

  /// Get list of unlocked achievement IDs
  static Future<Set<String>> getUnlocked() async {
    final prefs = await SharedPreferences.getInstance();
    final unlocked = <String>{};
    for (final a in achievements) {
      if (prefs.getBool('$_prefix${a.id}') ?? false) {
        unlocked.add(a.id);
      }
    }
    return unlocked;
  }

  /// Clear all achievements
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    for (final a in achievements) {
      await prefs.remove('$_prefix${a.id}');
    }
  }
}
