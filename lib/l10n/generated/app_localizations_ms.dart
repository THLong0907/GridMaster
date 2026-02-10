// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get appTitle => 'Grid Master';

  @override
  String get score => 'SKOR';

  @override
  String get highScore => 'SKOR TERTINGGI';

  @override
  String get gameOver => 'PERMAINAN TAMAT';

  @override
  String get newHighScore => 'REKOD BARU!';

  @override
  String get playAgain => 'MAIN LAGI';

  @override
  String get home => 'UTAMA';

  @override
  String get share => 'KONGSI';

  @override
  String get restart => 'RESTART';

  @override
  String get settings => 'Tetapan';

  @override
  String get sound => 'Bunyi';

  @override
  String get haptics => 'Getaran';

  @override
  String get resetProgress => 'Set semula kemajuan';

  @override
  String get resetConfirmTitle => 'Set semula?';

  @override
  String get resetConfirmContent =>
      'Semua skor dan tema akan dipadamkan. Tidak boleh dibatalkan.';

  @override
  String get cancel => 'Batal';

  @override
  String get delete => 'Padam';

  @override
  String get save => 'Simpan';

  @override
  String get changeName => 'Tukar nama';

  @override
  String get enterName => 'Masukkan nama anda';

  @override
  String get leaderboard => 'Papan pendahulu';

  @override
  String get loading => 'Memuatkan...';

  @override
  String get error => 'Ralat';

  @override
  String get emptyLeaderboard => 'Tiada skor lagi!';

  @override
  String get tutorialTitle => 'Cara bermain';

  @override
  String get tutorialStep1 => 'Seret blok ke grid';

  @override
  String get tutorialStep2 => 'Isi baris atau lajur untuk menghapuskan';

  @override
  String get tutorialStep3 => 'Guna tukul untuk memecahkan';

  @override
  String get tutorialStep4 => 'Jangan kehabisan ruang!';

  @override
  String get clear => 'Hebat!';

  @override
  String get doubleClear => 'Berganda!';

  @override
  String get tripleClear => 'TIGA KALI!';

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
  String get endSession => 'Tamat';

  @override
  String get findingRival => 'MENCARI PESAING...';

  @override
  String matchmakingError(String error) {
    return 'Ralat padanan: $error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => 'Baris dipadam';

  @override
  String get maxCombo => 'Kombo maks';

  @override
  String get blocksPlaced => 'Blok diletakkan';

  @override
  String get playTime => 'Masa bermain';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

  @override
  String get easyMode => 'Mudah';

  @override
  String get memoryMode => 'Memori';

  @override
  String get classicMode => 'Klasik';

  @override
  String get masterMode => 'Master';

  @override
  String get zenMode => 'Zen';

  @override
  String get survivalMode => 'Bertahan';

  @override
  String get pvpMode => 'Pertempuran PvP';

  @override
  String get practiceMode => 'Latihan';

  @override
  String get skip => 'Langkau';

  @override
  String get next => 'Seterusnya';

  @override
  String get start => 'MULA!';

  @override
  String get stats => 'Statistik';

  @override
  String get achievements => 'Pencapaian';

  @override
  String get music => 'Muzik';

  @override
  String get themes => 'Tema';

  @override
  String get language => 'Bahasa';

  @override
  String get chooseLanguage => 'Pilih bahasa';

  @override
  String get autoDevice => 'Auto (Peranti)';

  @override
  String get data => 'Data';

  @override
  String best(int score) {
    return 'Terbaik: $score';
  }

  @override
  String get easyDesc => 'Grid kecil, banyak blok kecil';

  @override
  String get classicDesc => 'Baris meningkat, padam cepat!';

  @override
  String get masterDesc => 'Jatuh automatik, laju!';

  @override
  String get memoryDesc => 'Blok hilang, ingat kedudukan';

  @override
  String get zenDesc => 'Santai, tiada kekalahan';

  @override
  String get pvpDesc => 'Duel 1v1 dalam 2 minit';

  @override
  String get pvpRankedSubtitle => 'Perlawanan rawak dengan pemain sebenar';

  @override
  String get pvpPracticeSubtitle => 'Main solo melawan BOT • Tanpa ranking';

  @override
  String get soloPvp => 'Solo PvP';

  @override
  String gridInfo(int size) {
    return 'Grid $size×$size • 2 minit';
  }

  @override
  String get dailyChallenge => 'Cabaran harian';

  @override
  String get dailyChallengeSubtitle => 'Cabaran baru setiap hari!';

  @override
  String get streak => 'Berturut-turut';

  @override
  String get completed => 'Siap';

  @override
  String get play => 'MAIN';

  @override
  String get noConnection => 'Tiada sambungan';

  @override
  String get tetEffects => 'Kesan Tahun Baru';

  @override
  String get pause => 'Jeda';

  @override
  String get resume => 'SAMBUNG';

  @override
  String get quit => 'KELUAR';

  @override
  String get paused => 'DIJEDA';

  @override
  String get newFeatures => 'Ciri baru';

  @override
  String get privacyPolicy => 'Dasar privasi';

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
