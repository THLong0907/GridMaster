import 'package:flutter/material.dart';

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

  /// Material icon for this mode
  IconData get iconData {
    switch (this) {
      case GameMode.easy:
        return Icons.grid_on_rounded;
      case GameMode.classic:
        return Icons.trending_up_rounded;
      case GameMode.master:
        return Icons.speed_rounded;
      case GameMode.memory:
        return Icons.psychology_rounded;
      case GameMode.zen:
        return Icons.self_improvement_rounded;
      case GameMode.soloPvP:
        return Icons.sports_esports_rounded;
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

