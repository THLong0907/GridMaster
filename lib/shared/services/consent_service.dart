import 'package:shared_preferences/shared_preferences.dart';

/// Service to track GDPR/privacy consent state.
/// Uses SharedPreferences for persistence.
class ConsentService {
  ConsentService._();

  static const _keyConsented = 'consent_accepted';
  static const _keyTimestamp = 'consent_timestamp';

  /// Check if user has already given/declined consent
  static Future<bool> hasConsented() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_keyConsented);
  }

  /// Check if user accepted (vs declined)
  static Future<bool> isAccepted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyConsented) ?? false;
  }

  /// Save consent decision
  static Future<void> setConsent(bool accepted) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyConsented, accepted);
    await prefs.setString(_keyTimestamp, DateTime.now().toIso8601String());
  }
}
