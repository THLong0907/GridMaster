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
  String get restart => 'RESTART';

  @override
  String get settings => 'Pengaturan';

  @override
  String get sound => 'Suara';

  @override
  String get haptics => 'Getaran';

  @override
  String get resetProgress => 'Atur ulang kemajuan';

  @override
  String get resetConfirmTitle => 'Atur ulang?';

  @override
  String get resetConfirmContent =>
      'Semua skor dan tema akan dihapus. Tidak bisa dibatalkan.';

  @override
  String get cancel => 'Batal';

  @override
  String get delete => 'Hapus';

  @override
  String get save => 'Simpan';

  @override
  String get changeName => 'Ubah nama';

  @override
  String get enterName => 'Masukkan nama Anda';

  @override
  String get leaderboard => 'Papan peringkat';

  @override
  String get loading => 'Memuat...';

  @override
  String get error => 'Kesalahan';

  @override
  String get emptyLeaderboard => 'Belum ada skor!';

  @override
  String get tutorialTitle => 'Cara bermain';

  @override
  String get tutorialStep1 => 'Seret blok ke grid';

  @override
  String get tutorialStep2 => 'Isi baris atau kolom untuk menghapus';

  @override
  String get tutorialStep3 => 'Gunakan palu untuk menghancurkan';

  @override
  String get tutorialStep4 => 'Jangan kehabisan ruang!';

  @override
  String get clear => 'Hebat!';

  @override
  String get doubleClear => 'Ganda!';

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
  String get endSession => 'Akhiri';

  @override
  String get findingRival => 'MENCARI RIVAL...';

  @override
  String matchmakingError(String error) {
    return 'Kesalahan matchmaking: $error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => 'Baris terhapus';

  @override
  String get maxCombo => 'Kombo maks';

  @override
  String get blocksPlaced => 'Blok ditempatkan';

  @override
  String get playTime => 'Waktu bermain';

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
  String get pvpMode => 'Pertarungan PvP';

  @override
  String get practiceMode => 'Latihan';

  @override
  String get skip => 'Lewati';

  @override
  String get next => 'Berikutnya';

  @override
  String get start => 'MULAI!';

  @override
  String get stats => 'Statistik';

  @override
  String get achievements => 'Pencapaian';

  @override
  String get music => 'Musik';

  @override
  String get themes => 'Tema';

  @override
  String get language => 'Bahasa';

  @override
  String get chooseLanguage => 'Pilih bahasa';

  @override
  String get autoDevice => 'Otomatis (Perangkat)';

  @override
  String get data => 'Data';

  @override
  String best(int score) {
    return 'Terbaik: $score';
  }

  @override
  String get easyDesc => 'Grid kecil, blok kecil banyak';

  @override
  String get classicDesc => 'Baris naik, hapus cepat!';

  @override
  String get masterDesc => 'Jatuh otomatis, kecepatan!';

  @override
  String get memoryDesc => 'Blok menghilang, ingat posisi';

  @override
  String get zenDesc => 'Santai, tidak kalah';

  @override
  String get pvpDesc => 'Duel 1v1 dalam 2 menit';

  @override
  String get pvpRankedSubtitle => 'Pertandingan acak dengan pemain nyata';

  @override
  String get pvpPracticeSubtitle =>
      'Main sendiri melawan BOT • Tanpa peringkat';

  @override
  String get soloPvp => 'Solo PvP';

  @override
  String gridInfo(int size) {
    return 'Grid $size×$size • 2 menit';
  }

  @override
  String get dailyChallenge => 'Tantangan harian';

  @override
  String get dailyChallengeSubtitle => 'Tantangan baru setiap hari!';

  @override
  String get streak => 'Beruntun';

  @override
  String get completed => 'Selesai';

  @override
  String get play => 'MAIN';

  @override
  String get noConnection => 'Tidak ada koneksi';

  @override
  String get tetEffects => 'Efek Tahun Baru';

  @override
  String get pause => 'Jeda';

  @override
  String get resume => 'LANJUTKAN';

  @override
  String get quit => 'KELUAR';

  @override
  String get paused => 'DIJEDA';

  @override
  String get newFeatures => 'Fitur baru';

  @override
  String get privacyPolicy => 'Kebijakan privasi';

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
