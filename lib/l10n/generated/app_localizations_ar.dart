// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'غريد ماستر';

  @override
  String get score => 'النقاط';

  @override
  String get highScore => 'أعلى نتيجة';

  @override
  String get gameOver => 'انتهت اللعبة';

  @override
  String get newHighScore => 'رقم قياسي جديد!';

  @override
  String get playAgain => 'العب مرة أخرى';

  @override
  String get home => 'الرئيسية';

  @override
  String get share => 'مشاركة';

  @override
  String get restart => 'RESTART';

  @override
  String get settings => 'الإعدادات';

  @override
  String get sound => 'الصوت';

  @override
  String get haptics => 'الاهتزاز';

  @override
  String get resetProgress => 'إعادة التعيين';

  @override
  String get resetConfirmTitle => 'إعادة التعيين؟';

  @override
  String get resetConfirmContent =>
      'سيتم حذف جميع النتائج والسمات. لا يمكن التراجع.';

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
  String get loading => 'جاري التحميل...';

  @override
  String get error => 'خطأ';

  @override
  String get emptyLeaderboard => 'لا توجد نتائج بعد!';

  @override
  String get tutorialTitle => 'طريقة اللعب';

  @override
  String get tutorialStep1 => 'اسحب الكتل إلى الشبكة';

  @override
  String get tutorialStep2 => 'املأ الصفوف أو الأعمدة لمسحها';

  @override
  String get tutorialStep3 => 'استخدم المطرقة لتحطيم الكتل';

  @override
  String get tutorialStep4 => 'لا تنفد المساحة!';

  @override
  String get clear => 'رائع!';

  @override
  String get doubleClear => 'مزدوج!';

  @override
  String get tripleClear => 'ثلاثي!';

  @override
  String megaClear(int count) {
    return 'ميغا! x$count';
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
  String get endSession => 'إنهاء';

  @override
  String get findingRival => 'البحث عن منافس...';

  @override
  String matchmakingError(String error) {
    return 'خطأ في المطابقة: $error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => 'خطوط ممسوحة';

  @override
  String get maxCombo => 'أقصى كومبو';

  @override
  String get blocksPlaced => 'كتل موضوعة';

  @override
  String get playTime => 'وقت اللعب';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

  @override
  String get easyMode => 'سهل';

  @override
  String get memoryMode => 'ذاكرة';

  @override
  String get classicMode => 'كلاسيكي';

  @override
  String get masterMode => 'خبير';

  @override
  String get zenMode => 'زِن';

  @override
  String get survivalMode => 'بقاء';

  @override
  String get pvpMode => 'معركة PvP';

  @override
  String get practiceMode => 'تدريب';

  @override
  String get skip => 'تخطي';

  @override
  String get next => 'التالي';

  @override
  String get start => 'ابدأ!';

  @override
  String get stats => 'الإحصائيات';

  @override
  String get achievements => 'الإنجازات';

  @override
  String get music => 'الموسيقى';

  @override
  String get themes => 'السمات';

  @override
  String get language => 'اللغة';

  @override
  String get chooseLanguage => 'اختر اللغة';

  @override
  String get autoDevice => 'تلقائي (الجهاز)';

  @override
  String get data => 'البيانات';

  @override
  String best(int score) {
    return 'الأفضل: $score';
  }

  @override
  String get easyDesc => 'شبكة صغيرة، كتل صغيرة';

  @override
  String get classicDesc => 'صفوف صاعدة، امسح بسرعة!';

  @override
  String get masterDesc => 'سقوط تلقائي، سرعة!';

  @override
  String get memoryDesc => 'الكتل تختفي، تذكر المواقع';

  @override
  String get zenDesc => 'استرخِ، بدون خسارة';

  @override
  String get pvpDesc => 'مبارزة 1v1 في دقيقتين';

  @override
  String get pvpRankedSubtitle => 'مباراة عشوائية مع لاعبين حقيقيين';

  @override
  String get pvpPracticeSubtitle => 'العب ضد بوت • بدون تصنيف';

  @override
  String get soloPvp => 'PvP فردي';

  @override
  String gridInfo(int size) {
    return 'شبكة $size×$size • دقيقتان';
  }

  @override
  String get dailyChallenge => 'تحدي يومي';

  @override
  String get dailyChallengeSubtitle => 'تحدٍ جديد كل يوم!';

  @override
  String get streak => 'سلسلة';

  @override
  String get completed => 'مكتمل';

  @override
  String get play => 'العب';

  @override
  String get noConnection => 'لا يوجد اتصال';

  @override
  String get tetEffects => 'تأثيرات رأس السنة';

  @override
  String get pause => 'إيقاف مؤقت';

  @override
  String get resume => 'استئناف';

  @override
  String get quit => 'خروج';

  @override
  String get paused => 'متوقف';

  @override
  String get newFeatures => 'ميزات جديدة';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

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
