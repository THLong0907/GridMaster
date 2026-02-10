import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grid_master/features/game/domain/models/game_mode.dart';
import '../features/splash/presentation/screens/splash_screen.dart';
import '../features/lobby/presentation/screens/lobby_screen.dart';
import '../features/game/presentation/screens/game_screen.dart';
import '../features/lobby/presentation/screens/leaderboard_screen.dart';
import '../features/settings/presentation/screens/settings_screen.dart';
import '../features/settings/presentation/screens/stats_screen.dart';
import '../features/settings/presentation/screens/achievements_screen.dart';
import '../features/settings/presentation/screens/privacy_policy_screen.dart';
import '../features/settings/presentation/screens/features_guide_screen.dart';

/// Smooth slide-up + fade transition for navigating to sub-pages
CustomTransitionPage<void> _slideUpPage(Widget child, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final offsetTween = Tween<Offset>(
        begin: const Offset(0.0, 0.08),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeOutCubic));
      final fadeTween = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).chain(CurveTween(curve: Curves.easeOut));
      return FadeTransition(
        opacity: animation.drive(fadeTween),
        child: SlideTransition(
          position: animation.drive(offsetTween),
          child: child,
        ),
      );
    },
  );
}

/// Scale + fade transition for game screen (zoom-in feel)
CustomTransitionPage<void> _scaleUpPage(Widget child, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 350),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final scaleTween = Tween<double>(
        begin: 0.92,
        end: 1.0,
      ).chain(CurveTween(curve: Curves.easeOutCubic));
      final fadeTween = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).chain(CurveTween(curve: Curves.easeOut));
      return FadeTransition(
        opacity: animation.drive(fadeTween),
        child: ScaleTransition(
          scale: animation.drive(scaleTween),
          child: child,
        ),
      );
    },
  );
}

/// App-wide routing configuration
final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => _slideUpPage(const LobbyScreen(), state),
    ),
    GoRoute(
      path: '/leaderboard',
      pageBuilder: (context, state) =>
          _slideUpPage(const LeaderboardScreen(), state),
    ),
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) =>
          _slideUpPage(const SettingsScreen(), state),
    ),
    GoRoute(
      path: '/stats',
      pageBuilder: (context, state) => _slideUpPage(const StatsScreen(), state),
    ),
    GoRoute(
      path: '/achievements',
      pageBuilder: (context, state) =>
          _slideUpPage(const AchievementsScreen(), state),
    ),
    GoRoute(
      path: '/privacy',
      pageBuilder: (context, state) =>
          _slideUpPage(const PrivacyPolicyScreen(), state),
    ),
    GoRoute(
      path: '/features',
      pageBuilder: (context, state) =>
          _slideUpPage(const FeaturesGuideScreen(), state),
    ),
    GoRoute(
      path: '/game/:mode',
      pageBuilder: (context, state) {
        final modeName = state.pathParameters['mode'] ?? 'easy';
        final mode = GameMode.fromString(modeName);
        final isPractice = state.uri.queryParameters['practice'] == 'true';
        return _scaleUpPage(
          GameScreen(mode: mode, isPractice: isPractice),
          state,
        );
      },
    ),
  ],
);
