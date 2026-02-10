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
  String get restart => 'RESTART';

  @override
  String get settings => 'הגדרות';

  @override
  String get sound => 'צליל';

  @override
  String get haptics => 'רטט';

  @override
  String get resetProgress => 'איפוס התקדמות';

  @override
  String get resetConfirmTitle => 'לאפס?';

  @override
  String get resetConfirmContent =>
      'כל הניקודים והעיצובים יימחקו. לא ניתן לבטל.';

  @override
  String get cancel => 'ביטול';

  @override
  String get delete => 'מחק';

  @override
  String get save => 'שמור';

  @override
  String get changeName => 'שנה שם';

  @override
  String get enterName => 'הזן את שמך';

  @override
  String get leaderboard => 'טבלת מובילים';

  @override
  String get loading => 'טוען...';

  @override
  String get error => 'שגיאה';

  @override
  String get emptyLeaderboard => 'אין ניקודים עדיין!';

  @override
  String get tutorialTitle => 'איך לשחק';

  @override
  String get tutorialStep1 => 'גרור בלוקים לרשת';

  @override
  String get tutorialStep2 => 'מלא שורות או עמודות';

  @override
  String get tutorialStep3 => 'השתמש בפטיש לשבירה';

  @override
  String get tutorialStep4 => 'אל תיגמר לך מקום!';

  @override
  String get clear => 'מעולה!';

  @override
  String get doubleClear => 'כפול!';

  @override
  String get tripleClear => 'משולש!';

  @override
  String megaClear(int count) {
    return 'מגה! x$count';
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
  String get endSession => 'סיום';

  @override
  String get findingRival => 'מחפש יריב...';

  @override
  String matchmakingError(String error) {
    return 'שגיאת התאמה: $error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => 'שורות שנמחקו';

  @override
  String get maxCombo => 'קומבו מקסימלי';

  @override
  String get blocksPlaced => 'בלוקים שהונחו';

  @override
  String get playTime => 'זמן משחק';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

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
  String get practiceMode => 'אימון';

  @override
  String get skip => 'דלג';

  @override
  String get next => 'הבא';

  @override
  String get start => 'התחל!';

  @override
  String get stats => 'סטטיסטיקות';

  @override
  String get achievements => 'הישגים';

  @override
  String get music => 'מוזיקה';

  @override
  String get themes => 'עיצובים';

  @override
  String get language => 'שפה';

  @override
  String get chooseLanguage => 'בחר שפה';

  @override
  String get autoDevice => 'אוטומטי (מכשיר)';

  @override
  String get data => 'נתונים';

  @override
  String best(int score) {
    return 'שיא: $score';
  }

  @override
  String get easyDesc => 'רשת קטנה, בלוקים קטנים';

  @override
  String get classicDesc => 'שורות עולות, מחק מהר!';

  @override
  String get masterDesc => 'נפילה אוטומטית, מהירות!';

  @override
  String get memoryDesc => 'בלוקים נעלמים, זכור מיקומים';

  @override
  String get zenDesc => 'הרגע, בלי להפסיד';

  @override
  String get pvpDesc => 'דו-קרב 1v1 ב-2 דקות';

  @override
  String get pvpRankedSubtitle => 'משחק אקראי עם שחקנים אמיתיים';

  @override
  String get pvpPracticeSubtitle => 'משחק יחיד נגד בוט • ללא דירוג';

  @override
  String get soloPvp => 'PvP יחיד';

  @override
  String gridInfo(int size) {
    return 'רשת $size×$size • 2 דקות';
  }

  @override
  String get dailyChallenge => 'אתגר יומי';

  @override
  String get dailyChallengeSubtitle => 'אתגר חדש כל יום!';

  @override
  String get streak => 'רצף';

  @override
  String get completed => 'הושלם';

  @override
  String get play => 'שחק';

  @override
  String get noConnection => 'אין חיבור';

  @override
  String get tetEffects => 'אפקטי שנה חדשה';

  @override
  String get pause => 'השהה';

  @override
  String get resume => 'המשך';

  @override
  String get quit => 'צא';

  @override
  String get paused => 'מושהה';

  @override
  String get newFeatures => 'תכונות חדשות';

  @override
  String get privacyPolicy => 'מדיניות פרטיות';

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
