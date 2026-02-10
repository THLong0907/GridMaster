// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Grid Master';

  @override
  String get score => 'PUNTOS';

  @override
  String get highScore => 'RÉCORD';

  @override
  String get gameOver => 'FIN DEL JUEGO';

  @override
  String get newHighScore => '¡NUEVO RÉCORD!';

  @override
  String get playAgain => 'OTRA VEZ';

  @override
  String get home => 'INICIO';

  @override
  String get share => 'COMPARTIR';

  @override
  String get restart => 'RESTART';

  @override
  String get settings => 'Ajustes';

  @override
  String get sound => 'Sonido';

  @override
  String get haptics => 'Vibración';

  @override
  String get resetProgress => 'Reiniciar progreso';

  @override
  String get resetConfirmTitle => '¿Reiniciar?';

  @override
  String get resetConfirmContent =>
      'Se borrarán tus mejores puntuaciones y temas desbloqueados. No se puede deshacer.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get save => 'Guardar';

  @override
  String get changeName => 'Cambiar nombre';

  @override
  String get enterName => 'Ingresa tu nombre';

  @override
  String get leaderboard => 'Clasificación';

  @override
  String get loading => 'Cargando...';

  @override
  String get error => 'Error';

  @override
  String get emptyLeaderboard => '¡Sin puntuaciones!';

  @override
  String get tutorialTitle => 'Cómo jugar';

  @override
  String get tutorialStep1 => 'Arrastra bloques a la cuadrícula';

  @override
  String get tutorialStep2 => 'Llena filas o columnas para eliminar';

  @override
  String get tutorialStep3 => 'Usa el martillo para romper bloques';

  @override
  String get tutorialStep4 => '¡No te quedes sin espacio!';

  @override
  String get clear => '¡Genial!';

  @override
  String get doubleClear => '¡Doble!';

  @override
  String get tripleClear => '¡TRIPLE!';

  @override
  String megaClear(int count) {
    return '¡MEGA! x$count';
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
  String get endSession => 'Terminar';

  @override
  String get findingRival => 'BUSCANDO RIVAL...';

  @override
  String matchmakingError(String error) {
    return 'Error de emparejamiento: $error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => 'Líneas eliminadas';

  @override
  String get maxCombo => 'Combo máximo';

  @override
  String get blocksPlaced => 'Bloques colocados';

  @override
  String get playTime => 'Tiempo de juego';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

  @override
  String get easyMode => 'Fácil';

  @override
  String get memoryMode => 'Memoria';

  @override
  String get classicMode => 'Clásico';

  @override
  String get masterMode => 'Maestro';

  @override
  String get zenMode => 'Zen';

  @override
  String get survivalMode => 'Supervivencia';

  @override
  String get pvpMode => 'Batalla PvP';

  @override
  String get practiceMode => 'Practicar';

  @override
  String get skip => 'Saltar';

  @override
  String get next => 'Siguiente';

  @override
  String get start => '¡JUGAR!';

  @override
  String get stats => 'Estadísticas';

  @override
  String get achievements => 'Logros';

  @override
  String get music => 'Música';

  @override
  String get themes => 'Temas';

  @override
  String get language => 'Idioma';

  @override
  String get chooseLanguage => 'Elegir idioma';

  @override
  String get autoDevice => 'Auto (Dispositivo)';

  @override
  String get data => 'Datos';

  @override
  String best(int score) {
    return 'Mejor: $score';
  }

  @override
  String get easyDesc => 'Cuadrícula pequeña, bloques pequeños';

  @override
  String get classicDesc => '¡Filas subiendo, elimina rápido!';

  @override
  String get masterDesc => '¡Caída automática, velocidad!';

  @override
  String get memoryDesc => 'Bloques desaparecen, recuerda las posiciones';

  @override
  String get zenDesc => 'Relájate, sin perder';

  @override
  String get pvpDesc => 'Duelo 1v1 en 2 minutos';

  @override
  String get pvpRankedSubtitle => 'Partida aleatoria con jugadores reales';

  @override
  String get pvpPracticeSubtitle => 'Jugar solo contra BOT • Sin clasificación';

  @override
  String get soloPvp => 'Solo PvP';

  @override
  String gridInfo(int size) {
    return 'Cuadrícula $size×$size • 2 min';
  }

  @override
  String get dailyChallenge => 'Desafío diario';

  @override
  String get dailyChallengeSubtitle => '¡Nuevo desafío cada día!';

  @override
  String get streak => 'Racha';

  @override
  String get completed => 'Completado';

  @override
  String get play => 'JUGAR';

  @override
  String get noConnection => 'Sin conexión';

  @override
  String get tetEffects => 'Efectos de Año Nuevo';

  @override
  String get pause => 'Pausa';

  @override
  String get resume => 'CONTINUAR';

  @override
  String get quit => 'SALIR';

  @override
  String get paused => 'EN PAUSA';

  @override
  String get newFeatures => 'Novedades';

  @override
  String get privacyPolicy => 'Política de privacidad';

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
