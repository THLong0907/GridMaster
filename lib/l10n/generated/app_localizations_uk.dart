// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Grid Master';

  @override
  String get score => 'ОЧКИ';

  @override
  String get highScore => 'РЕКОРД';

  @override
  String get gameOver => 'ГРА ЗАКІНЧЕНА';

  @override
  String get newHighScore => 'НОВИЙ РЕКОРД!';

  @override
  String get playAgain => 'ГРАТИ ЗНОВУ';

  @override
  String get home => 'ДОМОМУ';

  @override
  String get share => 'ПОДІЛИТИСЯ';

  @override
  String get settings => 'Налаштування';

  @override
  String get sound => 'Звук';

  @override
  String get haptics => 'Вібрація';

  @override
  String get resetProgress => 'Скинути прогрес';

  @override
  String get resetConfirmTitle => 'Скинути?';

  @override
  String get resetConfirmContent =>
      'Ваші рекорди та розблоковані теми буде видалено. Це не можна скасувати.';

  @override
  String get cancel => 'Скасувати';

  @override
  String get delete => 'Видалити';

  @override
  String get save => 'Зберегти';

  @override
  String get changeName => 'Змінити ім\'я';

  @override
  String get enterName => 'Введіть ваше ім\'я';

  @override
  String get leaderboard => 'Таблиця лідерів';

  @override
  String get loading => 'Завантаження...';

  @override
  String get error => 'Помилка';

  @override
  String get emptyLeaderboard => 'Ще немає очків!';

  @override
  String get tutorialTitle => 'Як грати';

  @override
  String get tutorialStep1 => 'Перетягніть блоки на сітку';

  @override
  String get tutorialStep2 => 'Заповніть рядки або стовпці для очищення';

  @override
  String get tutorialStep3 => 'Використовуйте молоток для руйнування блоків';

  @override
  String get tutorialStep4 => 'Не залишайтесь без місця!';

  @override
  String get clear => 'Очищено!';

  @override
  String get doubleClear => 'Подвійне очищення!';

  @override
  String get tripleClear => 'ПОТРІЙНЕ ОЧИЩЕННЯ!';

  @override
  String megaClear(int count) {
    return 'МЕГА ОЧИЩЕННЯ! x$count';
  }

  @override
  String get memoryReveal => '👁️ Розкриття пам\'яті!';

  @override
  String get zenClear => '🧘 Дзен Очищення!';

  @override
  String autoHammer(int count) {
    return '🔨 Авто молоток! ($count клітинок)';
  }

  @override
  String get risingRow => '⬆️ Підвищення рядка!';

  @override
  String get autoDrop => '⏰ Авто скидання!';

  @override
  String get endSession => 'Завершити';

  @override
  String get findingRival => 'ПОШУК СУПЕРНИКА...';

  @override
  String matchmakingError(String error) {
    return 'Помилка пошуку: $error';
  }

  @override
  String get zenSummaryTitle => 'Дзен сесія';

  @override
  String get totalLines => 'Очищені рядки';

  @override
  String get maxCombo => 'Макс комбо';

  @override
  String get blocksPlaced => 'Розміщені блоки';

  @override
  String get playTime => 'Час гри';

  @override
  String get easyMode => 'Легко';

  @override
  String get memoryMode => 'Пам\'ять';

  @override
  String get classicMode => 'Класика';

  @override
  String get masterMode => 'Майстер';

  @override
  String get zenMode => 'Дзен';

  @override
  String get survivalMode => 'Виживання';

  @override
  String get pvpMode => 'PvP Битва';

  @override
  String get practiceMode => 'Практика';

  @override
  String get skip => 'Пропустити';

  @override
  String get next => 'Далі';

  @override
  String get start => 'СТАРТ!';
}
