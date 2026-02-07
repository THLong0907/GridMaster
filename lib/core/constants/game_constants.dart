/// Game-wide constants for Grid Master
class GameConstants {
  GameConstants._();

  // Grid
  static const int gridSize = 10;
  static const int totalCells = gridSize * gridSize; // 100

  // Scoring
  static const int basePointsPerCell = 10;
  static const double singleClearMultiplier = 1.0;
  static const double doubleClearMultiplier = 2.5;
  static const double tripleClearMultiplier = 5.0;

  /// Multiplier for clearing more than 3 lines at once
  static double getClearMultiplier(int linesCleared) {
    switch (linesCleared) {
      case 0:
        return 0;
      case 1:
        return singleClearMultiplier;
      case 2:
        return doubleClearMultiplier;
      case 3:
        return tripleClearMultiplier;
      default:
        return tripleClearMultiplier + (linesCleared - 3) * 2.0;
    }
  }

  // Streak multipliers
  static const List<double> streakMultipliers = [
    1.0, // streak 0 (no streak)
    1.0, // streak 1
    1.5, // streak 2
    2.0, // streak 3
    3.0, // streak 4
    4.0, // streak 5+
  ];

  static double getStreakMultiplier(int streak) {
    if (streak >= streakMultipliers.length) {
      return streakMultipliers.last;
    }
    return streakMultipliers[streak];
  }

  // Pieces
  static const int piecesPerRound = 3;

  // Rendering
  static const double cellBorderRadius = 4.0;
  static const double gridPadding = 8.0;
  static const double fingerOffset = 40.0; // pixels above touch point
  static const double ghostOpacity = 0.3;

  // Hammer (power-up)
  static const int hammerRadius = 3; // 3x3 area
  static const int hammerScoreCost = 100; // score cost to use hammer
  static const int maxHammerCharges = 3; // max hammers per game
}
