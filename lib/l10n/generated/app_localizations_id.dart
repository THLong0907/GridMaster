// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Grid Master';

  @override
  String get score => 'SKOR';

  @override
  String get highScore => 'SKOR TERTINGGI';

  @override
  String get gameOver => 'PERMAINAN BERAKHIR';

  @override
  String get newHighScore => 'REKOR BARU!';

  @override
  String get playAgain => 'MAIN LAGI';

  @override
  String get home => 'BERANDA';

  @override
  String get share => 'BAGIKAN';

  @override
  String get settings => 'Pengaturan';

  @override
  String get sound => 'Suara';

  @override
  String get haptics => 'Getaran';

  @override
  String get resetProgress => 'Reset Kemajuan';

  @override
  String get resetConfirmTitle => 'Reset Kemajuan?';

  @override
  String get resetConfirmContent =>
      'Ini akan menghapus skor tertinggi dan tema yang sudah dibuka. Tidak bisa dibatalkan.';

  @override
  String get cancel => 'Batal';

  @override
  String get delete => 'Hapus';

  @override
  String get save => 'Simpan';

  @override
  String get changeName => 'Ubah Nama';

  @override
  String get enterName => 'Masukkan nama Anda';

  @override
  String get leaderboard => 'Papan Peringkat';

  @override
  String get loading => 'Memuat...';

  @override
  String get error => 'Kesalahan';

  @override
  String get emptyLeaderboard => 'Belum ada skor!';

  @override
  String get tutorialTitle => 'Cara Bermain';

  @override
  String get tutorialStep1 => 'Seret blok ke grid';

  @override
  String get tutorialStep2 => 'Isi baris atau kolom untuk menghapus';

  @override
  String get tutorialStep3 => 'Gunakan palu untuk menghancurkan blok';

  @override
  String get tutorialStep4 => 'Jangan kehabisan ruang!';

  @override
  String get clear => 'Hapus!';

  @override
  String get doubleClear => 'Double Hapus!';

  @override
  String get tripleClear => 'TRIPLE HAPUS!';

  @override
  String megaClear(int count) {
    return 'MEGA HAPUS! x$count';
  }

  @override
  String get memoryReveal => '👁️ Pengungkapan Memori!';

  @override
  String get zenClear => '🧘 Zen Hapus!';

  @override
  String autoHammer(int count) {
    return '🔨 Palu Otomatis! ($count sel)';
  }

  @override
  String get risingRow => '⬆️ Baris Naik!';

  @override
  String get autoDrop => '⏰ Jatuh Otomatis!';

  @override
  String get endSession => 'Akhiri Sesi';

  @override
  String get findingRival => 'MENCARI LAWAN...';

  @override
  String matchmakingError(String error) {
    return 'Kesalahan pencarian: $error';
  }

  @override
  String get zenSummaryTitle => 'Sesi Zen';

  @override
  String get totalLines => 'Baris Dihapus';

  @override
  String get maxCombo => 'Kombo Maks';

  @override
  String get blocksPlaced => 'Blok Ditempatkan';

  @override
  String get playTime => 'Waktu Bermain';

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
  String get skip => 'Lewati';

  @override
  String get next => 'Lanjut';

  @override
  String get start => 'MULAI!';
}
