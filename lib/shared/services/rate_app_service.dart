import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service to prompt users for app store review after
/// they've played enough games to have a good impression.
class RateAppService {
  static const _keyGamesPlayed = 'rate_games_played';
  static const _keyHasRated = 'rate_has_rated';
  static const _gamesBeforePrompt = 5;

  /// Call after each game over. Will prompt for review
  /// once the user has played enough games and hasn't been asked before.
  static Future<void> checkAndPrompt() async {
    final prefs = await SharedPreferences.getInstance();
    final hasRated = prefs.getBool(_keyHasRated) ?? false;
    if (hasRated) return;

    final gamesPlayed = (prefs.getInt(_keyGamesPlayed) ?? 0) + 1;
    await prefs.setInt(_keyGamesPlayed, gamesPlayed);

    if (gamesPlayed >= _gamesBeforePrompt) {
      final inAppReview = InAppReview.instance;
      if (await inAppReview.isAvailable()) {
        await inAppReview.requestReview();
        await prefs.setBool(_keyHasRated, true);
      }
    }
  }
}
