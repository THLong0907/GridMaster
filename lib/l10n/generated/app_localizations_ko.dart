// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '그리드 마스터';

  @override
  String get score => '점수';

  @override
  String get highScore => '최고점수';

  @override
  String get gameOver => '게임 오버';

  @override
  String get newHighScore => '신기록!';

  @override
  String get playAgain => '다시하기';

  @override
  String get home => '홈';

  @override
  String get share => '공유';

  @override
  String get settings => '설정';

  @override
  String get sound => '소리';

  @override
  String get haptics => '진동';

  @override
  String get resetProgress => '진행 초기화';

  @override
  String get resetConfirmTitle => '초기화할까요?';

  @override
  String get resetConfirmContent => '최고 점수와 잠금 해제된 테마가 삭제됩니다. 되돌릴 수 없습니다.';

  @override
  String get cancel => '취소';

  @override
  String get delete => '삭제';

  @override
  String get save => '저장';

  @override
  String get changeName => '이름 변경';

  @override
  String get enterName => '이름을 입력하세요';

  @override
  String get leaderboard => '리더보드';

  @override
  String get loading => '로딩 중...';

  @override
  String get error => '오류';

  @override
  String get emptyLeaderboard => '아직 점수가 없습니다!';

  @override
  String get tutorialTitle => '게임 방법';

  @override
  String get tutorialStep1 => '블록을 그리드에 드래그';

  @override
  String get tutorialStep2 => '행이나 열을 채워서 클리어';

  @override
  String get tutorialStep3 => '해머로 블록을 부수세요';

  @override
  String get tutorialStep4 => '공간을 다 쓰지 마세요!';

  @override
  String get clear => '클리어!';

  @override
  String get doubleClear => '더블 클리어!';

  @override
  String get tripleClear => '트리플 클리어!';

  @override
  String megaClear(int count) {
    return '메가 클리어! x$count';
  }

  @override
  String get memoryReveal => '👁️ 메모리 공개!';

  @override
  String get zenClear => '🧘 젠 클리어!';

  @override
  String autoHammer(int count) {
    return '🔨 자동 해머! ($count칸)';
  }

  @override
  String get risingRow => '⬆️ 상승 행!';

  @override
  String get autoDrop => '⏰ 자동 드롭!';

  @override
  String get endSession => '종료';

  @override
  String get findingRival => '상대를 찾는 중...';

  @override
  String matchmakingError(String error) {
    return '매칭 오류: $error';
  }

  @override
  String get zenSummaryTitle => '젠 세션';

  @override
  String get totalLines => '클리어 라인';

  @override
  String get maxCombo => '최대 콤보';

  @override
  String get blocksPlaced => '배치 블록';

  @override
  String get playTime => '플레이 시간';

  @override
  String get easyMode => '쉬움';

  @override
  String get memoryMode => '메모리';

  @override
  String get classicMode => '클래식';

  @override
  String get masterMode => '마스터';

  @override
  String get zenMode => '젠';

  @override
  String get survivalMode => '서바이벌';

  @override
  String get pvpMode => '대전';

  @override
  String get practiceMode => '연습';

  @override
  String get skip => '건너뛰기';

  @override
  String get next => '다음';

  @override
  String get start => '시작!';
}
