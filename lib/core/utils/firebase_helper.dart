import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';

/// Helper class to safely wrap Firebase operations.
/// Provides a global [isAvailable] flag and a [runIfOnline] method
/// that silently catches Firebase/network errors.
class FirebaseHelper {
  FirebaseHelper._();

  /// Whether Firebase was successfully initialized
  static bool isAvailable = false;

  /// Safely execute a Firebase operation.
  /// Returns the result of [action] if Firebase is available and the call succeeds.
  /// Returns [fallback] if Firebase is unavailable or the call fails.
  static Future<T> runIfOnline<T>(
    Future<T> Function() action, {
    required T fallback,
  }) async {
    if (!isAvailable) return fallback;
    try {
      return await action();
    } on FirebaseException catch (e) {
      debugPrint('[FirebaseHelper] Firebase error: ${e.message}');
      return fallback;
    } catch (e) {
      debugPrint('[FirebaseHelper] Network error: $e');
      return fallback;
    }
  }

  /// Fire-and-forget version for void operations (stats, analytics, etc.)
  static Future<void> runIfOnlineVoid(Future<void> Function() action) async {
    if (!isAvailable) return;
    try {
      await action();
    } on FirebaseException catch (e) {
      debugPrint('[FirebaseHelper] Firebase error: ${e.message}');
    } catch (e) {
      debugPrint('[FirebaseHelper] Network error: $e');
    }
  }
}
