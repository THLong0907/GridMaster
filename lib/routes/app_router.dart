import 'package:go_router/go_router.dart';
import '../features/lobby/presentation/screens/lobby_screen.dart';
import '../features/game/presentation/screens/game_screen.dart';

/// App-wide routing configuration
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LobbyScreen()),
    GoRoute(path: '/game', builder: (context, state) => const GameScreen()),
  ],
);
