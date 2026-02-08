import 'package:go_router/go_router.dart';
import 'package:grid_master/features/game/domain/models/game_mode.dart';
import '../features/lobby/presentation/screens/lobby_screen.dart';
import '../features/game/presentation/screens/game_screen.dart';
import '../features/lobby/presentation/screens/leaderboard_screen.dart';
import '../features/settings/presentation/screens/settings_screen.dart';

/// App-wide routing configuration
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LobbyScreen()),
    GoRoute(
      path: '/leaderboard',
      builder: (context, state) => const LeaderboardScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/game/:mode',
      builder: (context, state) {
        final modeName = state.pathParameters['mode'] ?? 'easy';
        final mode = GameMode.fromString(modeName);
        final isPractice = state.uri.queryParameters['practice'] == 'true';
        return GameScreen(mode: mode, isPractice: isPractice);
      },
    ),
  ],
);
