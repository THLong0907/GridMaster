// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Grid Master';

  @override
  String get score => 'ОЧКИ';

  @override
  String get highScore => 'РЕКОРД';

  @override
  String get gameOver => 'ИГРА ОКОНЧЕНА';

  @override
  String get newHighScore => 'НОВЫЙ РЕКОРД!';

  @override
  String get playAgain => 'ЗАНОВО';

  @override
  String get home => 'ДОМОЙ';

  @override
  String get share => 'ПОДЕЛИТЬСЯ';

  @override
  String get settings => 'Настройки';

  @override
  String get sound => 'Звук';

  @override
  String get haptics => 'Вибрация';

  @override
  String get resetProgress => 'Сбросить прогресс';

  @override
  String get resetConfirmTitle => 'Сбросить?';

  @override
  String get resetConfirmContent =>
      'Ваши рекорды и разблокированные темы будут удалены. Это нельзя отменить.';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get save => 'Сохранить';

  @override
  String get changeName => 'Изменить имя';

  @override
  String get enterName => 'Введите ваше имя';

  @override
  String get leaderboard => 'Таблица лидеров';

  @override
  String get loading => 'Загрузка...';

  @override
  String get error => 'Ошибка';

  @override
  String get emptyLeaderboard => 'Пока нет очков!';

  @override
  String get tutorialTitle => 'Как играть';

  @override
  String get tutorialStep1 => 'Перетащите блоки на сетку';

  @override
  String get tutorialStep2 => 'Заполните ряды или столбцы для очистки';

  @override
  String get tutorialStep3 => 'Используйте молоток для разрушения блоков';

  @override
  String get tutorialStep4 => 'Не оставайтесь без места!';

  @override
  String get clear => 'Очищено!';

  @override
  String get doubleClear => 'Двойная очистка!';

  @override
  String get tripleClear => 'ТРОЙНАЯ ОЧИСТКА!';

  @override
  String megaClear(int count) {
    return 'МЕГА ОЧИСТКА! x$count';
  }

  @override
  String get memoryReveal => '👁️ Раскрытие памяти!';

  @override
  String get zenClear => '🧘 Дзен Очистка!';

  @override
  String autoHammer(int count) {
    return '🔨 Авто молоток! ($count ячеек)';
  }

  @override
  String get risingRow => '⬆️ Поднимающийся ряд!';

  @override
  String get autoDrop => '⏰ Авто сброс!';

  @override
  String get endSession => 'Завершить';

  @override
  String get findingRival => 'ПОИСК СОПЕРНИКА...';

  @override
  String matchmakingError(String error) {
    return 'Ошибка поиска: $error';
  }

  @override
  String get zenSummaryTitle => 'Дзен сессия';

  @override
  String get totalLines => 'Очищенные ряды';

  @override
  String get maxCombo => 'Макс комбо';

  @override
  String get blocksPlaced => 'Размещено блоков';

  @override
  String get playTime => 'Время игры';

  @override
  String get easyMode => 'Легко';

  @override
  String get memoryMode => 'Память';

  @override
  String get classicMode => 'Классика';

  @override
  String get masterMode => 'Мастер';

  @override
  String get zenMode => 'Дзен';

  @override
  String get survivalMode => 'Выживание';

  @override
  String get pvpMode => 'PvP Битва';

  @override
  String get practiceMode => 'Практика';

  @override
  String get skip => 'Пропустить';

  @override
  String get next => 'Далее';

  @override
  String get start => 'СТАРТ!';
}
