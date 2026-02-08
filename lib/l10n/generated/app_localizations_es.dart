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
  String get playAgain => 'JUGAR DE NUEVO';

  @override
  String get home => 'INICIO';

  @override
  String get share => 'COMPARTIR';

  @override
  String get settings => 'Ajustes';

  @override
  String get sound => 'Sonido';

  @override
  String get haptics => 'Vibración';

  @override
  String get resetProgress => 'Restablecer progreso';

  @override
  String get resetConfirmTitle => '¿Restablecer?';

  @override
  String get resetConfirmContent =>
      'Esto eliminará tus puntuaciones altas y temas desbloqueados. No se puede deshacer.';

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
  String get emptyLeaderboard => '¡Sin puntuaciones aún!';

  @override
  String get tutorialTitle => 'Cómo jugar';

  @override
  String get tutorialStep1 => 'Arrastra los bloques a la cuadrícula';

  @override
  String get tutorialStep2 => 'Llena filas o columnas para eliminar';

  @override
  String get tutorialStep3 => 'Usa el martillo para romper bloques';

  @override
  String get tutorialStep4 => '¡No te quedes sin espacio!';

  @override
  String get clear => '¡Eliminado!';

  @override
  String get doubleClear => '¡Doble Eliminación!';

  @override
  String get tripleClear => '¡TRIPLE ELIMINACIÓN!';

  @override
  String megaClear(int count) {
    return '¡MEGA ELIMINACIÓN! x$count';
  }

  @override
  String get memoryReveal => '👁️ ¡Revelación!';

  @override
  String get zenClear => '🧘 ¡Zen Eliminado!';

  @override
  String autoHammer(int count) {
    return '🔨 ¡Martillo Auto! ($count celdas)';
  }

  @override
  String get risingRow => '⬆️ ¡Fila ascendente!';

  @override
  String get autoDrop => '⏰ ¡Caída Auto!';

  @override
  String get endSession => 'Terminar';

  @override
  String get findingRival => 'BUSCANDO RIVAL...';

  @override
  String matchmakingError(String error) {
    return 'Error de búsqueda: $error';
  }

  @override
  String get zenSummaryTitle => 'Sesión Zen';

  @override
  String get totalLines => 'Líneas eliminadas';

  @override
  String get maxCombo => 'Combo Máx';

  @override
  String get blocksPlaced => 'Bloques colocados';

  @override
  String get playTime => 'Tiempo de juego';

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
  String get pvpMode => 'PvP';

  @override
  String get practiceMode => 'Práctica';

  @override
  String get skip => 'Omitir';

  @override
  String get next => 'Siguiente';

  @override
  String get start => '¡JUGAR!';
}
