// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Grid Master';

  @override
  String get score => 'PUAN';

  @override
  String get highScore => 'REKOR';

  @override
  String get gameOver => 'OYUN BİTTİ';

  @override
  String get newHighScore => 'YENİ REKOR!';

  @override
  String get playAgain => 'TEKRAR OYNA';

  @override
  String get home => 'ANA SAYFA';

  @override
  String get share => 'PAYLAŞ';

  @override
  String get restart => 'RESTART';

  @override
  String get settings => 'Ayarlar';

  @override
  String get sound => 'Ses';

  @override
  String get haptics => 'Titreşim';

  @override
  String get resetProgress => 'İlerlemeyi sıfırla';

  @override
  String get resetConfirmTitle => 'Sıfırla?';

  @override
  String get resetConfirmContent =>
      'Tüm puanlar ve temalar silinecek. Geri alınamaz.';

  @override
  String get cancel => 'İptal';

  @override
  String get delete => 'Sil';

  @override
  String get save => 'Kaydet';

  @override
  String get changeName => 'İsim değiştir';

  @override
  String get enterName => 'İsminizi girin';

  @override
  String get leaderboard => 'Sıralama';

  @override
  String get loading => 'Yükleniyor...';

  @override
  String get error => 'Hata';

  @override
  String get emptyLeaderboard => 'Henüz puan yok!';

  @override
  String get tutorialTitle => 'Nasıl oynanır';

  @override
  String get tutorialStep1 => 'Blokları ızgaraya sürükleyin';

  @override
  String get tutorialStep2 => 'Satır veya sütunları doldurun';

  @override
  String get tutorialStep3 => 'Çekiçle blokları kırın';

  @override
  String get tutorialStep4 => 'Yeriniz bitmesin!';

  @override
  String get clear => 'Harika!';

  @override
  String get doubleClear => 'Çift!';

  @override
  String get tripleClear => 'ÜÇLÜ!';

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
  String get endSession => 'Bitir';

  @override
  String get findingRival => 'RAKİP ARANIYOR...';

  @override
  String matchmakingError(String error) {
    return 'Eşleşme hatası: $error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => 'Silinen satırlar';

  @override
  String get maxCombo => 'Maks. kombo';

  @override
  String get blocksPlaced => 'Yerleştirilen bloklar';

  @override
  String get playTime => 'Oyun süresi';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

  @override
  String get easyMode => 'Kolay';

  @override
  String get memoryMode => 'Hafıza';

  @override
  String get classicMode => 'Klasik';

  @override
  String get masterMode => 'Usta';

  @override
  String get zenMode => 'Zen';

  @override
  String get survivalMode => 'Hayatta Kalma';

  @override
  String get pvpMode => 'PvP Savaş';

  @override
  String get practiceMode => 'Antrenman';

  @override
  String get skip => 'Atla';

  @override
  String get next => 'İleri';

  @override
  String get start => 'BAŞLA!';

  @override
  String get stats => 'İstatistikler';

  @override
  String get achievements => 'Başarılar';

  @override
  String get music => 'Müzik';

  @override
  String get themes => 'Temalar';

  @override
  String get language => 'Dil';

  @override
  String get chooseLanguage => 'Dil seçin';

  @override
  String get autoDevice => 'Otomatik (Cihaz)';

  @override
  String get data => 'Veri';

  @override
  String best(int score) {
    return 'En iyi: $score';
  }

  @override
  String get easyDesc => 'Küçük ızgara, küçük bloklar';

  @override
  String get classicDesc => 'Satırlar yükseliyor, hızlı sil!';

  @override
  String get masterDesc => 'Otomatik düşüş, hız!';

  @override
  String get memoryDesc => 'Bloklar kayboluyor, pozisyonları hatırla';

  @override
  String get zenDesc => 'Rahatla, kaybetme yok';

  @override
  String get pvpDesc => '2 dakikada 1v1 düello';

  @override
  String get pvpRankedSubtitle => 'Gerçek oyuncularla rastgele eşleşme';

  @override
  String get pvpPracticeSubtitle => 'BOT ile solo oyna • Sıralamasız';

  @override
  String get soloPvp => 'Solo PvP';

  @override
  String gridInfo(int size) {
    return '$size×$size Izgara • 2 dk';
  }

  @override
  String get dailyChallenge => 'Günlük meydan okuma';

  @override
  String get dailyChallengeSubtitle => 'Her gün yeni bir meydan okuma!';

  @override
  String get streak => 'Seri';

  @override
  String get completed => 'Tamamlandı';

  @override
  String get play => 'OYNA';

  @override
  String get noConnection => 'Bağlantı yok';

  @override
  String get tetEffects => 'Yılbaşı efektleri';

  @override
  String get pause => 'Duraklat';

  @override
  String get resume => 'DEVAM ET';

  @override
  String get quit => 'ÇIK';

  @override
  String get paused => 'DURAKLATILDI';

  @override
  String get newFeatures => 'Yeni özellikler';

  @override
  String get privacyPolicy => 'Gizlilik politikası';

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
