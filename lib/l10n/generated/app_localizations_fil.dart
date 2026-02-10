// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class AppLocalizationsFil extends AppLocalizations {
  AppLocalizationsFil([String locale = 'fil']) : super(locale);

  @override
  String get appTitle => 'Grid Master';

  @override
  String get score => 'ISKOR';

  @override
  String get highScore => 'PINAKAMATAAS NA ISKOR';

  @override
  String get gameOver => 'TAPOS NA ANG LARO';

  @override
  String get newHighScore => 'BAGONG REKORD!';

  @override
  String get playAgain => 'MAGLARO MULI';

  @override
  String get home => 'HOME';

  @override
  String get share => 'IBAHAGI';

  @override
  String get restart => 'RESTART';

  @override
  String get settings => 'Mga Setting';

  @override
  String get sound => 'Tunog';

  @override
  String get haptics => 'Vibration';

  @override
  String get resetProgress => 'I-reset ang progreso';

  @override
  String get resetConfirmTitle => 'I-reset?';

  @override
  String get resetConfirmContent =>
      'Mabubura lahat ng iskor at tema. Hindi na ito maibabalik.';

  @override
  String get cancel => 'Kanselahin';

  @override
  String get delete => 'Burahin';

  @override
  String get save => 'I-save';

  @override
  String get changeName => 'Palitan ang pangalan';

  @override
  String get enterName => 'Ilagay ang pangalan mo';

  @override
  String get leaderboard => 'Leaderboard';

  @override
  String get loading => 'Naglo-load...';

  @override
  String get error => 'Error';

  @override
  String get emptyLeaderboard => 'Wala pang iskor!';

  @override
  String get tutorialTitle => 'Paano maglaro';

  @override
  String get tutorialStep1 => 'I-drag ang blocks sa grid';

  @override
  String get tutorialStep2 => 'Punuin ang rows o columns para burahin';

  @override
  String get tutorialStep3 => 'Gamitin ang martilyo para sirain';

  @override
  String get tutorialStep4 => 'Huwag maubusan ng espasyo!';

  @override
  String get clear => 'Galing!';

  @override
  String get doubleClear => 'Doble!';

  @override
  String get tripleClear => 'TRIPLE!';

  @override
  String megaClear(int count) {
    return 'MEGA! x$count';
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
  String get endSession => 'Tapusin';

  @override
  String get findingRival => 'NAGHAHANAP NG KALABAN...';

  @override
  String matchmakingError(String error) {
    return 'Error sa matchmaking: $error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => 'Nabura na linya';

  @override
  String get maxCombo => 'Max combo';

  @override
  String get blocksPlaced => 'Nalagay na block';

  @override
  String get playTime => 'Oras ng laro';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

  @override
  String get easyMode => 'Madali';

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
  String get pvpMode => 'PvP Laban';

  @override
  String get practiceMode => 'Praktis';

  @override
  String get skip => 'Laktawan';

  @override
  String get next => 'Susunod';

  @override
  String get start => 'SIMULA!';

  @override
  String get stats => 'Stats';

  @override
  String get achievements => 'Achievements';

  @override
  String get music => 'Musika';

  @override
  String get themes => 'Mga Tema';

  @override
  String get language => 'Wika';

  @override
  String get chooseLanguage => 'Pumili ng wika';

  @override
  String get autoDevice => 'Auto (Device)';

  @override
  String get data => 'Data';

  @override
  String best(int score) {
    return 'Pinakamataas: $score';
  }

  @override
  String get easyDesc => 'Maliit na grid, maraming maliit na bloke';

  @override
  String get classicDesc => 'Tumataas na row, mabilis na burahin!';

  @override
  String get masterDesc => 'Auto-drop, bilis!';

  @override
  String get memoryDesc => 'Nawawala ang bloke, tandaan ang posisyon';

  @override
  String get zenDesc => 'Relax, walang talo';

  @override
  String get pvpDesc => '1v1 laban sa 2 minuto';

  @override
  String get pvpRankedSubtitle => 'Random match sa totoong manlalaro';

  @override
  String get pvpPracticeSubtitle => 'Solo laban sa BOT • Walang ranking';

  @override
  String get soloPvp => 'Solo PvP';

  @override
  String gridInfo(int size) {
    return '$size×$size Grid • 2 Minuto';
  }

  @override
  String get dailyChallenge => 'Daily Challenge';

  @override
  String get dailyChallengeSubtitle => 'Bagong hamon araw-araw!';

  @override
  String get streak => 'Sunod-sunod';

  @override
  String get completed => 'Tapos na';

  @override
  String get play => 'LARO';

  @override
  String get noConnection => 'Walang koneksyon';

  @override
  String get tetEffects => 'New Year effects';

  @override
  String get pause => 'I-pause';

  @override
  String get resume => 'ITULOY';

  @override
  String get quit => 'UMALIS';

  @override
  String get paused => 'NAKA-PAUSE';

  @override
  String get newFeatures => 'Mga bagong feature';

  @override
  String get privacyPolicy => 'Privacy policy';

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
  String get tetSubtitle => 'Tet visual effects';

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
