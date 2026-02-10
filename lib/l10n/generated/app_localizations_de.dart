// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Grid Master';

  @override
  String get score => 'PUNKTE';

  @override
  String get highScore => 'HIGHSCORE';

  @override
  String get gameOver => 'SPIELENDE';

  @override
  String get newHighScore => 'NEUER REKORD!';

  @override
  String get playAgain => 'NOCHMAL';

  @override
  String get home => 'START';

  @override
  String get share => 'TEILEN';

  @override
  String get restart => 'RESTART';

  @override
  String get settings => 'Einstellungen';

  @override
  String get sound => 'Ton';

  @override
  String get haptics => 'Vibration';

  @override
  String get resetProgress => 'Fortschritt zurücksetzen';

  @override
  String get resetConfirmTitle => 'Zurücksetzen?';

  @override
  String get resetConfirmContent =>
      'Dies löscht alle Highscores und freigeschaltete Designs. Dies kann nicht rückgängig gemacht werden.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get save => 'Speichern';

  @override
  String get changeName => 'Anzeigename ändern';

  @override
  String get enterName => 'Namen eingeben';

  @override
  String get leaderboard => 'Bestenliste';

  @override
  String get loading => 'Laden...';

  @override
  String get error => 'Fehler';

  @override
  String get emptyLeaderboard => 'Noch keine Punkte!';

  @override
  String get tutorialTitle => 'Spielanleitung';

  @override
  String get tutorialStep1 => 'Blöcke ins Raster ziehen';

  @override
  String get tutorialStep2 => 'Reihen oder Spalten füllen';

  @override
  String get tutorialStep3 => 'Hammer zum Zerstören nutzen';

  @override
  String get tutorialStep4 => 'Platz nicht ausgehen lassen!';

  @override
  String get clear => 'Super!';

  @override
  String get doubleClear => 'Doppelt!';

  @override
  String get tripleClear => 'DREIFACH!';

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
  String get endSession => 'Beenden';

  @override
  String get findingRival => 'GEGNER SUCHEN...';

  @override
  String matchmakingError(String error) {
    return 'Matchmaking-Fehler: $error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => 'Gelöschte Reihen';

  @override
  String get maxCombo => 'Max. Combo';

  @override
  String get blocksPlaced => 'Platzierte Blöcke';

  @override
  String get playTime => 'Spielzeit';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

  @override
  String get easyMode => 'Leicht';

  @override
  String get memoryMode => 'Gedächtnis';

  @override
  String get classicMode => 'Klassisch';

  @override
  String get masterMode => 'Meister';

  @override
  String get zenMode => 'Zen';

  @override
  String get survivalMode => 'Überleben';

  @override
  String get pvpMode => 'PvP-Kampf';

  @override
  String get practiceMode => 'Übungsmodus';

  @override
  String get skip => 'Überspringen';

  @override
  String get next => 'Weiter';

  @override
  String get start => 'LOS!';

  @override
  String get stats => 'Statistiken';

  @override
  String get achievements => 'Erfolge';

  @override
  String get music => 'Musik';

  @override
  String get themes => 'Designs';

  @override
  String get language => 'Sprache';

  @override
  String get chooseLanguage => 'Sprache wählen';

  @override
  String get autoDevice => 'Auto (Gerät)';

  @override
  String get data => 'Daten';

  @override
  String best(int score) {
    return 'Bester: $score';
  }

  @override
  String get easyDesc => 'Kleines Raster, viele kleine Blöcke';

  @override
  String get classicDesc => 'Steigende Reihen, schnell löschen!';

  @override
  String get masterDesc => 'Auto-Drop, Geschwindigkeit!';

  @override
  String get memoryDesc => 'Blöcke verschwinden, Positionen merken';

  @override
  String get zenDesc => 'Entspannen, kein Verlieren';

  @override
  String get pvpDesc => '1v1 Duell in 2 Minuten';

  @override
  String get pvpRankedSubtitle => 'Zufälliges Match mit echten Spielern';

  @override
  String get pvpPracticeSubtitle => 'Allein gegen BOT spielen • Kein Ranking';

  @override
  String get soloPvp => 'Solo PvP';

  @override
  String gridInfo(int size) {
    return '$size×$size Raster • 2 Min';
  }

  @override
  String get dailyChallenge => 'Tägliche Herausforderung';

  @override
  String get dailyChallengeSubtitle => 'Jeden Tag eine neue Herausforderung!';

  @override
  String get streak => 'Serie';

  @override
  String get completed => 'Abgeschlossen';

  @override
  String get play => 'SPIELEN';

  @override
  String get noConnection => 'Keine Verbindung';

  @override
  String get tetEffects => 'Neujahrseffekte';

  @override
  String get pause => 'Pause';

  @override
  String get resume => 'FORTSETZEN';

  @override
  String get quit => 'BEENDEN';

  @override
  String get paused => 'PAUSIERT';

  @override
  String get newFeatures => 'Neue Funktionen';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

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
