// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'ग्रिड मास्टर';

  @override
  String get score => 'स्कोर';

  @override
  String get highScore => 'उच्चतम स्कोर';

  @override
  String get gameOver => 'गेम ओवर';

  @override
  String get newHighScore => 'नया रिकॉर्ड!';

  @override
  String get playAgain => 'फिर से खेलें';

  @override
  String get home => 'होम';

  @override
  String get share => 'शेयर';

  @override
  String get restart => 'RESTART';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get sound => 'ध्वनि';

  @override
  String get haptics => 'कंपन';

  @override
  String get resetProgress => 'प्रगति रीसेट करें';

  @override
  String get resetConfirmTitle => 'रीसेट करें?';

  @override
  String get resetConfirmContent =>
      'सभी स्कोर और थीम हटा दिए जाएंगे। यह पूर्ववत नहीं किया जा सकता।';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get delete => 'हटाएं';

  @override
  String get save => 'सहेजें';

  @override
  String get changeName => 'नाम बदलें';

  @override
  String get enterName => 'अपना नाम दर्ज करें';

  @override
  String get leaderboard => 'लीडरबोर्ड';

  @override
  String get loading => 'लोड हो रहा है...';

  @override
  String get error => 'त्रुटि';

  @override
  String get emptyLeaderboard => 'अभी कोई स्कोर नहीं!';

  @override
  String get tutorialTitle => 'कैसे खेलें';

  @override
  String get tutorialStep1 => 'ब्लॉक को ग्रिड पर खींचें';

  @override
  String get tutorialStep2 => 'पंक्तियाँ या स्तंभ भरें';

  @override
  String get tutorialStep3 => 'हथौड़े से तोड़ें';

  @override
  String get tutorialStep4 => 'जगह खत्म न होने दें!';

  @override
  String get clear => 'बढ़िया!';

  @override
  String get doubleClear => 'डबल!';

  @override
  String get tripleClear => 'ट्रिपल!';

  @override
  String megaClear(int count) {
    return 'मेगा! x$count';
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
  String get endSession => 'समाप्त';

  @override
  String get findingRival => 'प्रतिद्वंद्वी खोज रहे...';

  @override
  String matchmakingError(String error) {
    return 'मैचमेकिंग त्रुटि: $error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => 'साफ़ की गई लाइनें';

  @override
  String get maxCombo => 'अधिकतम कॉम्बो';

  @override
  String get blocksPlaced => 'रखे गए ब्लॉक';

  @override
  String get playTime => 'खेल का समय';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

  @override
  String get easyMode => 'आसान';

  @override
  String get memoryMode => 'मेमोरी';

  @override
  String get classicMode => 'क्लासिक';

  @override
  String get masterMode => 'मास्टर';

  @override
  String get zenMode => 'ज़ेन';

  @override
  String get survivalMode => 'सर्वाइवल';

  @override
  String get pvpMode => 'PvP लड़ाई';

  @override
  String get practiceMode => 'अभ्यास';

  @override
  String get skip => 'छोड़ें';

  @override
  String get next => 'अगला';

  @override
  String get start => 'शुरू!';

  @override
  String get stats => 'आँकड़े';

  @override
  String get achievements => 'उपलब्धियाँ';

  @override
  String get music => 'संगीत';

  @override
  String get themes => 'थीम';

  @override
  String get language => 'भाषा';

  @override
  String get chooseLanguage => 'भाषा चुनें';

  @override
  String get autoDevice => 'ऑटो (डिवाइस)';

  @override
  String get data => 'डेटा';

  @override
  String best(int score) {
    return 'सर्वश्रेष्ठ: $score';
  }

  @override
  String get easyDesc => 'छोटी ग्रिड, छोटे ब्लॉक';

  @override
  String get classicDesc => 'पंक्तियाँ उठती हैं, जल्दी साफ़ करो!';

  @override
  String get masterDesc => 'ऑटो-ड्रॉप, गति!';

  @override
  String get memoryDesc => 'ब्लॉक गायब, स्थिति याद रखें';

  @override
  String get zenDesc => 'आराम, हारने का डर नहीं';

  @override
  String get pvpDesc => '2 मिनट में 1v1 मुकाबला';

  @override
  String get pvpRankedSubtitle => 'वास्तविक खिलाड़ियों के साथ यादृच्छिक मैच';

  @override
  String get pvpPracticeSubtitle => 'BOT के खिलाफ अकेले खेलें • रैंक नहीं';

  @override
  String get soloPvp => 'सोलो PvP';

  @override
  String gridInfo(int size) {
    return '$size×$size ग्रिड • 2 मिनट';
  }

  @override
  String get dailyChallenge => 'दैनिक चुनौती';

  @override
  String get dailyChallengeSubtitle => 'हर दिन नई चुनौती!';

  @override
  String get streak => 'लगातार';

  @override
  String get completed => 'पूर्ण';

  @override
  String get play => 'खेलें';

  @override
  String get noConnection => 'कोई कनेक्शन नहीं';

  @override
  String get tetEffects => 'नए साल के प्रभाव';

  @override
  String get pause => 'रोकें';

  @override
  String get resume => 'जारी रखें';

  @override
  String get quit => 'बाहर';

  @override
  String get paused => 'रुका हुआ';

  @override
  String get newFeatures => 'नई सुविधाएँ';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

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
