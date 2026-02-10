// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Grid Master';

  @override
  String get score => 'PUNTEGGIO';

  @override
  String get highScore => 'RECORD';

  @override
  String get gameOver => 'FINE PARTITA';

  @override
  String get newHighScore => 'NUOVO RECORD!';

  @override
  String get playAgain => 'RIGIOCA';

  @override
  String get home => 'HOME';

  @override
  String get share => 'CONDIVIDI';

  @override
  String get restart => 'RESTART';

  @override
  String get settings => 'Impostazioni';

  @override
  String get sound => 'Suoni';

  @override
  String get haptics => 'Vibrazione';

  @override
  String get resetProgress => 'Resetta progresso';

  @override
  String get resetConfirmTitle => 'Resettare?';

  @override
  String get resetConfirmContent =>
      'Verranno cancellati i punteggi e i temi sbloccati. Non è possibile annullare.';

  @override
  String get cancel => 'Annulla';

  @override
  String get delete => 'Elimina';

  @override
  String get save => 'Salva';

  @override
  String get changeName => 'Cambia nome';

  @override
  String get enterName => 'Inserisci il tuo nome';

  @override
  String get leaderboard => 'Classifica';

  @override
  String get loading => 'Caricamento...';

  @override
  String get error => 'Errore';

  @override
  String get emptyLeaderboard => 'Nessun punteggio!';

  @override
  String get tutorialTitle => 'Come giocare';

  @override
  String get tutorialStep1 => 'Trascina i blocchi sulla griglia';

  @override
  String get tutorialStep2 => 'Riempi righe o colonne';

  @override
  String get tutorialStep3 => 'Usa il martello per rompere';

  @override
  String get tutorialStep4 => 'Non rimanere senza spazio!';

  @override
  String get clear => 'Bravo!';

  @override
  String get doubleClear => 'Doppio!';

  @override
  String get tripleClear => 'TRIPLO!';

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
  String get endSession => 'Termina';

  @override
  String get findingRival => 'CERCANDO RIVALE...';

  @override
  String matchmakingError(String error) {
    return 'Errore matchmaking: $error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => 'Righe eliminate';

  @override
  String get maxCombo => 'Combo massimo';

  @override
  String get blocksPlaced => 'Blocchi piazzati';

  @override
  String get playTime => 'Tempo di gioco';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

  @override
  String get easyMode => 'Facile';

  @override
  String get memoryMode => 'Memoria';

  @override
  String get classicMode => 'Classico';

  @override
  String get masterMode => 'Maestro';

  @override
  String get zenMode => 'Zen';

  @override
  String get survivalMode => 'Sopravvivenza';

  @override
  String get pvpMode => 'Battaglia PvP';

  @override
  String get practiceMode => 'Allenamento';

  @override
  String get skip => 'Salta';

  @override
  String get next => 'Avanti';

  @override
  String get start => 'GIOCA!';

  @override
  String get stats => 'Statistiche';

  @override
  String get achievements => 'Traguardi';

  @override
  String get music => 'Musica';

  @override
  String get themes => 'Temi';

  @override
  String get language => 'Lingua';

  @override
  String get chooseLanguage => 'Scegli lingua';

  @override
  String get autoDevice => 'Auto (Dispositivo)';

  @override
  String get data => 'Dati';

  @override
  String best(int score) {
    return 'Migliore: $score';
  }

  @override
  String get easyDesc => 'Griglia piccola, blocchi piccoli';

  @override
  String get classicDesc => 'Righe in salita, elimina veloce!';

  @override
  String get masterDesc => 'Caduta automatica, velocità!';

  @override
  String get memoryDesc => 'Blocchi scompaiono, ricorda le posizioni';

  @override
  String get zenDesc => 'Rilassati, non perdi';

  @override
  String get pvpDesc => 'Duello 1v1 in 2 minuti';

  @override
  String get pvpRankedSubtitle => 'Partita casuale con giocatori reali';

  @override
  String get pvpPracticeSubtitle => 'Gioca solo contro BOT • Senza classifica';

  @override
  String get soloPvp => 'Solo PvP';

  @override
  String gridInfo(int size) {
    return 'Griglia $size×$size • 2 min';
  }

  @override
  String get dailyChallenge => 'Sfida giornaliera';

  @override
  String get dailyChallengeSubtitle => 'Nuova sfida ogni giorno!';

  @override
  String get streak => 'Serie';

  @override
  String get completed => 'Completato';

  @override
  String get play => 'GIOCA';

  @override
  String get noConnection => 'Nessuna connessione';

  @override
  String get tetEffects => 'Effetti Capodanno';

  @override
  String get pause => 'Pausa';

  @override
  String get resume => 'RIPRENDI';

  @override
  String get quit => 'ESCI';

  @override
  String get paused => 'IN PAUSA';

  @override
  String get newFeatures => 'Novità';

  @override
  String get privacyPolicy => 'Privacy';

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
