import 'package:go_router/go_router.dart';
import 'package:grid_master/features/game/domain/models/game_mode.dart';
import '../features/lobby/presentation/screens/lobby_screen.dart';
import '../features/game/presentation/screens/game_screen.dart';

/// App-wide routing configuration
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LobbyScreen()),
    GoRoute(
      path: '/game/:mode',
      builder: (context, state) {
        final modeName = state.pathParameters['mode'] ?? 'easy';
        final mode = GameMode.fromString(modeName);
        return GameScreen(mode: mode);
      },
    ),
  ],
);
