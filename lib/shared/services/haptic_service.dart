import 'package:flutter/services.dart';

/// Haptic feedback helper for game events
class HapticService {
  HapticService._();

  /// Light tap — when piece is picked up
  static void lightTap() {
    HapticFeedback.lightImpact();
  }

  /// Medium tap — when piece is placed on grid
  static void piecePlaced() {
    HapticFeedback.mediumImpact();
  }

  /// Heavy tap — when lines are cleared
  static void lineClear() {
    HapticFeedback.heavyImpact();
  }

  /// Selection click — when hovering over valid position
  static void selectionClick() {
    HapticFeedback.selectionClick();
  }

  /// Triple vibration — for triple clear / combo
  static Future<void> tripleClear() async {
    HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    HapticFeedback.heavyImpact();
  }

  /// Error vibration — for hammer use or invalid action
  static void error() {
    HapticFeedback.vibrate();
  }
}
