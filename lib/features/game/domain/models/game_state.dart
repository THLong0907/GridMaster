/// Immutable game state
class GameState {
  final int score;
  final int highScore;
  final int streak;
  final bool isGameOver;

  const GameState({
    this.score = 0,
    this.highScore = 0,
    this.streak = 0,
    this.isGameOver = false,
  });

  GameState copyWith({
    int? score,
    int? highScore,
    int? streak,
    bool? isGameOver,
  }) {
    return GameState(
      score: score ?? this.score,
      highScore: highScore ?? this.highScore,
      streak: streak ?? this.streak,
      isGameOver: isGameOver ?? this.isGameOver,
    );
  }
}
