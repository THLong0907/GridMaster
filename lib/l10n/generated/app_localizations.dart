import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fil.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_he.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sw.dart';
import 'app_localizations_th.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('bn'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fil'),
    Locale('fr'),
    Locale('he'),
    Locale('hi'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('ms'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ru'),
    Locale('sw'),
    Locale('th'),
    Locale('tr'),
    Locale('uk'),
    Locale('vi'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Grid Master'**
  String get appTitle;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'SCORE'**
  String get score;

  /// No description provided for @highScore.
  ///
  /// In en, this message translates to:
  /// **'HIGH SCORE'**
  String get highScore;

  /// No description provided for @gameOver.
  ///
  /// In en, this message translates to:
  /// **'GAME OVER'**
  String get gameOver;

  /// No description provided for @newHighScore.
  ///
  /// In en, this message translates to:
  /// **'NEW HIGH SCORE!'**
  String get newHighScore;

  /// No description provided for @playAgain.
  ///
  /// In en, this message translates to:
  /// **'PLAY AGAIN'**
  String get playAgain;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'HOME'**
  String get home;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'SHARE'**
  String get share;

  /// No description provided for @restart.
  ///
  /// In en, this message translates to:
  /// **'RESTART'**
  String get restart;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @sound.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get sound;

  /// No description provided for @haptics.
  ///
  /// In en, this message translates to:
  /// **'Haptics'**
  String get haptics;

  /// No description provided for @resetProgress.
  ///
  /// In en, this message translates to:
  /// **'Reset Progress'**
  String get resetProgress;

  /// No description provided for @resetConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Progress?'**
  String get resetConfirmTitle;

  /// No description provided for @resetConfirmContent.
  ///
  /// In en, this message translates to:
  /// **'This will delete your high scores and unlocked themes. This cannot be undone.'**
  String get resetConfirmContent;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @changeName.
  ///
  /// In en, this message translates to:
  /// **'Change Display Name'**
  String get changeName;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterName;

  /// No description provided for @leaderboard.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get leaderboard;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @emptyLeaderboard.
  ///
  /// In en, this message translates to:
  /// **'No scores yet!'**
  String get emptyLeaderboard;

  /// No description provided for @tutorialTitle.
  ///
  /// In en, this message translates to:
  /// **'How to Play'**
  String get tutorialTitle;

  /// No description provided for @tutorialStep1.
  ///
  /// In en, this message translates to:
  /// **'Drag blocks to the grid'**
  String get tutorialStep1;

  /// No description provided for @tutorialStep2.
  ///
  /// In en, this message translates to:
  /// **'Fill rows or columns to clear'**
  String get tutorialStep2;

  /// No description provided for @tutorialStep3.
  ///
  /// In en, this message translates to:
  /// **'Use hammers to break blocks'**
  String get tutorialStep3;

  /// No description provided for @tutorialStep4.
  ///
  /// In en, this message translates to:
  /// **'Don\'t run out of space!'**
  String get tutorialStep4;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear!'**
  String get clear;

  /// No description provided for @doubleClear.
  ///
  /// In en, this message translates to:
  /// **'Double Clear!'**
  String get doubleClear;

  /// No description provided for @tripleClear.
  ///
  /// In en, this message translates to:
  /// **'TRIPLE CLEAR!'**
  String get tripleClear;

  /// No description provided for @megaClear.
  ///
  /// In en, this message translates to:
  /// **'MEGA CLEAR! x{count}'**
  String megaClear(int count);

  /// No description provided for @memoryReveal.
  ///
  /// In en, this message translates to:
  /// **'Memory Reveal!'**
  String get memoryReveal;

  /// No description provided for @zenClear.
  ///
  /// In en, this message translates to:
  /// **'Zen Clear!'**
  String get zenClear;

  /// No description provided for @autoHammer.
  ///
  /// In en, this message translates to:
  /// **'Auto Hammer! ({count} cells)'**
  String autoHammer(int count);

  /// No description provided for @risingRow.
  ///
  /// In en, this message translates to:
  /// **'Rising Row!'**
  String get risingRow;

  /// No description provided for @autoDrop.
  ///
  /// In en, this message translates to:
  /// **'Auto Drop!'**
  String get autoDrop;

  /// No description provided for @endSession.
  ///
  /// In en, this message translates to:
  /// **'End Session'**
  String get endSession;

  /// No description provided for @findingRival.
  ///
  /// In en, this message translates to:
  /// **'FINDING RIVAL...'**
  String get findingRival;

  /// No description provided for @matchmakingError.
  ///
  /// In en, this message translates to:
  /// **'Matchmaking error: {error}'**
  String matchmakingError(String error);

  /// No description provided for @zenSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'ZEN SESSION ENDED'**
  String get zenSummaryTitle;

  /// No description provided for @totalLines.
  ///
  /// In en, this message translates to:
  /// **'Lines Cleared'**
  String get totalLines;

  /// No description provided for @maxCombo.
  ///
  /// In en, this message translates to:
  /// **'Max Combo'**
  String get maxCombo;

  /// No description provided for @blocksPlaced.
  ///
  /// In en, this message translates to:
  /// **'Blocks Placed'**
  String get blocksPlaced;

  /// No description provided for @playTime.
  ///
  /// In en, this message translates to:
  /// **'Play Time'**
  String get playTime;

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueBtn;

  /// No description provided for @backToLobby.
  ///
  /// In en, this message translates to:
  /// **'Back to Lobby'**
  String get backToLobby;

  /// No description provided for @easyMode.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get easyMode;

  /// No description provided for @memoryMode.
  ///
  /// In en, this message translates to:
  /// **'Memory'**
  String get memoryMode;

  /// No description provided for @classicMode.
  ///
  /// In en, this message translates to:
  /// **'Classic'**
  String get classicMode;

  /// No description provided for @masterMode.
  ///
  /// In en, this message translates to:
  /// **'Master'**
  String get masterMode;

  /// No description provided for @zenMode.
  ///
  /// In en, this message translates to:
  /// **'Zen'**
  String get zenMode;

  /// No description provided for @survivalMode.
  ///
  /// In en, this message translates to:
  /// **'Survival'**
  String get survivalMode;

  /// No description provided for @pvpMode.
  ///
  /// In en, this message translates to:
  /// **'PvP Battle'**
  String get pvpMode;

  /// No description provided for @practiceMode.
  ///
  /// In en, this message translates to:
  /// **'Do Practice'**
  String get practiceMode;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'START!'**
  String get start;

  /// No description provided for @stats.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get stats;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @music.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get music;

  /// No description provided for @themes.
  ///
  /// In en, this message translates to:
  /// **'Themes'**
  String get themes;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get chooseLanguage;

  /// No description provided for @autoDevice.
  ///
  /// In en, this message translates to:
  /// **'Auto (Device)'**
  String get autoDevice;

  /// No description provided for @data.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get data;

  /// No description provided for @best.
  ///
  /// In en, this message translates to:
  /// **'Best: {score}'**
  String best(int score);

  /// No description provided for @easyDesc.
  ///
  /// In en, this message translates to:
  /// **'Small grid, many small blocks'**
  String get easyDesc;

  /// No description provided for @classicDesc.
  ///
  /// In en, this message translates to:
  /// **'Rising rows, clear fast!'**
  String get classicDesc;

  /// No description provided for @masterDesc.
  ///
  /// In en, this message translates to:
  /// **'Auto-drop blocks, speed!'**
  String get masterDesc;

  /// No description provided for @memoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Blocks vanish, remember positions'**
  String get memoryDesc;

  /// No description provided for @zenDesc.
  ///
  /// In en, this message translates to:
  /// **'Relax, no lose'**
  String get zenDesc;

  /// No description provided for @pvpDesc.
  ///
  /// In en, this message translates to:
  /// **'1v1 battle in 2 minutes'**
  String get pvpDesc;

  /// No description provided for @pvpRankedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Random match with real players'**
  String get pvpRankedSubtitle;

  /// No description provided for @pvpPracticeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Play solo with BOT • Unranked'**
  String get pvpPracticeSubtitle;

  /// No description provided for @soloPvp.
  ///
  /// In en, this message translates to:
  /// **'Solo PvP'**
  String get soloPvp;

  /// No description provided for @gridInfo.
  ///
  /// In en, this message translates to:
  /// **'{size}×{size} Grid • 2 Minutes'**
  String gridInfo(int size);

  /// No description provided for @dailyChallenge.
  ///
  /// In en, this message translates to:
  /// **'Daily Challenge'**
  String get dailyChallenge;

  /// No description provided for @dailyChallengeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'New challenge every day!'**
  String get dailyChallengeSubtitle;

  /// No description provided for @streak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get streak;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'PLAY'**
  String get play;

  /// No description provided for @noConnection.
  ///
  /// In en, this message translates to:
  /// **'No connection'**
  String get noConnection;

  /// No description provided for @tetEffects.
  ///
  /// In en, this message translates to:
  /// **'Tết Effects'**
  String get tetEffects;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'RESUME'**
  String get resume;

  /// No description provided for @quit.
  ///
  /// In en, this message translates to:
  /// **'QUIT'**
  String get quit;

  /// No description provided for @paused.
  ///
  /// In en, this message translates to:
  /// **'PAUSED'**
  String get paused;

  /// No description provided for @newFeatures.
  ///
  /// In en, this message translates to:
  /// **'New Features'**
  String get newFeatures;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @pvpWin.
  ///
  /// In en, this message translates to:
  /// **'YOU WIN!'**
  String get pvpWin;

  /// No description provided for @pvpLose.
  ///
  /// In en, this message translates to:
  /// **'YOU LOSE'**
  String get pvpLose;

  /// No description provided for @pvpDraw.
  ///
  /// In en, this message translates to:
  /// **'DRAW'**
  String get pvpDraw;

  /// No description provided for @uploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading...'**
  String get uploading;

  /// No description provided for @uploadToLeaderboard.
  ///
  /// In en, this message translates to:
  /// **'Upload to Leaderboard'**
  String get uploadToLeaderboard;

  /// No description provided for @scoreUploaded.
  ///
  /// In en, this message translates to:
  /// **'Score uploaded!'**
  String get scoreUploaded;

  /// No description provided for @uploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Upload failed. Check connection.'**
  String get uploadFailed;

  /// No description provided for @tutorialReset.
  ///
  /// In en, this message translates to:
  /// **'Tutorial will show on next game'**
  String get tutorialReset;

  /// No description provided for @highScoresCleared.
  ///
  /// In en, this message translates to:
  /// **'All high scores cleared'**
  String get highScoresCleared;

  /// No description provided for @botBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get botBeginner;

  /// No description provided for @botPro.
  ///
  /// In en, this message translates to:
  /// **'Professional'**
  String get botPro;

  /// No description provided for @botDestroyer.
  ///
  /// In en, this message translates to:
  /// **'Destroyer'**
  String get botDestroyer;

  /// No description provided for @botGodlike.
  ///
  /// In en, this message translates to:
  /// **'Godlike'**
  String get botGodlike;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @engine.
  ///
  /// In en, this message translates to:
  /// **'Engine'**
  String get engine;

  /// No description provided for @timer.
  ///
  /// In en, this message translates to:
  /// **'TIMER'**
  String get timer;

  /// No description provided for @soundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Game sound effects'**
  String get soundSubtitle;

  /// No description provided for @hapticsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Vibration feedback'**
  String get hapticsSubtitle;

  /// No description provided for @musicSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Background music'**
  String get musicSubtitle;

  /// No description provided for @tetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tết visual effects'**
  String get tetSubtitle;

  /// No description provided for @tutorialSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show tutorial again'**
  String get tutorialSubtitle;

  /// No description provided for @resetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Clear all high scores'**
  String get resetSubtitle;

  /// No description provided for @shareScore.
  ///
  /// In en, this message translates to:
  /// **'SHARE SCORE'**
  String get shareScore;

  /// No description provided for @you.
  ///
  /// In en, this message translates to:
  /// **'YOU'**
  String get you;

  /// No description provided for @rival.
  ///
  /// In en, this message translates to:
  /// **'RIVAL'**
  String get rival;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'bn',
    'de',
    'en',
    'es',
    'fa',
    'fil',
    'fr',
    'he',
    'hi',
    'id',
    'it',
    'ja',
    'ko',
    'ms',
    'nl',
    'pl',
    'pt',
    'ru',
    'sw',
    'th',
    'tr',
    'uk',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'bn':
      return AppLocalizationsBn();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fa':
      return AppLocalizationsFa();
    case 'fil':
      return AppLocalizationsFil();
    case 'fr':
      return AppLocalizationsFr();
    case 'he':
      return AppLocalizationsHe();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'ms':
      return AppLocalizationsMs();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'sw':
      return AppLocalizationsSw();
    case 'th':
      return AppLocalizationsTh();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
