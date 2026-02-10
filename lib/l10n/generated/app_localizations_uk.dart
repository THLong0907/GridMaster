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
  String get score => 'БАЛИ';

  @override
  String get highScore => 'РЕКОРД';

  @override
  String get gameOver => 'КІНЕЦЬ ГРИ';

  @override
  String get newHighScore => 'НОВИЙ РЕКОРД!';

  @override
  String get playAgain => 'ЩЕ РАЗ';

  @override
  String get home => 'ДОДОМУ';

  @override
  String get share => 'ПОДІЛИТИСЯ';

  @override
  String get restart => 'RESTART';

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
      'Усі рекорди та теми будуть видалені. Це не можна скасувати.';

  @override
  String get cancel => 'Скасувати';

  @override
  String get delete => 'Видалити';

  @override
  String get save => 'Зберегти';

  @override
  String get changeName => 'Змінити ім\'я';

  @override
  String get enterName => 'Введіть своє ім\'я';

  @override
  String get leaderboard => 'Таблиця лідерів';

  @override
  String get loading => 'Завантаження...';

  @override
  String get error => 'Помилка';

  @override
  String get emptyLeaderboard => 'Ще немає результатів!';

  @override
  String get tutorialTitle => 'Як грати';

  @override
  String get tutorialStep1 => 'Перетягніть блоки на сітку';

  @override
  String get tutorialStep2 => 'Заповніть ряди або стовпці';

  @override
  String get tutorialStep3 => 'Використовуйте молоток для руйнування';

  @override
  String get tutorialStep4 => 'Не лишіться без місця!';

  @override
  String get clear => 'Чудово!';

  @override
  String get doubleClear => 'Подвійний!';

  @override
  String get tripleClear => 'ПОТРІЙНИЙ!';

  @override
  String megaClear(int count) {
    return 'МЕГА! x$count';
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
  String get endSession => 'Завершити';

  @override
  String get findingRival => 'ПОШУК СУПЕРНИКА...';

  @override
  String matchmakingError(String error) {
    return 'Помилка підбору: $error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => 'Очищені лінії';

  @override
  String get maxCombo => 'Макс. комбо';

  @override
  String get blocksPlaced => 'Розміщені блоки';

  @override
  String get playTime => 'Час гри';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

  @override
  String get easyMode => 'Легкий';

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
  String get pvpMode => 'PvP Бій';

  @override
  String get practiceMode => 'Тренування';

  @override
  String get skip => 'Пропустити';

  @override
  String get next => 'Далі';

  @override
  String get start => 'СТАРТ!';

  @override
  String get stats => 'Статистика';

  @override
  String get achievements => 'Досягнення';

  @override
  String get music => 'Музика';

  @override
  String get themes => 'Теми';

  @override
  String get language => 'Мова';

  @override
  String get chooseLanguage => 'Обрати мову';

  @override
  String get autoDevice => 'Авто (Пристрій)';

  @override
  String get data => 'Дані';

  @override
  String best(int score) {
    return 'Найкращий: $score';
  }

  @override
  String get easyDesc => 'Маленька сітка, маленькі блоки';

  @override
  String get classicDesc => 'Ряди піднімаються, швидко очищуй!';

  @override
  String get masterDesc => 'Авто-скидання, швидкість!';

  @override
  String get memoryDesc => 'Блоки зникають, запам\'ятай позиції';

  @override
  String get zenDesc => 'Відпочинок, без програшу';

  @override
  String get pvpDesc => 'Дуель 1v1 за 2 хвилини';

  @override
  String get pvpRankedSubtitle => 'Випадковий матч з реальними гравцями';

  @override
  String get pvpPracticeSubtitle => 'Одиночний бій з ботом • Без рейтингу';

  @override
  String get soloPvp => 'Соло PvP';

  @override
  String gridInfo(int size) {
    return 'Сітка $size×$size • 2 хв';
  }

  @override
  String get dailyChallenge => 'Щоденний виклик';

  @override
  String get dailyChallengeSubtitle => 'Новий виклик щодня!';

  @override
  String get streak => 'Серія';

  @override
  String get completed => 'Завершено';

  @override
  String get play => 'ГРАТИ';

  @override
  String get noConnection => 'Немає з\'єднання';

  @override
  String get tetEffects => 'Новорічні ефекти';

  @override
  String get pause => 'Пауза';

  @override
  String get resume => 'ПРОДОВЖИТИ';

  @override
  String get quit => 'ВИЙТИ';

  @override
  String get paused => 'ПАУЗА';

  @override
  String get newFeatures => 'Нові функції';

  @override
  String get privacyPolicy => 'Конфіденційність';

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
