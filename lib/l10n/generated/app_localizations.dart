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
  /// **'👁️ Memory Reveal!'**
  String get memoryReveal;

  /// No description provided for @zenClear.
  ///
  /// In en, this message translates to:
  /// **'🧘 Zen Clear!'**
  String get zenClear;

  /// No description provided for @autoHammer.
  ///
  /// In en, this message translates to:
  /// **'🔨 Auto Hammer! ({count} cells)'**
  String autoHammer(int count);

  /// No description provided for @risingRow.
  ///
  /// In en, this message translates to:
  /// **'⬆️ Rising Row!'**
  String get risingRow;

  /// No description provided for @autoDrop.
  ///
  /// In en, this message translates to:
  /// **'⏰ Auto Drop!'**
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
  /// **'Zen Session'**
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
