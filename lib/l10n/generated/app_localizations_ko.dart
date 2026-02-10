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
  String get highScore => '최고 점수';

  @override
  String get gameOver => '게임 오버';

  @override
  String get newHighScore => '신기록!';

  @override
  String get playAgain => '다시 하기';

  @override
  String get home => '홈';

  @override
  String get share => '공유';

  @override
  String get restart => 'RESTART';

  @override
  String get settings => '설정';

  @override
  String get sound => '소리';

  @override
  String get haptics => '진동';

  @override
  String get resetProgress => '진행 초기화';

  @override
  String get resetConfirmTitle => '초기화하시겠습니까?';

  @override
  String get resetConfirmContent => '최고 점수와 잠금 해제된 테마가 모두 삭제됩니다. 되돌릴 수 없습니다.';

  @override
  String get cancel => '취소';

  @override
  String get delete => '삭제';

  @override
  String get save => '저장';

  @override
  String get changeName => '표시 이름 변경';

  @override
  String get enterName => '이름 입력';

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
  String get tutorialStep1 => '블록을 그리드로 드래그';

  @override
  String get tutorialStep2 => '행이나 열을 채워서 클리어';

  @override
  String get tutorialStep3 => '해머로 블록 제거';

  @override
  String get tutorialStep4 => '공간이 부족하지 않게!';

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
  String get endSession => '종료';

  @override
  String get findingRival => '상대 찾는 중...';

  @override
  String matchmakingError(String error) {
    return '매칭 오류: $error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => '클리어한 줄';

  @override
  String get maxCombo => '최대 콤보';

  @override
  String get blocksPlaced => '배치한 블록';

  @override
  String get playTime => '플레이 시간';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

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
  String get pvpMode => 'PvP 배틀';

  @override
  String get practiceMode => '연습';

  @override
  String get skip => '건너뛰기';

  @override
  String get next => '다음';

  @override
  String get start => '시작!';

  @override
  String get stats => '통계';

  @override
  String get achievements => '업적';

  @override
  String get music => '음악';

  @override
  String get themes => '테마';

  @override
  String get language => '언어';

  @override
  String get chooseLanguage => '언어 선택';

  @override
  String get autoDevice => '자동 (기기)';

  @override
  String get data => '데이터';

  @override
  String best(int score) {
    return '최고: $score';
  }

  @override
  String get easyDesc => '작은 그리드, 작은 블록 다수';

  @override
  String get classicDesc => '행이 올라가요, 빠르게 클리어!';

  @override
  String get masterDesc => '자동 드롭, 스피드!';

  @override
  String get memoryDesc => '블록이 사라져요, 위치를 기억하세요';

  @override
  String get zenDesc => '릴랙스, 지는 일 없음';

  @override
  String get pvpDesc => '2분간 1대1 배틀';

  @override
  String get pvpRankedSubtitle => '실제 플레이어와 랜덤 매치';

  @override
  String get pvpPracticeSubtitle => '봇과 솔로 플레이 • 랭크 없음';

  @override
  String get soloPvp => '솔로 PvP';

  @override
  String gridInfo(int size) {
    return '$size×$size 그리드 • 2분';
  }

  @override
  String get dailyChallenge => '일일 챌린지';

  @override
  String get dailyChallengeSubtitle => '매일 새로운 도전!';

  @override
  String get streak => '연속';

  @override
  String get completed => '완료';

  @override
  String get play => '플레이';

  @override
  String get noConnection => '연결 없음';

  @override
  String get tetEffects => '설날 효과';

  @override
  String get pause => '일시정지';

  @override
  String get resume => '재개';

  @override
  String get quit => '종료';

  @override
  String get paused => '일시정지';

  @override
  String get newFeatures => '새 기능';

  @override
  String get privacyPolicy => '개인정보 처리방침';

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
