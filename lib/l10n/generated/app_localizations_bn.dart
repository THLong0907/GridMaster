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
  String get settings => 'সেটিংস';

  @override
  String get sound => 'শব্দ';

  @override
  String get haptics => 'কম্পন';

  @override
  String get resetProgress => 'অগ্রগতি রিসেট';

  @override
  String get resetConfirmTitle => 'রিসেট করবেন?';

  @override
  String get resetConfirmContent =>
      'আপনার উচ্চ স্কোর এবং আনলক করা থিম মুছে যাবে। এটি পূর্বাবস্থায় ফেরানো যাবে না।';

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
  String get tutorialStep1 => 'ব্লকগুলো গ্রিডে টানুন';

  @override
  String get tutorialStep2 => 'সারি বা কলাম পূরণ করে ক্লিয়ার করুন';

  @override
  String get tutorialStep3 => 'হাতুড়ি দিয়ে ব্লক ভাঙুন';

  @override
  String get tutorialStep4 => 'জায়গা ফুরিয়ে যেতে দেবেন না!';

  @override
  String get clear => 'ক্লিয়ার!';

  @override
  String get doubleClear => 'ডাবল ক্লিয়ার!';

  @override
  String get tripleClear => 'ট্রিপল ক্লিয়ার!';

  @override
  String megaClear(int count) {
    return 'মেগা ক্লিয়ার! x$count';
  }

  @override
  String get memoryReveal => '👁️ মেমরি রিভিল!';

  @override
  String get zenClear => '🧘 জেন ক্লিয়ার!';

  @override
  String autoHammer(int count) {
    return '🔨 অটো হাতুড়ি! ($count সেল)';
  }

  @override
  String get risingRow => '⬆️ উঠন্ত সারি!';

  @override
  String get autoDrop => '⏰ অটো ড্রপ!';

  @override
  String get endSession => 'সেশন শেষ';

  @override
  String get findingRival => 'প্রতিদ্বন্দ্বী খুঁজছি...';

  @override
  String matchmakingError(String error) {
    return 'ম্যাচমেকিং ত্রুটি: $error';
  }

  @override
  String get zenSummaryTitle => 'জেন সেশন';

  @override
  String get totalLines => 'ক্লিয়ার করা লাইন';

  @override
  String get maxCombo => 'সর্বোচ্চ কম্বো';

  @override
  String get blocksPlaced => 'রাখা ব্লক';

  @override
  String get playTime => 'খেলার সময়';

  @override
  String get easyMode => 'সহজ';

  @override
  String get memoryMode => 'মেমরি';

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
  String get skip => 'এড়িয়ে যান';

  @override
  String get next => 'পরবর্তী';

  @override
  String get start => 'শুরু!';
}
