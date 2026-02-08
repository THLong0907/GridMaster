// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get appTitle => 'Grid Master';

  @override
  String get score => 'ALAMA';

  @override
  String get highScore => 'ALAMA YA JUU';

  @override
  String get gameOver => 'MCHEZO UMEISHA';

  @override
  String get newHighScore => 'REKODI MPYA!';

  @override
  String get playAgain => 'CHEZA TENA';

  @override
  String get home => 'NYUMBANI';

  @override
  String get share => 'SHIRIKI';

  @override
  String get settings => 'Mipangilio';

  @override
  String get sound => 'Sauti';

  @override
  String get haptics => 'Mtetemo';

  @override
  String get resetProgress => 'Weka upya maendeleo';

  @override
  String get resetConfirmTitle => 'Weka upya?';

  @override
  String get resetConfirmContent =>
      'Hii itafuta alama zako za juu na mandhari yaliyofunguliwa. Hii haiwezi kurudishwa.';

  @override
  String get cancel => 'Ghairi';

  @override
  String get delete => 'Futa';

  @override
  String get save => 'Hifadhi';

  @override
  String get changeName => 'Badilisha jina';

  @override
  String get enterName => 'Ingiza jina lako';

  @override
  String get leaderboard => 'Ubao wa viongozi';

  @override
  String get loading => 'Inapakia...';

  @override
  String get error => 'Hitilafu';

  @override
  String get emptyLeaderboard => 'Hakuna alama bado!';

  @override
  String get tutorialTitle => 'Jinsi ya kucheza';

  @override
  String get tutorialStep1 => 'Buruta vitalu kwenye gridi';

  @override
  String get tutorialStep2 => 'Jaza safu au nguzo ili kufuta';

  @override
  String get tutorialStep3 => 'Tumia nyundo kuvunja vitalu';

  @override
  String get tutorialStep4 => 'Usikose nafasi!';

  @override
  String get clear => 'Imefutwa!';

  @override
  String get doubleClear => 'Kufuta Mara Mbili!';

  @override
  String get tripleClear => 'KUFUTA MARA TATU!';

  @override
  String megaClear(int count) {
    return 'MEGA KUFUTA! x$count';
  }

  @override
  String get memoryReveal => '👁️ Kumbukumbu imefunuliwa!';

  @override
  String get zenClear => '🧘 Zen Kufuta!';

  @override
  String autoHammer(int count) {
    return '🔨 Nyundo ya Kiotomatiki! (seli $count)';
  }

  @override
  String get risingRow => '⬆️ Safu inayopanda!';

  @override
  String get autoDrop => '⏰ Kushuka kiotomatiki!';

  @override
  String get endSession => 'Maliza Kipindi';

  @override
  String get findingRival => 'KUTAFUTA MPINZANI...';

  @override
  String matchmakingError(String error) {
    return 'Hitilafu ya utafutaji: $error';
  }

  @override
  String get zenSummaryTitle => 'Kipindi cha Zen';

  @override
  String get totalLines => 'Safu zilizofutwa';

  @override
  String get maxCombo => 'Combo ya Juu';

  @override
  String get blocksPlaced => 'Vitalu vilivyowekwa';

  @override
  String get playTime => 'Muda wa mchezo';

  @override
  String get easyMode => 'Rahisi';

  @override
  String get memoryMode => 'Kumbukumbu';

  @override
  String get classicMode => 'Kawaida';

  @override
  String get masterMode => 'Bingwa';

  @override
  String get zenMode => 'Zen';

  @override
  String get survivalMode => 'Kuishi';

  @override
  String get pvpMode => 'PvP Vita';

  @override
  String get practiceMode => 'Mazoezi';

  @override
  String get skip => 'Ruka';

  @override
  String get next => 'Inayofuata';

  @override
  String get start => 'ANZA!';
}
