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
  String get playAgain => 'ZAGRAJ PONOWNIE';

  @override
  String get home => 'MENU';

  @override
  String get share => 'UDOSTĘPNIJ';

  @override
  String get restart => 'RESTART';

  @override
  String get settings => 'Ustawienia';

  @override
  String get sound => 'Dźwięk';

  @override
  String get haptics => 'Wibracja';

  @override
  String get resetProgress => 'Resetuj postęp';

  @override
  String get resetConfirmTitle => 'Resetować?';

  @override
  String get resetConfirmContent =>
      'Usunie to wyniki i odblokowane motywy. Nie można cofnąć.';

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
  String get leaderboard => 'Ranking';

  @override
  String get loading => 'Ładowanie...';

  @override
  String get error => 'Błąd';

  @override
  String get emptyLeaderboard => 'Brak wyników!';

  @override
  String get tutorialTitle => 'Jak grać';

  @override
  String get tutorialStep1 => 'Przeciągnij klocki na siatkę';

  @override
  String get tutorialStep2 => 'Wypełnij rzędy lub kolumny';

  @override
  String get tutorialStep3 => 'Użyj młotka do niszczenia';

  @override
  String get tutorialStep4 => 'Nie zabraknie ci miejsca!';

  @override
  String get clear => 'Świetnie!';

  @override
  String get doubleClear => 'Podwójne!';

  @override
  String get tripleClear => 'POTRÓJNE!';

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
  String get endSession => 'Zakończ';

  @override
  String get findingRival => 'SZUKAM RYWALA...';

  @override
  String matchmakingError(String error) {
    return 'Błąd matchmakingu: $error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => 'Usunięte linie';

  @override
  String get maxCombo => 'Maks. combo';

  @override
  String get blocksPlaced => 'Umieszczone klocki';

  @override
  String get playTime => 'Czas gry';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

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
  String get pvpMode => 'Walka PvP';

  @override
  String get practiceMode => 'Trening';

  @override
  String get skip => 'Pomiń';

  @override
  String get next => 'Dalej';

  @override
  String get start => 'START!';

  @override
  String get stats => 'Statystyki';

  @override
  String get achievements => 'Osiągnięcia';

  @override
  String get music => 'Muzyka';

  @override
  String get themes => 'Motywy';

  @override
  String get language => 'Język';

  @override
  String get chooseLanguage => 'Wybierz język';

  @override
  String get autoDevice => 'Auto (Urządzenie)';

  @override
  String get data => 'Dane';

  @override
  String best(int score) {
    return 'Najlepszy: $score';
  }

  @override
  String get easyDesc => 'Mała siatka, małe klocki';

  @override
  String get classicDesc => 'Rzędy rosną, usuwaj szybko!';

  @override
  String get masterDesc => 'Auto-zrzut, szybkość!';

  @override
  String get memoryDesc => 'Klocki znikają, zapamiętaj pozycje';

  @override
  String get zenDesc => 'Relaks, bez przegrywania';

  @override
  String get pvpDesc => 'Pojedynek 1v1 w 2 minuty';

  @override
  String get pvpRankedSubtitle => 'Losowy mecz z prawdziwymi graczami';

  @override
  String get pvpPracticeSubtitle => 'Graj solo z botem • Bez rankingu';

  @override
  String get soloPvp => 'Solo PvP';

  @override
  String gridInfo(int size) {
    return 'Siatka $size×$size • 2 min';
  }

  @override
  String get dailyChallenge => 'Wyzwanie dnia';

  @override
  String get dailyChallengeSubtitle => 'Nowe wyzwanie codziennie!';

  @override
  String get streak => 'Seria';

  @override
  String get completed => 'Ukończone';

  @override
  String get play => 'GRAJ';

  @override
  String get noConnection => 'Brak połączenia';

  @override
  String get tetEffects => 'Efekty noworoczne';

  @override
  String get pause => 'Pauza';

  @override
  String get resume => 'KONTYNUUJ';

  @override
  String get quit => 'WYJDŹ';

  @override
  String get paused => 'PAUZA';

  @override
  String get newFeatures => 'Nowe funkcje';

  @override
  String get privacyPolicy => 'Polityka prywatności';

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
