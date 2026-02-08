// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Grid Master';

  @override
  String get score => 'SCORE';

  @override
  String get highScore => 'HIGH SCORE';

  @override
  String get gameOver => 'GAME OVER';

  @override
  String get newHighScore => 'NEW HIGH SCORE!';

  @override
  String get playAgain => 'PLAY AGAIN';

  @override
  String get home => 'HOME';

  @override
  String get share => 'SHARE';

  @override
  String get settings => 'Settings';

  @override
  String get sound => 'Sound';

  @override
  String get haptics => 'Haptics';

  @override
  String get resetProgress => 'Reset Progress';

  @override
  String get resetConfirmTitle => 'Reset Progress?';

  @override
  String get resetConfirmContent =>
      'This will delete your high scores and unlocked themes. This cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get save => 'Save';

  @override
  String get changeName => 'Change Display Name';

  @override
  String get enterName => 'Enter your name';

  @override
  String get leaderboard => 'Leaderboard';

  @override
  String get loading => 'Loading...';

  @override
  String get error => 'Error';

  @override
  String get emptyLeaderboard => 'No scores yet!';

  @override
  String get tutorialTitle => 'How to Play';

  @override
  String get tutorialStep1 => 'Drag blocks to the grid';

  @override
  String get tutorialStep2 => 'Fill rows or columns to clear';

  @override
  String get tutorialStep3 => 'Use hammers to break blocks';

  @override
  String get tutorialStep4 => 'Don\'t run out of space!';

  @override
  String get clear => 'Clear!';

  @override
  String get doubleClear => 'Double Clear!';

  @override
  String get tripleClear => 'TRIPLE CLEAR!';

  @override
  String megaClear(int count) {
    return 'MEGA CLEAR! x$count';
  }

  @override
  String get memoryReveal => '👁️ Memory Reveal!';

  @override
  String get zenClear => '🧘 Zen Clear!';

  @override
  String autoHammer(int count) {
    return '🔨 Auto Hammer! ($count cells)';
  }

  @override
  String get risingRow => '⬆️ Rising Row!';

  @override
  String get autoDrop => '⏰ Auto Drop!';

  @override
  String get endSession => 'End Session';

  @override
  String get findingRival => 'FINDING RIVAL...';

  @override
  String matchmakingError(String error) {
    return 'Matchmaking error: $error';
  }

  @override
  String get zenSummaryTitle => 'Zen Session';

  @override
  String get totalLines => 'Lines Cleared';

  @override
  String get maxCombo => 'Max Combo';

  @override
  String get blocksPlaced => 'Blocks Placed';

  @override
  String get playTime => 'Play Time';

  @override
  String get easyMode => 'Easy';

  @override
  String get memoryMode => 'Memory';

  @override
  String get classicMode => 'Classic';

  @override
  String get masterMode => 'Master';

  @override
  String get zenMode => 'Zen';

  @override
  String get survivalMode => 'Survival';

  @override
  String get pvpMode => 'PvP Battle';

  @override
  String get practiceMode => 'Do Practice';

  @override
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get start => 'START!';
}
