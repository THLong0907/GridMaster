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
  String get highScore => 'HÖCHSTPUNKTZAHL';

  @override
  String get gameOver => 'SPIEL VORBEI';

  @override
  String get newHighScore => 'NEUER REKORD!';

  @override
  String get playAgain => 'NOCHMAL';

  @override
  String get home => 'START';

  @override
  String get share => 'TEILEN';

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
      'Dies löscht Ihre Höchstpunktzahlen und freigeschalteten Designs. Dies kann nicht rückgängig gemacht werden.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get save => 'Speichern';

  @override
  String get changeName => 'Namen ändern';

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
  String get tutorialStep1 => 'Blöcke auf das Gitter ziehen';

  @override
  String get tutorialStep2 => 'Reihen oder Spalten füllen zum Löschen';

  @override
  String get tutorialStep3 => 'Hammer zum Zerstören von Blöcken benutzen';

  @override
  String get tutorialStep4 => 'Kein Platz mehr? Spielende!';

  @override
  String get clear => 'Gelöscht!';

  @override
  String get doubleClear => 'Doppelt Gelöscht!';

  @override
  String get tripleClear => 'DREIFACH GELÖSCHT!';

  @override
  String megaClear(int count) {
    return 'MEGA GELÖSCHT! x$count';
  }

  @override
  String get memoryReveal => '👁️ Erinnerung!';

  @override
  String get zenClear => '🧘 Zen Gelöscht!';

  @override
  String autoHammer(int count) {
    return '🔨 Auto-Hammer! ($count Zellen)';
  }

  @override
  String get risingRow => '⬆️ Steigende Reihe!';

  @override
  String get autoDrop => '⏰ Auto-Fall!';

  @override
  String get endSession => 'Beenden';

  @override
  String get findingRival => 'GEGNER SUCHEN...';

  @override
  String matchmakingError(String error) {
    return 'Suchfehler: $error';
  }

  @override
  String get zenSummaryTitle => 'Zen-Sitzung';

  @override
  String get totalLines => 'Gelöschte Reihen';

  @override
  String get maxCombo => 'Max Combo';

  @override
  String get blocksPlaced => 'Platzierte Blöcke';

  @override
  String get playTime => 'Spielzeit';

  @override
  String get easyMode => 'Leicht';

  @override
  String get memoryMode => 'Speicher';

  @override
  String get classicMode => 'Klassisch';

  @override
  String get masterMode => 'Meister';

  @override
  String get zenMode => 'Zen';

  @override
  String get survivalMode => 'Überleben';

  @override
  String get pvpMode => 'PvP Kampf';

  @override
  String get practiceMode => 'Übung';

  @override
  String get skip => 'Überspringen';

  @override
  String get next => 'Weiter';

  @override
  String get start => 'START!';
}
