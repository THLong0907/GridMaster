import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service to handle player identity and authentication
class AuthService {
  AuthService._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static const String _userNameKey = 'player_display_name';

  /// Ensure the user is signed in anonymously
  static Future<User?> signInAnonymously() async {
    try {
      final userCredential = await _auth.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      debugPrint('Firebase Auth Error: $e');
      return null;
    }
  }

  /// Get current user ID
  static String? get uid => _auth.currentUser?.uid;

  /// Get saved display name or use a default one
  static Future<String> getDisplayName() async {
    final prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString(_userNameKey);
    if (savedName != null && savedName.isNotEmpty) {
      return savedName;
    }

    // Default name based on UID if no name saved
    final id = uid ?? 'Unknown';
    final shortId = id.length > 5 ? id.substring(0, 5) : id;
    return 'Player_$shortId';
  }

  /// Save display name
  static Future<void> setDisplayName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, name);

    // Also update Firebase profile if needed (optional but good)
    try {
      await _auth.currentUser?.updateDisplayName(name);
    } catch (e) {
      debugPrint('Failed to update display name in Firebase: $e');
    }
  }
}
