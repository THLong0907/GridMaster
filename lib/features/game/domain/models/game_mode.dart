/// Game mode definitions for Grid Master
enum GameMode {
  easy,
  classic,
  master,
  memory,
  zen,
  soloPvP;

  /// Display name
  String get displayName {
    switch (this) {
      case GameMode.easy:
        return 'Easy';
      case GameMode.classic:
        return 'Classic';
      case GameMode.master:
        return 'Master';
      case GameMode.memory:
        return 'Memory';
      case GameMode.zen:
        return 'Zen';
      case GameMode.soloPvP:
        return 'Solo PvP';
    }
  }

  /// Grid size for this mode
  int get gridSize {
    switch (this) {
      case GameMode.easy:
        return 8;
      case GameMode.classic:
        return 10;
      case GameMode.master:
        return 12;
      case GameMode.memory:
        return 8;
      case GameMode.zen:
        return 8;
      case GameMode.soloPvP:
        return 8;
    }
  }

  /// Number of hammer charges
  int get hammerCharges {
    switch (this) {
      case GameMode.easy:
        return 3;
      case GameMode.classic:
        return 3;
      case GameMode.master:
        return 5;
      case GameMode.memory:
        return 3;
      case GameMode.zen:
        return 0; // No hammer in zen
      case GameMode.soloPvP:
        return 0; // No hammer in PvP
    }
  }

  /// Short description
  String get description {
    switch (this) {
      case GameMode.easy:
        return 'Lưới nhỏ, khối nhỏ nhiều';
      case GameMode.classic:
        return 'Hàng dâng lên, phá nhanh!';
      case GameMode.master:
        return 'Khối tự đặt, tốc độ!';
      case GameMode.memory:
        return 'Khối biến mất, nhớ vị trí';
      case GameMode.zen:
        return 'Thư giãn, không thua';
      case GameMode.soloPvP:
        return 'Đấu 1v1 trong 2 phút';
    }
  }

  /// Emoji icon
  String get icon {
    switch (this) {
      case GameMode.easy:
        return '🟢';
      case GameMode.classic:
        return '🟡';
      case GameMode.master:
        return '🔴';
      case GameMode.memory:
        return '🧠';
      case GameMode.zen:
        return '🧘';
      case GameMode.soloPvP:
        return '👑';
    }
  }

  /// Rising row interval (pieces placed before a row rises)
  /// Only used for Classic mode
  int get risingRowInterval => this == GameMode.classic ? 10 : 0;

  /// Number of gaps in rising rows
  int get risingRowGaps => this == GameMode.classic ? 3 : 0;

  /// Timer drop seconds for each piece
  /// Only used for Master mode
  double get timerDropSeconds => this == GameMode.master ? 8.0 : 0;

  /// Parse from string
  static GameMode fromString(String s) {
    return GameMode.values.firstWhere(
      (m) => m.name == s,
      orElse: () => GameMode.easy,
    );
  }
}
