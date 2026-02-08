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
  String get gameOver => 'TAMAT PERMAINAN';

  @override
  String get newHighScore => 'REKOD BARU!';

  @override
  String get playAgain => 'MAIN LAGI';

  @override
  String get home => 'UTAMA';

  @override
  String get share => 'KONGSI';

  @override
  String get settings => 'Tetapan';

  @override
  String get sound => 'Bunyi';

  @override
  String get haptics => 'Getaran';

  @override
  String get resetProgress => 'Set Semula Kemajuan';

  @override
  String get resetConfirmTitle => 'Set Semula?';

  @override
  String get resetConfirmContent =>
      'Ini akan memadamkan skor tertinggi dan tema yang dibuka. Tidak boleh diundur.';

  @override
  String get cancel => 'Batal';

  @override
  String get delete => 'Padam';

  @override
  String get save => 'Simpan';

  @override
  String get changeName => 'Tukar Nama';

  @override
  String get enterName => 'Masukkan nama anda';

  @override
  String get leaderboard => 'Papan Pendahulu';

  @override
  String get loading => 'Memuatkan...';

  @override
  String get error => 'Ralat';

  @override
  String get emptyLeaderboard => 'Tiada skor lagi!';

  @override
  String get tutorialTitle => 'Cara Bermain';

  @override
  String get tutorialStep1 => 'Seret blok ke grid';

  @override
  String get tutorialStep2 => 'Isi baris atau lajur untuk mengosongkan';

  @override
  String get tutorialStep3 => 'Guna tukul untuk pecahkan blok';

  @override
  String get tutorialStep4 => 'Jangan kehabisan ruang!';

  @override
  String get clear => 'Kosong!';

  @override
  String get doubleClear => 'Kosong Berganda!';

  @override
  String get tripleClear => 'KOSONG TIGA KALI!';

  @override
  String megaClear(int count) {
    return 'MEGA KOSONG! x$count';
  }

  @override
  String get memoryReveal => '👁️ Dedah Memori!';

  @override
  String get zenClear => '🧘 Zen Kosong!';

  @override
  String autoHammer(int count) {
    return '🔨 Tukul Auto! ($count sel)';
  }

  @override
  String get risingRow => '⬆️ Baris Naik!';

  @override
  String get autoDrop => '⏰ Jatuh Auto!';

  @override
  String get endSession => 'Tamat Sesi';

  @override
  String get findingRival => 'MENCARI LAWAN...';

  @override
  String matchmakingError(String error) {
    return 'Ralat padanan: $error';
  }

  @override
  String get zenSummaryTitle => 'Sesi Zen';

  @override
  String get totalLines => 'Baris Dikosongkan';

  @override
  String get maxCombo => 'Kombo Maks';

  @override
  String get blocksPlaced => 'Blok Diletakkan';

  @override
  String get playTime => 'Masa Bermain';

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
  String get pvpMode => 'PvP';

  @override
  String get practiceMode => 'Latihan';

  @override
  String get skip => 'Langkau';

  @override
  String get next => 'Seterusnya';

  @override
  String get start => 'MULA!';
}
