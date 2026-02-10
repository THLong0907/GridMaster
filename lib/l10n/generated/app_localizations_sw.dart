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
  String get score => 'POINTI';

  @override
  String get highScore => 'KUMBUKUMBU BORA';

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
  String get restart => 'RESTART';

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
      'Hii itafuta alama zako zote na mandhari zilizofunguliwa. Haiwezi kutenduliwa.';

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
  String get tutorialStep2 => 'Jaza safu mlalo au wima kufuta';

  @override
  String get tutorialStep3 => 'Tumia nyundo kuvunja';

  @override
  String get tutorialStep4 => 'Usikose nafasi!';

  @override
  String get clear => 'Poa!';

  @override
  String get doubleClear => 'Mbili!';

  @override
  String get tripleClear => 'TATU!';

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
  String get endSession => 'Maliza';

  @override
  String get findingRival => 'KUTAFUTA MPINZANI...';

  @override
  String matchmakingError(String error) {
    return 'Kosa la mechi: $error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => 'Mistari iliyofutwa';

  @override
  String get maxCombo => 'Kombo ya juu';

  @override
  String get blocksPlaced => 'Vitalu vilivyowekwa';

  @override
  String get playTime => 'Muda wa mchezo';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

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
  String get pvpMode => 'Vita vya PvP';

  @override
  String get practiceMode => 'Mazoezi';

  @override
  String get skip => 'Ruka';

  @override
  String get next => 'Ifuatayo';

  @override
  String get start => 'ANZA!';

  @override
  String get stats => 'Takwimu';

  @override
  String get achievements => 'Mafanikio';

  @override
  String get music => 'Muziki';

  @override
  String get themes => 'Mandhari';

  @override
  String get language => 'Lugha';

  @override
  String get chooseLanguage => 'Chagua lugha';

  @override
  String get autoDevice => 'Kiotomatiki (Kifaa)';

  @override
  String get data => 'Data';

  @override
  String best(int score) {
    return 'Bora: $score';
  }

  @override
  String get easyDesc => 'Gridi ndogo, vitalu vidogo';

  @override
  String get classicDesc => 'Safu zinapanda, futa haraka!';

  @override
  String get masterDesc => 'Kushuka kiotomatiki, kasi!';

  @override
  String get memoryDesc => 'Vitalu vinatoweka, kumbuka nafasi';

  @override
  String get zenDesc => 'Pumzika, hakuna kushindwa';

  @override
  String get pvpDesc => 'Pambano la 1v1 kwa dakika 2';

  @override
  String get pvpRankedSubtitle => 'Mechi nasibu na wachezaji halisi';

  @override
  String get pvpPracticeSubtitle => 'Cheza mwenyewe na BOT • Bila kiwango';

  @override
  String get soloPvp => 'PvP Peke yako';

  @override
  String gridInfo(int size) {
    return 'Gridi $size×$size • Dakika 2';
  }

  @override
  String get dailyChallenge => 'Changamoto ya kila siku';

  @override
  String get dailyChallengeSubtitle => 'Changamoto mpya kila siku!';

  @override
  String get streak => 'Mfululizo';

  @override
  String get completed => 'Imekamilika';

  @override
  String get play => 'CHEZA';

  @override
  String get noConnection => 'Hakuna muunganisho';

  @override
  String get tetEffects => 'Athari za Mwaka Mpya';

  @override
  String get pause => 'Simamisha';

  @override
  String get resume => 'ENDELEA';

  @override
  String get quit => 'ONDOKA';

  @override
  String get paused => 'IMESIMAMISHWA';

  @override
  String get newFeatures => 'Vipengele vipya';

  @override
  String get privacyPolicy => 'Sera ya faragha';

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
