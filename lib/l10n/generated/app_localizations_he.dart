// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get appTitle => 'גריד מאסטר';

  @override
  String get score => 'ניקוד';

  @override
  String get highScore => 'שיא';

  @override
  String get gameOver => 'המשחק נגמר';

  @override
  String get newHighScore => 'שיא חדש!';

  @override
  String get playAgain => 'שחק שוב';

  @override
  String get home => 'בית';

  @override
  String get share => 'שתף';

  @override
  String get settings => 'הגדרות';

  @override
  String get sound => 'צליל';

  @override
  String get haptics => 'רטט';

  @override
  String get resetProgress => 'אפס התקדמות';

  @override
  String get resetConfirmTitle => 'לאפס?';

  @override
  String get resetConfirmContent =>
      'פעולה זו תמחק את השיאים שלך ואת הערכות הנושא שנפתחו. לא ניתן לבטל.';

  @override
  String get cancel => 'ביטול';

  @override
  String get delete => 'מחק';

  @override
  String get save => 'שמור';

  @override
  String get changeName => 'שנה שם';

  @override
  String get enterName => 'הכנס את שמך';

  @override
  String get leaderboard => 'טבלת מובילים';

  @override
  String get loading => 'טוען...';

  @override
  String get error => 'שגיאה';

  @override
  String get emptyLeaderboard => 'אין ניקוד עדיין!';

  @override
  String get tutorialTitle => 'איך לשחק';

  @override
  String get tutorialStep1 => 'גרור בלוקים לרשת';

  @override
  String get tutorialStep2 => 'מלא שורות או עמודות כדי לנקות';

  @override
  String get tutorialStep3 => 'השתמש בפטיש כדי לשבור בלוקים';

  @override
  String get tutorialStep4 => 'אל תיגמר לך מקום!';

  @override
  String get clear => 'נוקה!';

  @override
  String get doubleClear => 'ניקוי כפול!';

  @override
  String get tripleClear => 'ניקוי משולש!';

  @override
  String megaClear(int count) {
    return 'מגה ניקוי! x$count';
  }

  @override
  String get memoryReveal => '👁️ חשיפת זיכרון!';

  @override
  String get zenClear => '🧘 ניקוי זן!';

  @override
  String autoHammer(int count) {
    return '🔨 פטיש אוטומטי! ($count תאים)';
  }

  @override
  String get risingRow => '⬆️ שורה עולה!';

  @override
  String get autoDrop => '⏰ נפילה אוטומטית!';

  @override
  String get endSession => 'סיום';

  @override
  String get findingRival => 'מחפש יריב...';

  @override
  String matchmakingError(String error) {
    return 'שגיאת חיפוש: $error';
  }

  @override
  String get zenSummaryTitle => 'מפגש זן';

  @override
  String get totalLines => 'שורות שנוקו';

  @override
  String get maxCombo => 'קומבו מקסימלי';

  @override
  String get blocksPlaced => 'בלוקים שהונחו';

  @override
  String get playTime => 'זמן משחק';

  @override
  String get easyMode => 'קל';

  @override
  String get memoryMode => 'זיכרון';

  @override
  String get classicMode => 'קלאסי';

  @override
  String get masterMode => 'מאסטר';

  @override
  String get zenMode => 'זן';

  @override
  String get survivalMode => 'הישרדות';

  @override
  String get pvpMode => 'קרב PvP';

  @override
  String get practiceMode => 'תרגול';

  @override
  String get skip => 'דלג';

  @override
  String get next => 'הבא';

  @override
  String get start => 'התחל!';
}
