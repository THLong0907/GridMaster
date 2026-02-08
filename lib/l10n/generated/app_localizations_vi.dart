// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Vua Xếp Gạch';

  @override
  String get score => 'ĐIỂM';

  @override
  String get highScore => 'KỶ LỤC';

  @override
  String get gameOver => 'KẾT THÚC';

  @override
  String get newHighScore => 'KỶ LỤC MỚI!';

  @override
  String get playAgain => 'CHƠI LẠI';

  @override
  String get home => 'TRANG CHỦ';

  @override
  String get share => 'CHIA SẺ';

  @override
  String get settings => 'Cài đặt';

  @override
  String get sound => 'Âm thanh';

  @override
  String get haptics => 'Rung';

  @override
  String get resetProgress => 'Xóa dữ liệu';

  @override
  String get resetConfirmTitle => 'Xóa dữ liệu chơi?';

  @override
  String get resetConfirmContent =>
      'Hành động này sẽ xóa toàn bộ điểm cao và giao diện đã mở khóa. Không thể hoàn tác.';

  @override
  String get cancel => 'Hủy';

  @override
  String get delete => 'Xóa';

  @override
  String get save => 'Lưu';

  @override
  String get changeName => 'Đổi tên hiển thị';

  @override
  String get enterName => 'Nhập tên của bạn';

  @override
  String get leaderboard => 'Bảng xếp hạng';

  @override
  String get loading => 'Đang tải...';

  @override
  String get error => 'Lỗi';

  @override
  String get emptyLeaderboard => 'Chưa có điểm nào!';

  @override
  String get tutorialTitle => 'Cách chơi';

  @override
  String get tutorialStep1 => 'Kéo các khối gạch vào lưới 8x8';

  @override
  String get tutorialStep2 => 'Lấp đầy hàng ngang hoặc dọc để ghi điểm';

  @override
  String get tutorialStep3 => 'Dùng búa để phá hủy một vùng 3x3 khi bí';

  @override
  String get tutorialStep4 => 'Trò chơi kết thúc khi không còn chỗ trống';

  @override
  String get clear => 'Tuyệt vời!';

  @override
  String get doubleClear => 'Quá Đỉnh!';

  @override
  String get tripleClear => 'XUẤT SẮC!';

  @override
  String megaClear(int count) {
    return 'HUYỀN THOẠI! x$count';
  }

  @override
  String get memoryReveal => '👁️ Lộ diện!';

  @override
  String get zenClear => '🧘 Tĩnh tâm!';

  @override
  String autoHammer(int count) {
    return '🔨 Búa Tự Động! ($count ô)';
  }

  @override
  String get risingRow => '⬆️ Hàng đang dâng!';

  @override
  String get autoDrop => '⏰ Tự động thả!';

  @override
  String get endSession => 'Kết thúc';

  @override
  String get findingRival => 'TÌM ĐỐI THỦ...';

  @override
  String matchmakingError(String error) {
    return 'Lỗi tìm trận: $error';
  }

  @override
  String get zenSummaryTitle => 'Tổng kết Zen';

  @override
  String get totalLines => 'Số hàng đã xóa';

  @override
  String get maxCombo => 'Combo cao nhất';

  @override
  String get blocksPlaced => 'Số khối đã đặt';

  @override
  String get playTime => 'Thời gian chơi';

  @override
  String get easyMode => 'Dễ';

  @override
  String get memoryMode => 'Trí Nhớ';

  @override
  String get classicMode => 'Cổ Điển';

  @override
  String get masterMode => 'Bậc Thầy';

  @override
  String get zenMode => 'Thư Giãn';

  @override
  String get survivalMode => 'Sinh Tồn';

  @override
  String get pvpMode => 'Đấu PvP';

  @override
  String get practiceMode => 'Luyện Tập';

  @override
  String get skip => 'Bỏ qua';

  @override
  String get next => 'Tiếp';

  @override
  String get start => 'BẮT ĐẦU!';
}
