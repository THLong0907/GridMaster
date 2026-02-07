import 'package:shared_preferences/shared_preferences.dart';
import 'package:grid_master/features/game/domain/models/game_mode.dart';

/// Persists high scores per game mode using SharedPreferences
class HighScoreService {
  HighScoreService._();

  static String _key(GameMode mode) => 'high_score_${mode.name}';

  /// Load high score for a specific mode
  static Future<int> load([GameMode mode = GameMode.easy]) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_key(mode)) ?? 0;
  }

  /// Save high score for a specific mode
  static Future<void> save(int score, [GameMode mode = GameMode.easy]) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key(mode), score);
  }

  /// Load all high scores (for lobby display)
  static Future<Map<GameMode, int>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final result = <GameMode, int>{};
    for (final mode in GameMode.values) {
      result[mode] = prefs.getInt(_key(mode)) ?? 0;
    }
    return result;
  }
}
