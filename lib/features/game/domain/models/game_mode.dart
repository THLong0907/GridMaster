/// Game mode definitions for Grid Master
enum GameMode {
  easy,
  classic,
  master,
  memory,
  zen;

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
    }
  }

  /// Short description
  String get description {
    switch (this) {
      case GameMode.easy:
        return 'Lưới nhỏ, khối nhỏ nhiều';
      case GameMode.classic:
        return 'Gameplay cân bằng';
      case GameMode.master:
        return 'Lưới lớn, thử thách';
      case GameMode.memory:
        return 'Khối biến mất, nhớ vị trí';
      case GameMode.zen:
        return 'Thư giãn, không thua';
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
    }
  }

  /// Parse from string
  static GameMode fromString(String s) {
    return GameMode.values.firstWhere(
      (m) => m.name == s,
      orElse: () => GameMode.easy,
    );
  }
}
