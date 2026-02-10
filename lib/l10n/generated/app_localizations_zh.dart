// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '方块大师';

  @override
  String get score => '分数';

  @override
  String get highScore => '最高分';

  @override
  String get gameOver => '游戏结束';

  @override
  String get newHighScore => '新纪录！';

  @override
  String get playAgain => '再来一局';

  @override
  String get home => '首页';

  @override
  String get share => '分享';

  @override
  String get restart => 'RESTART';

  @override
  String get settings => '设置';

  @override
  String get sound => '音效';

  @override
  String get haptics => '振动';

  @override
  String get resetProgress => '重置进度';

  @override
  String get resetConfirmTitle => '重置进度？';

  @override
  String get resetConfirmContent => '这将删除您的最高分和已解锁的主题。此操作无法撤消。';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get save => '保存';

  @override
  String get changeName => '更改显示名称';

  @override
  String get enterName => '输入您的名字';

  @override
  String get leaderboard => '排行榜';

  @override
  String get loading => '加载中...';

  @override
  String get error => '错误';

  @override
  String get emptyLeaderboard => '暂无成绩！';

  @override
  String get tutorialTitle => '游戏玩法';

  @override
  String get tutorialStep1 => '将方块拖到网格上';

  @override
  String get tutorialStep2 => '填满行或列来消除';

  @override
  String get tutorialStep3 => '使用锤子打碎方块';

  @override
  String get tutorialStep4 => '不要用完空间！';

  @override
  String get clear => '消除！';

  @override
  String get doubleClear => '双重消除！';

  @override
  String get tripleClear => '三重消除！';

  @override
  String megaClear(int count) {
    return '超级消除！x$count';
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
  String get endSession => '结束';

  @override
  String get findingRival => '寻找对手...';

  @override
  String matchmakingError(String error) {
    return '匹配错误：$error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => '消除行数';

  @override
  String get maxCombo => '最高连击';

  @override
  String get blocksPlaced => '放置方块';

  @override
  String get playTime => '游戏时间';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

  @override
  String get easyMode => '简单';

  @override
  String get memoryMode => '记忆';

  @override
  String get classicMode => '经典';

  @override
  String get masterMode => '大师';

  @override
  String get zenMode => '禅意';

  @override
  String get survivalMode => '生存';

  @override
  String get pvpMode => 'PvP 对战';

  @override
  String get practiceMode => '练习';

  @override
  String get skip => '跳过';

  @override
  String get next => '下一步';

  @override
  String get start => '开始！';

  @override
  String get stats => '统计';

  @override
  String get achievements => '成就';

  @override
  String get music => '音乐';

  @override
  String get themes => '主题';

  @override
  String get language => '语言';

  @override
  String get chooseLanguage => '选择语言';

  @override
  String get autoDevice => '自动（设备）';

  @override
  String get data => '数据';

  @override
  String best(int score) {
    return '最高：$score';
  }

  @override
  String get easyDesc => '小网格，小方块多';

  @override
  String get classicDesc => '行上升，快速消除！';

  @override
  String get masterDesc => '自动掉落，拼速度！';

  @override
  String get memoryDesc => '方块消失，记住位置';

  @override
  String get zenDesc => '放松，不会输';

  @override
  String get pvpDesc => '2分钟1v1对战';

  @override
  String get pvpRankedSubtitle => '随机匹配真实玩家';

  @override
  String get pvpPracticeSubtitle => '与机器人单人对战 • 不计排名';

  @override
  String get soloPvp => '单人PvP';

  @override
  String gridInfo(int size) {
    return '$size×$size 网格 • 2分钟';
  }

  @override
  String get dailyChallenge => '每日挑战';

  @override
  String get dailyChallengeSubtitle => '每天新挑战！';

  @override
  String get streak => '连胜';

  @override
  String get completed => '已完成';

  @override
  String get play => '开始';

  @override
  String get noConnection => '无连接';

  @override
  String get tetEffects => '新年特效';

  @override
  String get pause => '暂停';

  @override
  String get resume => '继续';

  @override
  String get quit => '退出';

  @override
  String get paused => '已暂停';

  @override
  String get newFeatures => '新功能';

  @override
  String get privacyPolicy => '隐私政策';

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
