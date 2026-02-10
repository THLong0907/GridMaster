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
  String get gameOver => 'КОНЕЦ ИГРЫ';

  @override
  String get newHighScore => 'НОВЫЙ РЕКОРД!';

  @override
  String get playAgain => 'ЕЩЁ РАЗ';

  @override
  String get home => 'ДОМОЙ';

  @override
  String get share => 'ПОДЕЛИТЬСЯ';

  @override
  String get restart => 'RESTART';

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
      'Все рекорды и темы будут удалены. Это нельзя отменить.';

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
  String get emptyLeaderboard => 'Пока нет результатов!';

  @override
  String get tutorialTitle => 'Как играть';

  @override
  String get tutorialStep1 => 'Перетащите блоки на сетку';

  @override
  String get tutorialStep2 => 'Заполните ряды или колонки';

  @override
  String get tutorialStep3 => 'Используйте молоток для разрушения';

  @override
  String get tutorialStep4 => 'Не останьтесь без места!';

  @override
  String get clear => 'Отлично!';

  @override
  String get doubleClear => 'Двойной!';

  @override
  String get tripleClear => 'ТРОЙНОЙ!';

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
  String get endSession => 'Завершить';

  @override
  String get findingRival => 'ПОИСК СОПЕРНИКА...';

  @override
  String matchmakingError(String error) {
    return 'Ошибка матчмейкинга: $error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => 'Очищено линий';

  @override
  String get maxCombo => 'Макс. комбо';

  @override
  String get blocksPlaced => 'Размещено блоков';

  @override
  String get playTime => 'Время игры';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

  @override
  String get easyMode => 'Лёгкий';

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
  String get pvpMode => 'PvP Бой';

  @override
  String get practiceMode => 'Тренировка';

  @override
  String get skip => 'Пропустить';

  @override
  String get next => 'Далее';

  @override
  String get start => 'СТАРТ!';

  @override
  String get stats => 'Статистика';

  @override
  String get achievements => 'Достижения';

  @override
  String get music => 'Музыка';

  @override
  String get themes => 'Темы';

  @override
  String get language => 'Язык';

  @override
  String get chooseLanguage => 'Выбрать язык';

  @override
  String get autoDevice => 'Авто (Устройство)';

  @override
  String get data => 'Данные';

  @override
  String best(int score) {
    return 'Лучший: $score';
  }

  @override
  String get easyDesc => 'Маленькая сетка, маленькие блоки';

  @override
  String get classicDesc => 'Ряды поднимаются, очищай быстро!';

  @override
  String get masterDesc => 'Авто-сброс, скорость!';

  @override
  String get memoryDesc => 'Блоки исчезают, запоминай позиции';

  @override
  String get zenDesc => 'Расслабься, не проиграешь';

  @override
  String get pvpDesc => 'Дуэль 1v1 за 2 минуты';

  @override
  String get pvpRankedSubtitle => 'Случайный матч с реальными игроками';

  @override
  String get pvpPracticeSubtitle => 'Одиночка против бота • Без рейтинга';

  @override
  String get soloPvp => 'Соло PvP';

  @override
  String gridInfo(int size) {
    return 'Сетка $size×$size • 2 мин';
  }

  @override
  String get dailyChallenge => 'Ежедневный вызов';

  @override
  String get dailyChallengeSubtitle => 'Новый вызов каждый день!';

  @override
  String get streak => 'Серия';

  @override
  String get completed => 'Завершено';

  @override
  String get play => 'ИГРАТЬ';

  @override
  String get noConnection => 'Нет соединения';

  @override
  String get tetEffects => 'Новогодние эффекты';

  @override
  String get pause => 'Пауза';

  @override
  String get resume => 'ПРОДОЛЖИТЬ';

  @override
  String get quit => 'ВЫЙТИ';

  @override
  String get paused => 'ПАУЗА';

  @override
  String get newFeatures => 'Новые функции';

  @override
  String get privacyPolicy => 'Конфиденциальность';

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
