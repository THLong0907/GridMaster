import 'dart:math';

/// Congratulation messages for streaks and combos
class GameStrings {
  GameStrings._();

  static const String appName = 'Grid Master';

  // Streak congratulation messages (English)
  static const List<String> streakMessages = [
    'Nice!',
    'Great!',
    'Excellent!',
    'Amazing!',
    'Fantastic!',
    'Incredible!',
    'Unstoppable!',
    'On Fire!',
    'Legendary!',
    'GODLIKE!',
  ];

  // Combo clear messages
  static const String singleClear = 'Clear!';
  static const String doubleClear = 'Double Clear!';
  static const String tripleClear = 'TRIPLE CLEAR!';

  static String getClearMessage(int linesCleared) {
    switch (linesCleared) {
      case 1:
        return singleClear;
      case 2:
        return doubleClear;
      case 3:
        return tripleClear;
      default:
        return linesCleared > 3 ? 'MEGA CLEAR! x$linesCleared' : '';
    }
  }

  /// Get a random streak message based on streak count
  static String getStreakMessage(int streak) {
    final index = (streak - 1).clamp(0, streakMessages.length - 1);
    return streakMessages[index];
  }

  /// Get a random congratulation message
  static String getRandomCongrats() {
    final random = Random();
    return streakMessages[random.nextInt(streakMessages.length)];
  }

  // UI strings
  static const String play = 'PLAY';
  static const String gameOver = 'Game Over';
  static const String score = 'SCORE';
  static const String highScore = 'HIGH SCORE';
  static const String newHighScore = 'NEW HIGH SCORE!';
  static const String playAgain = 'Play Again';
  static const String home = 'Home';
}
