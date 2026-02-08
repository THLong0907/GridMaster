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
  String get score => 'PUNTOS';

  @override
  String get highScore => 'PINAKAMATAAS';

  @override
  String get gameOver => 'TAPOS NA';

  @override
  String get newHighScore => 'BAGONG RECORD!';

  @override
  String get playAgain => 'ULITIN';

  @override
  String get home => 'HOME';

  @override
  String get share => 'IBAHAGI';

  @override
  String get settings => 'Mga Setting';

  @override
  String get sound => 'Tunog';

  @override
  String get haptics => 'Vibration';

  @override
  String get resetProgress => 'I-reset ang Progress';

  @override
  String get resetConfirmTitle => 'I-reset?';

  @override
  String get resetConfirmContent =>
      'Mabubura ang high scores at mga na-unlock na tema. Hindi na ito maibabalik.';

  @override
  String get cancel => 'Kanselahin';

  @override
  String get delete => 'Burahin';

  @override
  String get save => 'I-save';

  @override
  String get changeName => 'Palitan ang Pangalan';

  @override
  String get enterName => 'Ilagay ang pangalan mo';

  @override
  String get leaderboard => 'Leaderboard';

  @override
  String get loading => 'Naglo-load...';

  @override
  String get error => 'Error';

  @override
  String get emptyLeaderboard => 'Wala pang scores!';

  @override
  String get tutorialTitle => 'Paano Maglaro';

  @override
  String get tutorialStep1 => 'I-drag ang blocks sa grid';

  @override
  String get tutorialStep2 => 'Punuin ang row o column para i-clear';

  @override
  String get tutorialStep3 => 'Gamitin ang martilyo para sirain ang blocks';

  @override
  String get tutorialStep4 => 'Huwag maubusan ng espasyo!';

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
    return '🔨 Auto Martilyo! ($count cells)';
  }

  @override
  String get risingRow => '⬆️ Pumapaitaas na Row!';

  @override
  String get autoDrop => '⏰ Auto Drop!';

  @override
  String get endSession => 'Tapusin';

  @override
  String get findingRival => 'NAGHAHANAP NG KALABAN...';

  @override
  String matchmakingError(String error) {
    return 'Error sa paghahanap: $error';
  }

  @override
  String get zenSummaryTitle => 'Zen Session';

  @override
  String get totalLines => 'Na-clear na Lines';

  @override
  String get maxCombo => 'Max Combo';

  @override
  String get blocksPlaced => 'Blocks na Nilagay';

  @override
  String get playTime => 'Oras ng Laro';

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
  String get practiceMode => 'Pagsasanay';

  @override
  String get skip => 'Laktawan';

  @override
  String get next => 'Susunod';

  @override
  String get start => 'SIMULA!';
}
