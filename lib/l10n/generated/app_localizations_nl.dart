// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Grid Master';

  @override
  String get score => 'SCORE';

  @override
  String get highScore => 'HOOGSTE SCORE';

  @override
  String get gameOver => 'GAME OVER';

  @override
  String get newHighScore => 'NIEUW RECORD!';

  @override
  String get playAgain => 'OPNIEUW SPELEN';

  @override
  String get home => 'HOME';

  @override
  String get share => 'DELEN';

  @override
  String get settings => 'Instellingen';

  @override
  String get sound => 'Geluid';

  @override
  String get haptics => 'Trillen';

  @override
  String get resetProgress => 'Voortgang resetten';

  @override
  String get resetConfirmTitle => 'Resetten?';

  @override
  String get resetConfirmContent =>
      'Dit verwijdert je hoogste scores en ontgrendelde thema\'s. Dit kan niet ongedaan worden.';

  @override
  String get cancel => 'Annuleren';

  @override
  String get delete => 'Verwijderen';

  @override
  String get save => 'Opslaan';

  @override
  String get changeName => 'Naam wijzigen';

  @override
  String get enterName => 'Voer je naam in';

  @override
  String get leaderboard => 'Ranglijst';

  @override
  String get loading => 'Laden...';

  @override
  String get error => 'Fout';

  @override
  String get emptyLeaderboard => 'Nog geen scores!';

  @override
  String get tutorialTitle => 'Hoe te spelen';

  @override
  String get tutorialStep1 => 'Sleep blokken naar het raster';

  @override
  String get tutorialStep2 => 'Vul rijen of kolommen om te wissen';

  @override
  String get tutorialStep3 => 'Gebruik de hamer om blokken te breken';

  @override
  String get tutorialStep4 => 'Raak niet zonder ruimte!';

  @override
  String get clear => 'Gewist!';

  @override
  String get doubleClear => 'Dubbel gewist!';

  @override
  String get tripleClear => 'DRIEDUBBEL GEWIST!';

  @override
  String megaClear(int count) {
    return 'MEGA GEWIST! x$count';
  }

  @override
  String get memoryReveal => '👁️ Geheugen onthuld!';

  @override
  String get zenClear => '🧘 Zen Gewist!';

  @override
  String autoHammer(int count) {
    return '🔨 Auto Hamer! ($count cellen)';
  }

  @override
  String get risingRow => '⬆️ Stijgende rij!';

  @override
  String get autoDrop => '⏰ Auto Val!';

  @override
  String get endSession => 'Sessie beëindigen';

  @override
  String get findingRival => 'TEGENSTANDER ZOEKEN...';

  @override
  String matchmakingError(String error) {
    return 'Zoekfout: $error';
  }

  @override
  String get zenSummaryTitle => 'Zen Sessie';

  @override
  String get totalLines => 'Gewiste rijen';

  @override
  String get maxCombo => 'Max Combo';

  @override
  String get blocksPlaced => 'Geplaatste blokken';

  @override
  String get playTime => 'Speeltijd';

  @override
  String get easyMode => 'Makkelijk';

  @override
  String get memoryMode => 'Geheugen';

  @override
  String get classicMode => 'Klassiek';

  @override
  String get masterMode => 'Meester';

  @override
  String get zenMode => 'Zen';

  @override
  String get survivalMode => 'Overleven';

  @override
  String get pvpMode => 'PvP';

  @override
  String get practiceMode => 'Oefenen';

  @override
  String get skip => 'Overslaan';

  @override
  String get next => 'Volgende';

  @override
  String get start => 'START!';
}
