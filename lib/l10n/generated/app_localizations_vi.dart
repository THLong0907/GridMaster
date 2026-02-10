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
  String get restart => 'CHƠI LẠI';

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
  String get tutorialStep1 => 'Kéo các khối gạch vào lưới';

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
  String get memoryReveal => 'Lộ diện!';

  @override
  String get zenClear => 'Tĩnh tâm!';

  @override
  String autoHammer(int count) {
    return 'Búa Tự Động! ($count ô)';
  }

  @override
  String get risingRow => 'Hàng đang dâng!';

  @override
  String get autoDrop => 'Tự động thả!';

  @override
  String get endSession => 'Kết thúc';

  @override
  String get findingRival => 'TÌM ĐỐI THỦ...';

  @override
  String matchmakingError(String error) {
    return 'Lỗi tìm trận: $error';
  }

  @override
  String get zenSummaryTitle => 'PHIÊN THIỀN KẾT THÚC';

  @override
  String get totalLines => 'Hàng xóa';

  @override
  String get maxCombo => 'Combo max';

  @override
  String get blocksPlaced => 'Khối đặt';

  @override
  String get playTime => 'Thời gian thiền';

  @override
  String get continueBtn => 'Tiếp tục';

  @override
  String get backToLobby => 'Về Lobby';

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

  @override
  String get stats => 'Thống kê';

  @override
  String get achievements => 'Thành tích';

  @override
  String get music => 'Nhạc nền';

  @override
  String get themes => 'Giao diện';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get chooseLanguage => 'Chọn ngôn ngữ';

  @override
  String get autoDevice => 'Tự động (Thiết bị)';

  @override
  String get data => 'Dữ liệu';

  @override
  String best(int score) {
    return 'Cao nhất: $score';
  }

  @override
  String get easyDesc => 'Lưới nhỏ, khối nhỏ nhiều';

  @override
  String get classicDesc => 'Hàng dâng lên, phá nhanh!';

  @override
  String get masterDesc => 'Khối tự đặt, tốc độ!';

  @override
  String get memoryDesc => 'Khối biến mất, nhớ vị trí';

  @override
  String get zenDesc => 'Thư giãn, không thua';

  @override
  String get pvpDesc => 'Đấu 1v1 trong 2 phút';

  @override
  String get pvpRankedSubtitle => 'Ghép ngẫu nhiên với người chơi thật';

  @override
  String get pvpPracticeSubtitle => 'Chơi solo với BOT • Không tính xếp hạng';

  @override
  String get soloPvp => 'Solo PvP';

  @override
  String gridInfo(int size) {
    return 'Lưới $size×$size • 2 Phút';
  }

  @override
  String get dailyChallenge => 'Thử thách mỗi ngày';

  @override
  String get dailyChallengeSubtitle => 'Thử thách mới mỗi ngày!';

  @override
  String get streak => 'Chuỗi';

  @override
  String get completed => 'Đã hoàn thành';

  @override
  String get play => 'CHƠI';

  @override
  String get noConnection => 'Không có kết nối';

  @override
  String get tetEffects => 'Hiệu ứng Tết';

  @override
  String get pause => 'Tạm dừng';

  @override
  String get resume => 'TIẾP TỤC';

  @override
  String get quit => 'THOÁT';

  @override
  String get paused => 'TẠM DỪNG';

  @override
  String get newFeatures => 'Tính năng mới';

  @override
  String get privacyPolicy => 'Chính sách bảo mật';

  @override
  String get pvpWin => 'BẠN THẮNG!';

  @override
  String get pvpLose => 'BẠN THUA';

  @override
  String get pvpDraw => 'HÒA';

  @override
  String get uploading => 'Đang tải...';

  @override
  String get uploadToLeaderboard => 'Gửi lên bảng xếp hạng';

  @override
  String get scoreUploaded => 'Đã gửi điểm!';

  @override
  String get uploadFailed => 'Gửi thất bại. Kiểm tra kết nối.';

  @override
  String get tutorialReset => 'Tutorial sẽ hiện lại lần chơi tiếp theo';

  @override
  String get highScoresCleared => 'Đã xóa tất cả điểm cao';

  @override
  String get botBeginner => 'Tập Sự';

  @override
  String get botPro => 'Chuyên Nghiệp';

  @override
  String get botDestroyer => 'Hủy Diệt';

  @override
  String get botGodlike => 'Siêu Thần';

  @override
  String get version => 'Phiên bản';

  @override
  String get engine => 'Engine';

  @override
  String get timer => 'TIMER';

  @override
  String get soundSubtitle => 'Hiệu ứng âm thanh';

  @override
  String get hapticsSubtitle => 'Phản hồi rung';

  @override
  String get musicSubtitle => 'Nhạc nền game';

  @override
  String get tetSubtitle => 'Hiệu ứng hình ảnh Tết';

  @override
  String get tutorialSubtitle => 'Hiện lại hướng dẫn';

  @override
  String get resetSubtitle => 'Xóa tất cả điểm cao';

  @override
  String get shareScore => 'CHIA SẺ ĐIỂM';

  @override
  String get you => 'BẠN';

  @override
  String get rival => 'ĐỐI THỦ';
}
