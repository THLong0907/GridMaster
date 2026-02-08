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
  String get highScore => 'उच्च स्कोर';

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
      'यह आपके उच्च स्कोर और अनलॉक की गई थीम को हटा देगा। यह पूर्ववत नहीं किया जा सकता।';

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
  String get emptyLeaderboard => 'अभी तक कोई स्कोर नहीं!';

  @override
  String get tutorialTitle => 'कैसे खेलें';

  @override
  String get tutorialStep1 => 'ब्लॉक को ग्रिड पर खींचें';

  @override
  String get tutorialStep2 => 'पंक्ति या स्तंभ भरकर साफ करें';

  @override
  String get tutorialStep3 => 'हथौड़े से ब्लॉक तोड़ें';

  @override
  String get tutorialStep4 => 'जगह खत्म न होने दें!';

  @override
  String get clear => 'क्लियर!';

  @override
  String get doubleClear => 'डबल क्लियर!';

  @override
  String get tripleClear => 'ट्रिपल क्लियर!';

  @override
  String megaClear(int count) {
    return 'मेगा क्लियर! x$count';
  }

  @override
  String get memoryReveal => '👁️ मेमोरी रिवील!';

  @override
  String get zenClear => '🧘 ज़ेन क्लियर!';

  @override
  String autoHammer(int count) {
    return '🔨 ऑटो हैमर! ($count सेल)';
  }

  @override
  String get risingRow => '⬆️ राइज़िंग रो!';

  @override
  String get autoDrop => '⏰ ऑटो ड्रॉप!';

  @override
  String get endSession => 'सत्र समाप्त';

  @override
  String get findingRival => 'प्रतिद्वंद्वी ढूंढ रहे हैं...';

  @override
  String matchmakingError(String error) {
    return 'मैचमेकिंग त्रुटि: $error';
  }

  @override
  String get zenSummaryTitle => 'ज़ेन सत्र';

  @override
  String get totalLines => 'क्लियर लाइनें';

  @override
  String get maxCombo => 'अधिकतम कॉम्बो';

  @override
  String get blocksPlaced => 'रखे गए ब्लॉक';

  @override
  String get playTime => 'खेल समय';

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
  String get pvpMode => 'पीवीपी बैटल';

  @override
  String get practiceMode => 'अभ्यास';

  @override
  String get skip => 'छोड़ें';

  @override
  String get next => 'अगला';

  @override
  String get start => 'शुरू!';
}
