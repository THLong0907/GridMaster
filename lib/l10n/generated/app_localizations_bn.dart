// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'গ্রিড মাস্টার';

  @override
  String get score => 'স্কোর';

  @override
  String get highScore => 'সর্বোচ্চ স্কোর';

  @override
  String get gameOver => 'গেম ওভার';

  @override
  String get newHighScore => 'নতুন রেকর্ড!';

  @override
  String get playAgain => 'আবার খেলুন';

  @override
  String get home => 'হোম';

  @override
  String get share => 'শেয়ার';

  @override
  String get restart => 'RESTART';

  @override
  String get settings => 'সেটিংস';

  @override
  String get sound => 'শব্দ';

  @override
  String get haptics => 'কম্পন';

  @override
  String get resetProgress => 'রিসেট';

  @override
  String get resetConfirmTitle => 'রিসেট করবেন?';

  @override
  String get resetConfirmContent =>
      'সব স্কোর ও থিম মুছে যাবে। পূর্বাবস্থায় ফেরানো যাবে না।';

  @override
  String get cancel => 'বাতিল';

  @override
  String get delete => 'মুছুন';

  @override
  String get save => 'সংরক্ষণ';

  @override
  String get changeName => 'নাম পরিবর্তন';

  @override
  String get enterName => 'আপনার নাম লিখুন';

  @override
  String get leaderboard => 'লিডারবোর্ড';

  @override
  String get loading => 'লোড হচ্ছে...';

  @override
  String get error => 'ত্রুটি';

  @override
  String get emptyLeaderboard => 'এখনো কোনো স্কোর নেই!';

  @override
  String get tutorialTitle => 'কিভাবে খেলবেন';

  @override
  String get tutorialStep1 => 'ব্লক টেনে গ্রিডে আনুন';

  @override
  String get tutorialStep2 => 'সারি বা কলাম পূরণ করুন';

  @override
  String get tutorialStep3 => 'হাতুড়ি দিয়ে ভাঙুন';

  @override
  String get tutorialStep4 => 'জায়গা ফুরিয়ে যাবে না!';

  @override
  String get clear => 'চমৎকার!';

  @override
  String get doubleClear => 'ডাবল!';

  @override
  String get tripleClear => 'ট্রিপল!';

  @override
  String megaClear(int count) {
    return 'মেগা! x$count';
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
  String get endSession => 'শেষ করুন';

  @override
  String get findingRival => 'প্রতিদ্বন্দ্বী খুঁজছে...';

  @override
  String matchmakingError(String error) {
    return 'ম্যাচমেকিং ত্রুটি: $error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => 'মুছে ফেলা লাইন';

  @override
  String get maxCombo => 'সর্বোচ্চ কম্বো';

  @override
  String get blocksPlaced => 'স্থাপিত ব্লক';

  @override
  String get playTime => 'খেলার সময়';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

  @override
  String get easyMode => 'সহজ';

  @override
  String get memoryMode => 'স্মৃতি';

  @override
  String get classicMode => 'ক্লাসিক';

  @override
  String get masterMode => 'মাস্টার';

  @override
  String get zenMode => 'জেন';

  @override
  String get survivalMode => 'সারভাইভাল';

  @override
  String get pvpMode => 'PvP যুদ্ধ';

  @override
  String get practiceMode => 'অনুশীলন';

  @override
  String get skip => 'স্কিপ';

  @override
  String get next => 'পরবর্তী';

  @override
  String get start => 'শুরু!';

  @override
  String get stats => 'পরিসংখ্যান';

  @override
  String get achievements => 'অর্জন';

  @override
  String get music => 'সঙ্গীত';

  @override
  String get themes => 'থিম';

  @override
  String get language => 'ভাষা';

  @override
  String get chooseLanguage => 'ভাষা নির্বাচন';

  @override
  String get autoDevice => 'স্বয়ংক্রিয় (ডিভাইস)';

  @override
  String get data => 'ডাটা';

  @override
  String best(int score) {
    return 'সেরা: $score';
  }

  @override
  String get easyDesc => 'ছোট গ্রিড, ছোট ব্লক';

  @override
  String get classicDesc => 'সারি উঠছে, দ্রুত মুছুন!';

  @override
  String get masterDesc => 'অটো-ড্রপ, গতি!';

  @override
  String get memoryDesc => 'ব্লক অদৃশ্য, অবস্থান মনে রাখুন';

  @override
  String get zenDesc => 'আরাম, হারানো নেই';

  @override
  String get pvpDesc => '2 মিনিটে 1v1 দ্বন্দ্বযুদ্ধ';

  @override
  String get pvpRankedSubtitle => 'আসল খেলোয়াড়দের সাথে র‍্যান্ডম ম্যাচ';

  @override
  String get pvpPracticeSubtitle => 'বটের বিরুদ্ধে একা খেলুন • র‍্যাংক নেই';

  @override
  String get soloPvp => 'একক PvP';

  @override
  String gridInfo(int size) {
    return '$size×$size গ্রিড • 2 মিনিট';
  }

  @override
  String get dailyChallenge => 'দৈনিক চ্যালেঞ্জ';

  @override
  String get dailyChallengeSubtitle => 'প্রতিদিন নতুন চ্যালেঞ্জ!';

  @override
  String get streak => 'ধারাবাহিক';

  @override
  String get completed => 'সম্পন্ন';

  @override
  String get play => 'খেলুন';

  @override
  String get noConnection => 'সংযোগ নেই';

  @override
  String get tetEffects => 'নববর্ষ প্রভাব';

  @override
  String get pause => 'বিরতি';

  @override
  String get resume => 'চালিয়ে যান';

  @override
  String get quit => 'প্রস্থান';

  @override
  String get paused => 'বিরতিতে';

  @override
  String get newFeatures => 'নতুন বৈশিষ্ট্য';

  @override
  String get privacyPolicy => 'গোপনীয়তা নীতি';

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
