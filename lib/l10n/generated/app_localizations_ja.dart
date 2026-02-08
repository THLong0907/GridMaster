// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'グリッドマスター';

  @override
  String get score => 'スコア';

  @override
  String get highScore => 'ハイスコア';

  @override
  String get gameOver => 'ゲームオーバー';

  @override
  String get newHighScore => '新記録！';

  @override
  String get playAgain => 'もう一度';

  @override
  String get home => 'ホーム';

  @override
  String get share => '共有';

  @override
  String get settings => '設定';

  @override
  String get sound => 'サウンド';

  @override
  String get haptics => '振動';

  @override
  String get resetProgress => '進行状況をリセット';

  @override
  String get resetConfirmTitle => 'リセットしますか？';

  @override
  String get resetConfirmContent => 'ハイスコアとアンロックしたテーマが削除されます。元に戻すことはできません。';

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get save => '保存';

  @override
  String get changeName => '表示名を変更';

  @override
  String get enterName => '名前を入力';

  @override
  String get leaderboard => 'ランキング';

  @override
  String get loading => '読み込み中...';

  @override
  String get error => 'エラー';

  @override
  String get emptyLeaderboard => 'まだスコアがありません！';

  @override
  String get tutorialTitle => '遊び方';

  @override
  String get tutorialStep1 => 'ブロックをグリッドにドラッグ';

  @override
  String get tutorialStep2 => '行か列を埋めてクリア';

  @override
  String get tutorialStep3 => 'ハンマーでブロックを壊す';

  @override
  String get tutorialStep4 => 'スペースを使い切らないで！';

  @override
  String get clear => 'クリア！';

  @override
  String get doubleClear => 'ダブルクリア！';

  @override
  String get tripleClear => 'トリプルクリア！';

  @override
  String megaClear(int count) {
    return 'メガクリア！x$count';
  }

  @override
  String get memoryReveal => '👁️ メモリリビール！';

  @override
  String get zenClear => '🧘 禅クリア！';

  @override
  String autoHammer(int count) {
    return '🔨 オートハンマー！($countセル)';
  }

  @override
  String get risingRow => '⬆️ ライジングロー！';

  @override
  String get autoDrop => '⏰ オートドロップ！';

  @override
  String get endSession => '終了';

  @override
  String get findingRival => '対戦相手を探しています...';

  @override
  String matchmakingError(String error) {
    return 'マッチングエラー：$error';
  }

  @override
  String get zenSummaryTitle => '禅セッション';

  @override
  String get totalLines => 'クリアライン数';

  @override
  String get maxCombo => '最大コンボ';

  @override
  String get blocksPlaced => '配置ブロック数';

  @override
  String get playTime => 'プレイ時間';

  @override
  String get easyMode => 'イージー';

  @override
  String get memoryMode => 'メモリー';

  @override
  String get classicMode => 'クラシック';

  @override
  String get masterMode => 'マスター';

  @override
  String get zenMode => '禅';

  @override
  String get survivalMode => 'サバイバル';

  @override
  String get pvpMode => '対戦';

  @override
  String get practiceMode => '練習';

  @override
  String get skip => 'スキップ';

  @override
  String get next => '次へ';

  @override
  String get start => 'スタート！';
}
