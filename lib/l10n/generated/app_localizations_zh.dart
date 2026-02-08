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
  String get playAgain => '再玩一次';

  @override
  String get home => '主页';

  @override
  String get share => '分享';

  @override
  String get settings => '设置';

  @override
  String get sound => '声音';

  @override
  String get haptics => '振动';

  @override
  String get resetProgress => '重置进度';

  @override
  String get resetConfirmTitle => '重置进度？';

  @override
  String get resetConfirmContent => '这将删除你的最高分和已解锁的主题。此操作无法撤消。';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get save => '保存';

  @override
  String get changeName => '更改显示名称';

  @override
  String get enterName => '输入你的名字';

  @override
  String get leaderboard => '排行榜';

  @override
  String get loading => '加载中...';

  @override
  String get error => '错误';

  @override
  String get emptyLeaderboard => '暂无成绩！';

  @override
  String get tutorialTitle => '游戏规则';

  @override
  String get tutorialStep1 => '将方块拖到网格中';

  @override
  String get tutorialStep2 => '填满行或列即可消除';

  @override
  String get tutorialStep3 => '使用锤子破坏方块';

  @override
  String get tutorialStep4 => '别让空间用完！';

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
  String get memoryReveal => '👁️ 记忆揭示！';

  @override
  String get zenClear => '🧘 禅意消除！';

  @override
  String autoHammer(int count) {
    return '🔨 自动锤子！($count格)';
  }

  @override
  String get risingRow => '⬆️ 上升行！';

  @override
  String get autoDrop => '⏰ 自动下落！';

  @override
  String get endSession => '结束';

  @override
  String get findingRival => '寻找对手...';

  @override
  String matchmakingError(String error) {
    return '匹配错误：$error';
  }

  @override
  String get zenSummaryTitle => '禅意模式';

  @override
  String get totalLines => '消除行数';

  @override
  String get maxCombo => '最高连击';

  @override
  String get blocksPlaced => '放置方块';

  @override
  String get playTime => '游戏时间';

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
  String get pvpMode => '对战';

  @override
  String get practiceMode => '练习';

  @override
  String get skip => '跳过';

  @override
  String get next => '下一步';

  @override
  String get start => '开始！';
}
