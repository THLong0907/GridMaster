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
  String get playAgain => 'เล่นอีก';

  @override
  String get home => 'หน้าแรก';

  @override
  String get share => 'แชร์';

  @override
  String get settings => 'การตั้งค่า';

  @override
  String get sound => 'เสียง';

  @override
  String get haptics => 'การสั่น';

  @override
  String get resetProgress => 'รีเซ็ตความก้าวหน้า';

  @override
  String get resetConfirmTitle => 'รีเซ็ต?';

  @override
  String get resetConfirmContent =>
      'คะแนนสูงสุดและธีมที่ปลดล็อกจะถูกลบ ไม่สามารถย้อนกลับได้';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get delete => 'ลบ';

  @override
  String get save => 'บันทึก';

  @override
  String get changeName => 'เปลี่ยนชื่อ';

  @override
  String get enterName => 'กรอกชื่อของคุณ';

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
  String get tutorialStep1 => 'ลากบล็อกไปที่กริด';

  @override
  String get tutorialStep2 => 'เติมแถวหรือคอลัมน์เพื่อล้าง';

  @override
  String get tutorialStep3 => 'ใช้ค้อนทำลายบล็อก';

  @override
  String get tutorialStep4 => 'อย่าให้พื้นที่หมด!';

  @override
  String get clear => 'ล้าง!';

  @override
  String get doubleClear => 'ดับเบิ้ลเคลียร์!';

  @override
  String get tripleClear => 'ทริปเปิ้ลเคลียร์!';

  @override
  String megaClear(int count) {
    return 'เมก้าเคลียร์! x$count';
  }

  @override
  String get memoryReveal => '👁️ เปิดเผยหน่วยความจำ!';

  @override
  String get zenClear => '🧘 เซนเคลียร์!';

  @override
  String autoHammer(int count) {
    return '🔨 ค้อนอัตโนมัติ! ($count ช่อง)';
  }

  @override
  String get risingRow => '⬆️ แถวยกขึ้น!';

  @override
  String get autoDrop => '⏰ ดรอปอัตโนมัติ!';

  @override
  String get endSession => 'จบเซสชัน';

  @override
  String get findingRival => 'กำลังหาคู่แข่ง...';

  @override
  String matchmakingError(String error) {
    return 'ข้อผิดพลาดจับคู่: $error';
  }

  @override
  String get zenSummaryTitle => 'เซสชันเซน';

  @override
  String get totalLines => 'เคลียร์แถว';

  @override
  String get maxCombo => 'คอมโบสูงสุด';

  @override
  String get blocksPlaced => 'วางบล็อก';

  @override
  String get playTime => 'เวลาเล่น';

  @override
  String get easyMode => 'ง่าย';

  @override
  String get memoryMode => 'หน่วยความจำ';

  @override
  String get classicMode => 'คลาสสิก';

  @override
  String get masterMode => 'มาสเตอร์';

  @override
  String get zenMode => 'เซน';

  @override
  String get survivalMode => 'เอาตัวรอด';

  @override
  String get pvpMode => 'สู้กัน';

  @override
  String get practiceMode => 'ฝึกซ้อม';

  @override
  String get skip => 'ข้าม';

  @override
  String get next => 'ถัดไป';

  @override
  String get start => 'เริ่ม!';
}
