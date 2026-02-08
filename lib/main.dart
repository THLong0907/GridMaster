import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'shared/services/auth_service.dart';
import 'shared/services/audio_service.dart';
import 'routes/app_router.dart';
import 'core/constants/strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Sign in anonymously to identify the player
    await AuthService.signInAnonymously();
  } catch (e) {
    print('Firebase initialization failed (check config): $e');
  }

  // Initialize Audio
  await AudioService.instance.init();

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

  runApp(const GridMasterApp());
}

class GridMasterApp extends StatelessWidget {
  const GridMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: GameStrings.appName,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
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
