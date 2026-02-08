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
  String get settings => 'Impostazioni';

  @override
  String get sound => 'Audio';

  @override
  String get haptics => 'Vibrazione';

  @override
  String get resetProgress => 'Resetta progressi';

  @override
  String get resetConfirmTitle => 'Resettare?';

  @override
  String get resetConfirmContent =>
      'I punteggi e i temi sbloccati verranno eliminati. Non è possibile annullare.';

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
  String get tutorialStep2 => 'Riempi righe o colonne per cancellarle';

  @override
  String get tutorialStep3 => 'Usa il martello per distruggere i blocchi';

  @override
  String get tutorialStep4 => 'Non esaurire lo spazio!';

  @override
  String get clear => 'Cancellato!';

  @override
  String get doubleClear => 'Doppio Cancellato!';

  @override
  String get tripleClear => 'TRIPLO CANCELLATO!';

  @override
  String megaClear(int count) {
    return 'MEGA CANCELLATO! x$count';
  }

  @override
  String get memoryReveal => '👁️ Rivelazione!';

  @override
  String get zenClear => '🧘 Zen Cancellato!';

  @override
  String autoHammer(int count) {
    return '🔨 Martello Auto! ($count celle)';
  }

  @override
  String get risingRow => '⬆️ Riga in salita!';

  @override
  String get autoDrop => '⏰ Caduta Auto!';

  @override
  String get endSession => 'Fine sessione';

  @override
  String get findingRival => 'RICERCA AVVERSARIO...';

  @override
  String matchmakingError(String error) {
    return 'Errore ricerca: $error';
  }

  @override
  String get zenSummaryTitle => 'Sessione Zen';

  @override
  String get totalLines => 'Righe cancellate';

  @override
  String get maxCombo => 'Combo Max';

  @override
  String get blocksPlaced => 'Blocchi piazzati';

  @override
  String get playTime => 'Tempo di gioco';

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
  String get pvpMode => 'PvP';

  @override
  String get practiceMode => 'Pratica';

  @override
  String get skip => 'Salta';

  @override
  String get next => 'Avanti';

  @override
  String get start => 'GIOCA!';
}
