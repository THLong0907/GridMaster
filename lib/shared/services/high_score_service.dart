import 'package:shared_preferences/shared_preferences.dart';

/// Service to persist and retrieve the high score
class HighScoreService {
  static const _key = 'grid_master_high_score';

  /// Load high score from storage
  static Future<int> load() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_key) ?? 0;
  }

  /// Save high score to storage
  static Future<void> save(int score) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(_key) ?? 0;
    if (score > current) {
      await prefs.setInt(_key, score);
    }
  }

  /// Force set high score
  static Future<void> set(int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, score);
  }
}
