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
  String get restart => 'RESTART';

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
  String get memoryReveal => 'Memory Reveal!';

  @override
  String get zenClear => 'Zen Clear!';

  @override
  String autoHammer(int count) {
    return 'Auto Hammer! ($count cells)';
  }

  @override
  String get risingRow => 'Rising Row!';

  @override
  String get autoDrop => 'Auto Drop!';

  @override
  String get endSession => 'End Session';

  @override
  String get findingRival => 'FINDING RIVAL...';

  @override
  String matchmakingError(String error) {
    return 'Matchmaking error: $error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => 'Lines Cleared';

  @override
  String get maxCombo => 'Max Combo';

  @override
  String get blocksPlaced => 'Blocks Placed';

  @override
  String get playTime => 'Play Time';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

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

  @override
  String get stats => 'Stats';

  @override
  String get achievements => 'Achievements';

  @override
  String get music => 'Music';

  @override
  String get themes => 'Themes';

  @override
  String get language => 'Language';

  @override
  String get chooseLanguage => 'Choose Language';

  @override
  String get autoDevice => 'Auto (Device)';

  @override
  String get data => 'Data';

  @override
  String best(int score) {
    return 'Best: $score';
  }

  @override
  String get easyDesc => 'Small grid, many small blocks';

  @override
  String get classicDesc => 'Rising rows, clear fast!';

  @override
  String get masterDesc => 'Auto-drop blocks, speed!';

  @override
  String get memoryDesc => 'Blocks vanish, remember positions';

  @override
  String get zenDesc => 'Relax, no lose';

  @override
  String get pvpDesc => '1v1 battle in 2 minutes';

  @override
  String get pvpRankedSubtitle => 'Random match with real players';

  @override
  String get pvpPracticeSubtitle => 'Play solo with BOT • Unranked';

  @override
  String get soloPvp => 'Solo PvP';

  @override
  String gridInfo(int size) {
    return '$size×$size Grid • 2 Minutes';
  }

  @override
  String get dailyChallenge => 'Daily Challenge';

  @override
  String get dailyChallengeSubtitle => 'New challenge every day!';

  @override
  String get streak => 'Streak';

  @override
  String get completed => 'Completed';

  @override
  String get play => 'PLAY';

  @override
  String get noConnection => 'No connection';

  @override
  String get tetEffects => 'Tết Effects';

  @override
  String get pause => 'Pause';

  @override
  String get resume => 'RESUME';

  @override
  String get quit => 'QUIT';

  @override
  String get paused => 'PAUSED';

  @override
  String get newFeatures => 'New Features';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get pvpWin => 'YOU WIN!';

  @override
  String get pvpLose => 'YOU LOSE';

  @override
  String get pvpDraw => 'DRAW';

  @override
  String get uploading => 'Uploading...';

  @override
  String get uploadToLeaderboard => 'Upload to Leaderboard';

  @override
  String get scoreUploaded => 'Score uploaded!';

  @override
  String get uploadFailed => 'Upload failed. Check connection.';

  @override
  String get tutorialReset => 'Tutorial will show on next game';

  @override
  String get highScoresCleared => 'All high scores cleared';

  @override
  String get botBeginner => 'Beginner';

  @override
  String get botPro => 'Professional';

  @override
  String get botDestroyer => 'Destroyer';

  @override
  String get botGodlike => 'Godlike';

  @override
  String get version => 'Version';

  @override
  String get engine => 'Engine';

  @override
  String get timer => 'TIMER';

  @override
  String get soundSubtitle => 'Game sound effects';

  @override
  String get hapticsSubtitle => 'Vibration feedback';

  @override
  String get musicSubtitle => 'Background music';

  @override
  String get tetSubtitle => 'Tết visual effects';

  @override
  String get tutorialSubtitle => 'Show tutorial again';

  @override
  String get resetSubtitle => 'Clear all high scores';

  @override
  String get shareScore => 'SHARE SCORE';

  @override
  String get you => 'YOU';

  @override
  String get rival => 'RIVAL';
}
