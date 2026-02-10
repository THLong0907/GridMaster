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
  String get highScore => 'TOPSCORE';

  @override
  String get gameOver => 'GAME OVER';

  @override
  String get newHighScore => 'NIEUW RECORD!';

  @override
  String get playAgain => 'OPNIEUW';

  @override
  String get home => 'HOME';

  @override
  String get share => 'DELEN';

  @override
  String get restart => 'RESTART';

  @override
  String get settings => 'Instellingen';

  @override
  String get sound => 'Geluid';

  @override
  String get haptics => 'Trillingen';

  @override
  String get resetProgress => 'Voortgang resetten';

  @override
  String get resetConfirmTitle => 'Resetten?';

  @override
  String get resetConfirmContent =>
      'Dit verwijdert je scores en ontgrendelde thema\'s. Dit kan niet ongedaan worden.';

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
  String get tutorialStep2 => 'Vul rijen of kolommen';

  @override
  String get tutorialStep3 => 'Gebruik de hamer om te breken';

  @override
  String get tutorialStep4 => 'Raak niet zonder ruimte!';

  @override
  String get clear => 'Super!';

  @override
  String get doubleClear => 'Dubbel!';

  @override
  String get tripleClear => 'DRIEVOUDIG!';

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
  String get endSession => 'Beëindigen';

  @override
  String get findingRival => 'RIVAAL ZOEKEN...';

  @override
  String matchmakingError(String error) {
    return 'Matchmaking fout: $error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => 'Verwijderde lijnen';

  @override
  String get maxCombo => 'Max. combo';

  @override
  String get blocksPlaced => 'Geplaatste blokken';

  @override
  String get playTime => 'Speeltijd';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

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
  String get pvpMode => 'PvP Gevecht';

  @override
  String get practiceMode => 'Oefenen';

  @override
  String get skip => 'Overslaan';

  @override
  String get next => 'Volgende';

  @override
  String get start => 'START!';

  @override
  String get stats => 'Statistieken';

  @override
  String get achievements => 'Prestaties';

  @override
  String get music => 'Muziek';

  @override
  String get themes => 'Thema\'s';

  @override
  String get language => 'Taal';

  @override
  String get chooseLanguage => 'Kies taal';

  @override
  String get autoDevice => 'Auto (Apparaat)';

  @override
  String get data => 'Gegevens';

  @override
  String best(int score) {
    return 'Beste: $score';
  }

  @override
  String get easyDesc => 'Klein raster, kleine blokken';

  @override
  String get classicDesc => 'Rijen stijgen, snel verwijderen!';

  @override
  String get masterDesc => 'Auto-drop, snelheid!';

  @override
  String get memoryDesc => 'Blokken verdwijnen, onthoud posities';

  @override
  String get zenDesc => 'Ontspannen, niet verliezen';

  @override
  String get pvpDesc => '1v1 duel in 2 minuten';

  @override
  String get pvpRankedSubtitle => 'Willekeurige match met echte spelers';

  @override
  String get pvpPracticeSubtitle => 'Solo tegen BOT • Geen ranking';

  @override
  String get soloPvp => 'Solo PvP';

  @override
  String gridInfo(int size) {
    return '$size×$size Raster • 2 min';
  }

  @override
  String get dailyChallenge => 'Dagelijkse uitdaging';

  @override
  String get dailyChallengeSubtitle => 'Elke dag een nieuwe uitdaging!';

  @override
  String get streak => 'Reeks';

  @override
  String get completed => 'Voltooid';

  @override
  String get play => 'SPELEN';

  @override
  String get noConnection => 'Geen verbinding';

  @override
  String get tetEffects => 'Nieuwjaarseffecten';

  @override
  String get pause => 'Pauze';

  @override
  String get resume => 'HERVATTEN';

  @override
  String get quit => 'STOPPEN';

  @override
  String get paused => 'GEPAUZEERD';

  @override
  String get newFeatures => 'Nieuwe functies';

  @override
  String get privacyPolicy => 'Privacybeleid';

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
