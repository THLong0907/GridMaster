// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'กริดมาสเตอร์';

  @override
  String get score => 'คะแนน';

  @override
  String get highScore => 'คะแนนสูงสุด';

  @override
  String get gameOver => 'จบเกม';

  @override
  String get newHighScore => 'สถิติใหม่!';

  @override
  String get playAgain => 'เล่นอีกครั้ง';

  @override
  String get home => 'หน้าหลัก';

  @override
  String get share => 'แชร์';

  @override
  String get restart => 'RESTART';

  @override
  String get settings => 'ตั้งค่า';

  @override
  String get sound => 'เสียง';

  @override
  String get haptics => 'สั่น';

  @override
  String get resetProgress => 'รีเซ็ตความคืบหน้า';

  @override
  String get resetConfirmTitle => 'รีเซ็ต?';

  @override
  String get resetConfirmContent =>
      'คะแนนและธีมจะถูกลบทั้งหมด ไม่สามารถย้อนกลับได้';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get delete => 'ลบ';

  @override
  String get save => 'บันทึก';

  @override
  String get changeName => 'เปลี่ยนชื่อ';

  @override
  String get enterName => 'ป้อนชื่อของคุณ';

  @override
  String get leaderboard => 'กระดานผู้นำ';

  @override
  String get loading => 'กำลังโหลด...';

  @override
  String get error => 'ข้อผิดพลาด';

  @override
  String get emptyLeaderboard => 'ยังไม่มีคะแนน!';

  @override
  String get tutorialTitle => 'วิธีเล่น';

  @override
  String get tutorialStep1 => 'ลากบล็อกไปยังตาราง';

  @override
  String get tutorialStep2 => 'เติมแถวหรือคอลัมน์เพื่อเคลียร์';

  @override
  String get tutorialStep3 => 'ใช้ค้อนทุบบล็อก';

  @override
  String get tutorialStep4 => 'อย่าให้หมดพื้นที่!';

  @override
  String get clear => 'เยี่ยม!';

  @override
  String get doubleClear => 'ดับเบิ้ล!';

  @override
  String get tripleClear => 'ทริปเปิ้ล!';

  @override
  String megaClear(int count) {
    return 'เมก้า! x$count';
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
  String get endSession => 'จบเซสชัน';

  @override
  String get findingRival => 'กำลังหาคู่แข่ง...';

  @override
  String matchmakingError(String error) {
    return 'ข้อผิดพลาดจับคู่: $error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => 'เส้นที่เคลียร์';

  @override
  String get maxCombo => 'คอมโบสูงสุด';

  @override
  String get blocksPlaced => 'บล็อกที่วาง';

  @override
  String get playTime => 'เวลาเล่น';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

  @override
  String get easyMode => 'ง่าย';

  @override
  String get memoryMode => 'ความจำ';

  @override
  String get classicMode => 'คลาสสิก';

  @override
  String get masterMode => 'มาสเตอร์';

  @override
  String get zenMode => 'เซน';

  @override
  String get survivalMode => 'เอาชีวิตรอด';

  @override
  String get pvpMode => 'PvP ต่อสู้';

  @override
  String get practiceMode => 'ฝึกซ้อม';

  @override
  String get skip => 'ข้าม';

  @override
  String get next => 'ถัดไป';

  @override
  String get start => 'เริ่ม!';

  @override
  String get stats => 'สถิติ';

  @override
  String get achievements => 'ความสำเร็จ';

  @override
  String get music => 'เพลง';

  @override
  String get themes => 'ธีม';

  @override
  String get language => 'ภาษา';

  @override
  String get chooseLanguage => 'เลือกภาษา';

  @override
  String get autoDevice => 'อัตโนมัติ (อุปกรณ์)';

  @override
  String get data => 'ข้อมูล';

  @override
  String best(int score) {
    return 'ดีที่สุด: $score';
  }

  @override
  String get easyDesc => 'ตารางเล็ก บล็อกเล็กเยอะ';

  @override
  String get classicDesc => 'แถวขึ้น เคลียร์เร็ว!';

  @override
  String get masterDesc => 'ตกอัตโนมัติ ความเร็ว!';

  @override
  String get memoryDesc => 'บล็อกหายไป จำตำแหน่ง';

  @override
  String get zenDesc => 'ผ่อนคลาย ไม่แพ้';

  @override
  String get pvpDesc => 'ต่อสู้ 1v1 ใน 2 นาที';

  @override
  String get pvpRankedSubtitle => 'จับคู่แบบสุ่มกับผู้เล่นจริง';

  @override
  String get pvpPracticeSubtitle => 'เล่นเดี่ยวกับ BOT • ไม่มีอันดับ';

  @override
  String get soloPvp => 'โซโล PvP';

  @override
  String gridInfo(int size) {
    return 'ตาราง $size×$size • 2 นาที';
  }

  @override
  String get dailyChallenge => 'ท้าทายประจำวัน';

  @override
  String get dailyChallengeSubtitle => 'ท้าทายใหม่ทุกวัน!';

  @override
  String get streak => 'ต่อเนื่อง';

  @override
  String get completed => 'เสร็จสิ้น';

  @override
  String get play => 'เล่น';

  @override
  String get noConnection => 'ไม่มีการเชื่อมต่อ';

  @override
  String get tetEffects => 'เอฟเฟกต์ปีใหม่';

  @override
  String get pause => 'หยุดชั่วคราว';

  @override
  String get resume => 'เล่นต่อ';

  @override
  String get quit => 'ออก';

  @override
  String get paused => 'หยุดชั่วคราว';

  @override
  String get newFeatures => 'ฟีเจอร์ใหม่';

  @override
  String get privacyPolicy => 'นโยบายความเป็นส่วนตัว';

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
