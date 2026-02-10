// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'گرید مستر';

  @override
  String get score => 'امتیاز';

  @override
  String get highScore => 'بالاترین امتیاز';

  @override
  String get gameOver => 'پایان بازی';

  @override
  String get newHighScore => 'رکورد جدید!';

  @override
  String get playAgain => 'دوباره بازی';

  @override
  String get home => 'خانه';

  @override
  String get share => 'اشتراک';

  @override
  String get restart => 'RESTART';

  @override
  String get settings => 'تنظیمات';

  @override
  String get sound => 'صدا';

  @override
  String get haptics => 'لرزش';

  @override
  String get resetProgress => 'بازنشانی پیشرفت';

  @override
  String get resetConfirmTitle => 'بازنشانی؟';

  @override
  String get resetConfirmContent =>
      'تمام نتایج و تم‌ها حذف خواهند شد. قابل بازگشت نیست.';

  @override
  String get cancel => 'لغو';

  @override
  String get delete => 'حذف';

  @override
  String get save => 'ذخیره';

  @override
  String get changeName => 'تغییر نام';

  @override
  String get enterName => 'نام خود را وارد کنید';

  @override
  String get leaderboard => 'جدول رتبه‌بندی';

  @override
  String get loading => 'در حال بارگذاری...';

  @override
  String get error => 'خطا';

  @override
  String get emptyLeaderboard => 'هنوز امتیازی نیست!';

  @override
  String get tutorialTitle => 'نحوه بازی';

  @override
  String get tutorialStep1 => 'بلوک‌ها را به شبکه بکشید';

  @override
  String get tutorialStep2 => 'ردیف یا ستون را پر کنید';

  @override
  String get tutorialStep3 => 'از چکش برای شکستن استفاده کنید';

  @override
  String get tutorialStep4 => 'فضایتان تمام نشود!';

  @override
  String get clear => 'عالی!';

  @override
  String get doubleClear => 'دوتایی!';

  @override
  String get tripleClear => 'سه‌تایی!';

  @override
  String megaClear(int count) {
    return 'مگا! x$count';
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
  String get endSession => 'پایان';

  @override
  String get findingRival => 'در حال یافتن حریف...';

  @override
  String matchmakingError(String error) {
    return 'خطای جورسازی: $error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => 'خطوط پاک‌شده';

  @override
  String get maxCombo => 'حداکثر کمبو';

  @override
  String get blocksPlaced => 'بلوک‌های قرارداده‌شده';

  @override
  String get playTime => 'زمان بازی';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

  @override
  String get easyMode => 'آسان';

  @override
  String get memoryMode => 'حافظه';

  @override
  String get classicMode => 'کلاسیک';

  @override
  String get masterMode => 'استاد';

  @override
  String get zenMode => 'ذن';

  @override
  String get survivalMode => 'بقا';

  @override
  String get pvpMode => 'مبارزه PvP';

  @override
  String get practiceMode => 'تمرین';

  @override
  String get skip => 'رد شدن';

  @override
  String get next => 'بعدی';

  @override
  String get start => 'شروع!';

  @override
  String get stats => 'آمار';

  @override
  String get achievements => 'دستاوردها';

  @override
  String get music => 'موسیقی';

  @override
  String get themes => 'تم‌ها';

  @override
  String get language => 'زبان';

  @override
  String get chooseLanguage => 'انتخاب زبان';

  @override
  String get autoDevice => 'خودکار (دستگاه)';

  @override
  String get data => 'داده‌ها';

  @override
  String best(int score) {
    return 'بهترین: $score';
  }

  @override
  String get easyDesc => 'شبکه کوچک، بلوک‌های کوچک';

  @override
  String get classicDesc => 'ردیف‌ها بالا می‌آیند، سریع پاک کن!';

  @override
  String get masterDesc => 'سقوط خودکار، سرعت!';

  @override
  String get memoryDesc => 'بلوک‌ها ناپدید می‌شوند، موقعیت‌ها را به خاطر بسپار';

  @override
  String get zenDesc => 'آرامش، بدون باخت';

  @override
  String get pvpDesc => 'دوئل 1v1 در 2 دقیقه';

  @override
  String get pvpRankedSubtitle => 'مسابقه تصادفی با بازیکنان واقعی';

  @override
  String get pvpPracticeSubtitle => 'بازی تکی با ربات • بدون رتبه‌بندی';

  @override
  String get soloPvp => 'PvP تکی';

  @override
  String gridInfo(int size) {
    return 'شبکه $size×$size • 2 دقیقه';
  }

  @override
  String get dailyChallenge => 'چالش روزانه';

  @override
  String get dailyChallengeSubtitle => 'هر روز یک چالش جدید!';

  @override
  String get streak => 'دور';

  @override
  String get completed => 'تکمیل‌شده';

  @override
  String get play => 'بازی';

  @override
  String get noConnection => 'بدون اتصال';

  @override
  String get tetEffects => 'جلوه‌های سال نو';

  @override
  String get pause => 'توقف';

  @override
  String get resume => 'ادامه';

  @override
  String get quit => 'خروج';

  @override
  String get paused => 'متوقف';

  @override
  String get newFeatures => 'ویژگی‌های جدید';

  @override
  String get privacyPolicy => 'حریم خصوصی';

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
