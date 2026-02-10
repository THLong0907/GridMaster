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
  String get restart => 'RESTART';

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
  String get resetConfirmContent => 'ハイスコアとテーマがすべて削除されます。元に戻せません。';

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
  String get tutorialStep2 => '行や列を埋めてクリア';

  @override
  String get tutorialStep3 => 'ハンマーでブロックを破壊';

  @override
  String get tutorialStep4 => 'スペースをなくさないで！';

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
  String get endSession => '終了';

  @override
  String get findingRival => '対戦相手を探しています...';

  @override
  String matchmakingError(String error) {
    return 'マッチングエラー：$error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => '消去ライン数';

  @override
  String get maxCombo => '最大コンボ';

  @override
  String get blocksPlaced => '配置したブロック';

  @override
  String get playTime => 'プレイ時間';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

  @override
  String get easyMode => 'イージー';

  @override
  String get memoryMode => 'メモリー';

  @override
  String get classicMode => 'クラシック';

  @override
  String get masterMode => 'マスター';

  @override
  String get zenMode => 'ゼン';

  @override
  String get survivalMode => 'サバイバル';

  @override
  String get pvpMode => 'PvPバトル';

  @override
  String get practiceMode => '練習';

  @override
  String get skip => 'スキップ';

  @override
  String get next => '次へ';

  @override
  String get start => 'スタート！';

  @override
  String get stats => '統計';

  @override
  String get achievements => '実績';

  @override
  String get music => '音楽';

  @override
  String get themes => 'テーマ';

  @override
  String get language => '言語';

  @override
  String get chooseLanguage => '言語を選択';

  @override
  String get autoDevice => '自動（デバイス）';

  @override
  String get data => 'データ';

  @override
  String best(int score) {
    return 'ベスト：$score';
  }

  @override
  String get easyDesc => '小さいグリッド、小さいブロック多数';

  @override
  String get classicDesc => '行が上昇、素早くクリア！';

  @override
  String get masterDesc => '自動ドロップ、スピード！';

  @override
  String get memoryDesc => 'ブロックが消える、位置を覚えて';

  @override
  String get zenDesc => 'リラックス、負けなし';

  @override
  String get pvpDesc => '2分間の1対1バトル';

  @override
  String get pvpRankedSubtitle => 'リアルプレイヤーとランダムマッチ';

  @override
  String get pvpPracticeSubtitle => 'BOTとソロプレイ・ランク無し';

  @override
  String get soloPvp => 'ソロPvP';

  @override
  String gridInfo(int size) {
    return '$size×$size グリッド • 2分';
  }

  @override
  String get dailyChallenge => 'デイリーチャレンジ';

  @override
  String get dailyChallengeSubtitle => '毎日新しい挑戦！';

  @override
  String get streak => '連勝';

  @override
  String get completed => '完了';

  @override
  String get play => 'プレイ';

  @override
  String get noConnection => '接続なし';

  @override
  String get tetEffects => '正月エフェクト';

  @override
  String get pause => '一時停止';

  @override
  String get resume => '再開';

  @override
  String get quit => '終了';

  @override
  String get paused => '一時停止中';

  @override
  String get newFeatures => '新機能';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

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
