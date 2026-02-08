// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'ماستر الشبكة';

  @override
  String get score => 'النقاط';

  @override
  String get highScore => 'أعلى نتيجة';

  @override
  String get gameOver => 'انتهت اللعبة';

  @override
  String get newHighScore => 'رقم قياسي جديد!';

  @override
  String get playAgain => 'العب مجدداً';

  @override
  String get home => 'الرئيسية';

  @override
  String get share => 'مشاركة';

  @override
  String get settings => 'الإعدادات';

  @override
  String get sound => 'الصوت';

  @override
  String get haptics => 'الاهتزاز';

  @override
  String get resetProgress => 'إعادة تعيين التقدم';

  @override
  String get resetConfirmTitle => 'إعادة تعيين؟';

  @override
  String get resetConfirmContent =>
      'سيتم حذف أعلى النتائج والسمات المفتوحة. لا يمكن التراجع عن هذا.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get save => 'حفظ';

  @override
  String get changeName => 'تغيير الاسم';

  @override
  String get enterName => 'أدخل اسمك';

  @override
  String get leaderboard => 'لوحة المتصدرين';

  @override
  String get loading => 'جارٍ التحميل...';

  @override
  String get error => 'خطأ';

  @override
  String get emptyLeaderboard => 'لا توجد نتائج بعد!';

  @override
  String get tutorialTitle => 'كيف تلعب';

  @override
  String get tutorialStep1 => 'اسحب الكتل إلى الشبكة';

  @override
  String get tutorialStep2 => 'املأ الصفوف أو الأعمدة لمسحها';

  @override
  String get tutorialStep3 => 'استخدم المطرقة لتحطيم الكتل';

  @override
  String get tutorialStep4 => 'لا تنفد المساحة!';

  @override
  String get clear => 'مسح!';

  @override
  String get doubleClear => 'مسح مزدوج!';

  @override
  String get tripleClear => 'مسح ثلاثي!';

  @override
  String megaClear(int count) {
    return 'مسح ضخم! x$count';
  }

  @override
  String get memoryReveal => '👁️ كشف الذاكرة!';

  @override
  String get zenClear => '🧘 مسح زن!';

  @override
  String autoHammer(int count) {
    return '🔨 مطرقة تلقائية! ($count خلية)';
  }

  @override
  String get risingRow => '⬆️ صف صاعد!';

  @override
  String get autoDrop => '⏰ سقوط تلقائي!';

  @override
  String get endSession => 'إنهاء الجلسة';

  @override
  String get findingRival => 'البحث عن منافس...';

  @override
  String matchmakingError(String error) {
    return 'خطأ في البحث: $error';
  }

  @override
  String get zenSummaryTitle => 'جلسة زن';

  @override
  String get totalLines => 'الصفوف الممسوحة';

  @override
  String get maxCombo => 'أقصى كومبو';

  @override
  String get blocksPlaced => 'الكتل الموضوعة';

  @override
  String get playTime => 'وقت اللعب';

  @override
  String get easyMode => 'سهل';

  @override
  String get memoryMode => 'ذاكرة';

  @override
  String get classicMode => 'كلاسيكي';

  @override
  String get masterMode => 'ماستر';

  @override
  String get zenMode => 'زن';

  @override
  String get survivalMode => 'البقاء';

  @override
  String get pvpMode => 'مواجهة';

  @override
  String get practiceMode => 'تدريب';

  @override
  String get skip => 'تخطي';

  @override
  String get next => 'التالي';

  @override
  String get start => 'ابدأ!';
}
