// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'استاد شبکه';

  @override
  String get score => 'امتیاز';

  @override
  String get highScore => 'بالاترین امتیاز';

  @override
  String get gameOver => 'بازی تمام شد';

  @override
  String get newHighScore => 'رکورد جدید!';

  @override
  String get playAgain => 'بازی مجدد';

  @override
  String get home => 'خانه';

  @override
  String get share => 'اشتراک';

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
      'رکوردها و تم‌های باز شده حذف خواهند شد. قابل بازگشت نیست.';

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
  String get leaderboard => 'جدول امتیازات';

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
  String get tutorialStep2 => 'ردیف یا ستون را پر کنید تا پاک شود';

  @override
  String get tutorialStep3 => 'از چکش برای شکستن بلوک‌ها استفاده کنید';

  @override
  String get tutorialStep4 => 'فضا تمام نشود!';

  @override
  String get clear => 'پاک شد!';

  @override
  String get doubleClear => 'پاک دوتایی!';

  @override
  String get tripleClear => 'پاک سه‌تایی!';

  @override
  String megaClear(int count) {
    return 'پاک بزرگ! x$count';
  }

  @override
  String get memoryReveal => '👁️ آشکار حافظه!';

  @override
  String get zenClear => '🧘 پاک ذن!';

  @override
  String autoHammer(int count) {
    return '🔨 چکش خودکار! ($count خانه)';
  }

  @override
  String get risingRow => '⬆️ ردیف بالارونده!';

  @override
  String get autoDrop => '⏰ سقوط خودکار!';

  @override
  String get endSession => 'پایان';

  @override
  String get findingRival => 'جستجوی حریف...';

  @override
  String matchmakingError(String error) {
    return 'خطای جستجو: $error';
  }

  @override
  String get zenSummaryTitle => 'جلسه ذن';

  @override
  String get totalLines => 'ردیف‌های پاک شده';

  @override
  String get maxCombo => 'بیشترین کمبو';

  @override
  String get blocksPlaced => 'بلوک‌های قرار داده';

  @override
  String get playTime => 'زمان بازی';

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
  String get pvpMode => 'مبارزه';

  @override
  String get practiceMode => 'تمرین';

  @override
  String get skip => 'رد شدن';

  @override
  String get next => 'بعدی';

  @override
  String get start => 'شروع!';
}
