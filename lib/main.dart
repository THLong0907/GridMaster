import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:grid_master/l10n/generated/app_localizations.dart';
import 'firebase_options.dart';
import 'shared/services/auth_service.dart';
import 'shared/services/audio_service.dart';
import 'shared/services/locale_provider.dart';
import 'shared/services/theme_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'routes/app_router.dart';
import 'core/constants/strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Only await locale (fast, needed for first frame)
  await LocaleProvider.instance.init();

  // Lock to portrait mode (game works best in portrait)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0D0D1A),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Initialize Firebase before runApp (required for Auth/Firestore access)
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Enable analytics
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    await AuthService.signInAnonymously();
  } catch (e) {
    debugPrint('Firebase init failed: $e');
  }

  // Initialize lightweight services before runApp
  await ThemeService.instance.init();

  // Launch app
  runApp(const GridMasterApp());

  // Defer audio initialization to after first frame
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await AudioService.instance.init();
  });
}

class GridMasterApp extends StatefulWidget {
  const GridMasterApp({super.key});

  @override
  State<GridMasterApp> createState() => _GridMasterAppState();
}

class _GridMasterAppState extends State<GridMasterApp> {
  @override
  void initState() {
    super.initState();
    LocaleProvider.instance.addListener(_onLocaleChanged);
  }

  @override
  void dispose() {
    LocaleProvider.instance.removeListener(_onLocaleChanged);
    super.dispose();
  }

  void _onLocaleChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      locale: LocaleProvider.instance.locale, // null = follow device
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('vi'),
        Locale('zh'),
        Locale('ja'),
        Locale('ko'),
        Locale('hi'),
        Locale('th'),
        Locale('id'),
        Locale('ms'),
        Locale('fil'),
        Locale('fr'),
        Locale('de'),
        Locale('es'),
        Locale('pt'),
        Locale('it'),
        Locale('ru'),
        Locale('pl'),
        Locale('nl'),
        Locale('tr'),
        Locale('uk'),
        Locale('ar'),
        Locale('fa'),
        Locale('he'),
        Locale('bn'),
        Locale('sw'),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (final supported in supportedLocales) {
          if (supported.languageCode == locale?.languageCode) {
            return supported;
          }
        }
        return const Locale('en'); // Fallback to English
      },
      title: GameStrings.appName,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0D1A),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C5CE7),
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.fredokaTextTheme(ThemeData.dark().textTheme),
      ),
    );
  }
}
