import 'package:shared_preferences/shared_preferences.dart';

/// Daily Challenge service — deterministic seed from date, streak tracking
class DailyChallengeService {
  DailyChallengeService._();
  static final instance = DailyChallengeService._();

  /// Generate a deterministic seed from today's date
  int get todaySeed {
    final now = DateTime.now();
    return now.year * 10000 + now.month * 100 + now.day;
  }

  /// Key for today's date string
  String get _todayKey {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  /// Check if today's challenge has been completed
  Future<bool> isCompletedToday() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('daily_last_completed') == _todayKey;
  }

  /// Get today's best score
  Future<int> getTodayBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'daily_score_$_todayKey';
    return prefs.getInt(key) ?? 0;
  }

  /// Save score for today's challenge
  Future<void> saveScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'daily_score_$_todayKey';
    final current = prefs.getInt(key) ?? 0;
    if (score > current) {
      await prefs.setInt(key, score);
    }
    await prefs.setString('daily_last_completed', _todayKey);
    // Update streak
    await _updateStreak();
  }

  /// Get current streak
  Future<int> getStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('daily_streak') ?? 0;
  }

  Future<void> _updateStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final lastDate = prefs.getString('daily_streak_date') ?? '';
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final yesterdayKey =
        '${yesterday.year}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2, '0')}';

    int streak = prefs.getInt('daily_streak') ?? 0;
    if (lastDate == yesterdayKey) {
      streak++;
    } else if (lastDate != _todayKey) {
      streak = 1; // Reset streak
    }
    await prefs.setInt('daily_streak', streak);
    await prefs.setString('daily_streak_date', _todayKey);
  }
}
