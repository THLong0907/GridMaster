// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Grid Master';

  @override
  String get score => 'WYNIK';

  @override
  String get highScore => 'REKORD';

  @override
  String get gameOver => 'KONIEC GRY';

  @override
  String get newHighScore => 'NOWY REKORD!';

  @override
  String get playAgain => 'GRAJ PONOWNIE';

  @override
  String get home => 'MENU';

  @override
  String get share => 'UDOSTĘPNIJ';

  @override
  String get settings => 'Ustawienia';

  @override
  String get sound => 'Dźwięk';

  @override
  String get haptics => 'Wibracje';

  @override
  String get resetProgress => 'Resetuj postępy';

  @override
  String get resetConfirmTitle => 'Resetować?';

  @override
  String get resetConfirmContent =>
      'To usunie rekordy i odblokowane motywy. Nie można cofnąć.';

  @override
  String get cancel => 'Anuluj';

  @override
  String get delete => 'Usuń';

  @override
  String get save => 'Zapisz';

  @override
  String get changeName => 'Zmień nazwę';

  @override
  String get enterName => 'Wpisz swoje imię';

  @override
  String get leaderboard => 'Tabela wyników';

  @override
  String get loading => 'Ładowanie...';

  @override
  String get error => 'Błąd';

  @override
  String get emptyLeaderboard => 'Brak wyników!';

  @override
  String get tutorialTitle => 'Jak grać';

  @override
  String get tutorialStep1 => 'Przeciągnij bloki na siatkę';

  @override
  String get tutorialStep2 => 'Wypełnij wiersze lub kolumny, aby wyczyścić';

  @override
  String get tutorialStep3 => 'Użyj młotka, aby zniszczyć bloki';

  @override
  String get tutorialStep4 => 'Nie zabraknie Ci miejsca!';

  @override
  String get clear => 'Wyczyszczono!';

  @override
  String get doubleClear => 'Podwójne wyczyszczenie!';

  @override
  String get tripleClear => 'POTRÓJNE WYCZYSZCZENIE!';

  @override
  String megaClear(int count) {
    return 'MEGA WYCZYSZCZENIE! x$count';
  }

  @override
  String get memoryReveal => '👁️ Odkrycie pamięci!';

  @override
  String get zenClear => '🧘 Zen Wyczyszczenie!';

  @override
  String autoHammer(int count) {
    return '🔨 Auto Młot! ($count komórek)';
  }

  @override
  String get risingRow => '⬆️ Wzrastający wiersz!';

  @override
  String get autoDrop => '⏰ Auto Zrzut!';

  @override
  String get endSession => 'Zakończ';

  @override
  String get findingRival => 'SZUKAMY RYWALA...';

  @override
  String matchmakingError(String error) {
    return 'Błąd wyszukiwania: $error';
  }

  @override
  String get zenSummaryTitle => 'Sesja Zen';

  @override
  String get totalLines => 'Wyczyszczone linie';

  @override
  String get maxCombo => 'Maks Combo';

  @override
  String get blocksPlaced => 'Umieszczone bloki';

  @override
  String get playTime => 'Czas gry';

  @override
  String get easyMode => 'Łatwy';

  @override
  String get memoryMode => 'Pamięć';

  @override
  String get classicMode => 'Klasyczny';

  @override
  String get masterMode => 'Mistrz';

  @override
  String get zenMode => 'Zen';

  @override
  String get survivalMode => 'Przetrwanie';

  @override
  String get pvpMode => 'PvP';

  @override
  String get practiceMode => 'Ćwiczenie';

  @override
  String get skip => 'Pomiń';

  @override
  String get next => 'Dalej';

  @override
  String get start => 'START!';
}
