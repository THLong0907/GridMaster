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
  String get highScore => 'EN YÜKSEK PUAN';

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
  String get settings => 'Ayarlar';

  @override
  String get sound => 'Ses';

  @override
  String get haptics => 'Titreşim';

  @override
  String get resetProgress => 'İlerlemeyi Sıfırla';

  @override
  String get resetConfirmTitle => 'Sıfırla?';

  @override
  String get resetConfirmContent =>
      'Yüksek puanlarınız ve açılmış temalar silinecek. Bu geri alınamaz.';

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
  String get leaderboard => 'Skor Tablosu';

  @override
  String get loading => 'Yükleniyor...';

  @override
  String get error => 'Hata';

  @override
  String get emptyLeaderboard => 'Henüz skor yok!';

  @override
  String get tutorialTitle => 'Nasıl Oynanır';

  @override
  String get tutorialStep1 => 'Blokları ızgaraya sürükleyin';

  @override
  String get tutorialStep2 => 'Satır veya sütunları doldurup temizleyin';

  @override
  String get tutorialStep3 => 'Çekiçle blokları kırın';

  @override
  String get tutorialStep4 => 'Yeriniz bitmesin!';

  @override
  String get clear => 'Temizlendi!';

  @override
  String get doubleClear => 'Çift Temizlik!';

  @override
  String get tripleClear => 'ÜÇ TEMİZLİK!';

  @override
  String megaClear(int count) {
    return 'MEGA TEMİZLİK! x$count';
  }

  @override
  String get memoryReveal => '👁️ Hafıza Açığa Çıktı!';

  @override
  String get zenClear => '🧘 Zen Temizlik!';

  @override
  String autoHammer(int count) {
    return '🔨 Oto Çekiç! ($count hücre)';
  }

  @override
  String get risingRow => '⬆️ Yükselen Satır!';

  @override
  String get autoDrop => '⏰ Oto Düşüş!';

  @override
  String get endSession => 'Bitir';

  @override
  String get findingRival => 'RAKİP ARANIYOR...';

  @override
  String matchmakingError(String error) {
    return 'Eşleşme hatası: $error';
  }

  @override
  String get zenSummaryTitle => 'Zen Oturumu';

  @override
  String get totalLines => 'Temizlenen Satırlar';

  @override
  String get maxCombo => 'Maks Kombo';

  @override
  String get blocksPlaced => 'Yerleştirilen Bloklar';

  @override
  String get playTime => 'Oyun Süresi';

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
  String get survivalMode => 'Hayatta Kal';

  @override
  String get pvpMode => 'PvP Savaş';

  @override
  String get practiceMode => 'Pratik';

  @override
  String get skip => 'Atla';

  @override
  String get next => 'İleri';

  @override
  String get start => 'BAŞLA!';
}
