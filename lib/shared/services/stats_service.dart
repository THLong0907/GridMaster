import 'package:shared_preferences/shared_preferences.dart';
import 'package:grid_master/features/game/domain/models/game_mode.dart';

/// Service to track and persist game statistics
class StatsService {
  static const _prefix = 'stats_';

  /// Record a completed game
  static Future<void> recordGame({
    required GameMode mode,
    required int score,
    required int linesCleared,
    required int secondsPlayed,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    // Global stats
    final totalGames = (prefs.getInt('${_prefix}totalGames') ?? 0) + 1;
    final totalScore = (prefs.getInt('${_prefix}totalScore') ?? 0) + score;
    final totalLines =
        (prefs.getInt('${_prefix}totalLines') ?? 0) + linesCleared;
    final totalTime =
        (prefs.getInt('${_prefix}totalTime') ?? 0) + secondsPlayed;

    await prefs.setInt('${_prefix}totalGames', totalGames);
    await prefs.setInt('${_prefix}totalScore', totalScore);
    await prefs.setInt('${_prefix}totalLines', totalLines);
    await prefs.setInt('${_prefix}totalTime', totalTime);

    // Per-mode stats
    final modeKey = mode.name;
    final modeGames =
        (prefs.getInt('$_prefix${modeKey}_games') ?? 0) + 1;
    final modeBest = prefs.getInt('$_prefix${modeKey}_best') ?? 0;

    await prefs.setInt('$_prefix${modeKey}_games', modeGames);
    if (score > modeBest) {
      await prefs.setInt('$_prefix${modeKey}_best', score);
    }
  }

  /// Get all statistics
  static Future<Map<String, dynamic>> getStats() async {
    final prefs = await SharedPreferences.getInstance();
    final stats = <String, dynamic>{
      'totalGames': prefs.getInt('${_prefix}totalGames') ?? 0,
      'totalScore': prefs.getInt('${_prefix}totalScore') ?? 0,
      'totalLines': prefs.getInt('${_prefix}totalLines') ?? 0,
      'totalTime': prefs.getInt('${_prefix}totalTime') ?? 0,
    };

    // Per-mode stats
    for (final mode in GameMode.values) {
      final key = mode.name;
      stats['${key}_games'] =
          prefs.getInt('$_prefix${key}_games') ?? 0;
      stats['${key}_best'] =
          prefs.getInt('$_prefix${key}_best') ?? 0;
    }

    return stats;
  }

  /// Clear all statistics
  static Future<void> clearStats() async {
    final prefs = await SharedPreferences.getInstance();
    final keys =
        prefs.getKeys().where((k) => k.startsWith(_prefix)).toList();
    for (final key in keys) {
      await prefs.remove(key);
    }
  }
}
