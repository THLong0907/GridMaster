import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Global locale manager with persistence
class LocaleProvider extends ChangeNotifier {
  LocaleProvider._();
  static final LocaleProvider instance = LocaleProvider._();

  Locale? _locale; // null = follow device

  Locale? get locale => _locale;

  /// Map of language code → display name (native)
  static const Map<String, String> supportedLanguages = {
    'en': 'English',
    'vi': 'Tiếng Việt',
    'zh': '中文',
    'ja': '日本語',
    'ko': '한국어',
    'hi': 'हिन्दी',
    'th': 'ภาษาไทย',
    'id': 'Bahasa Indonesia',
    'ms': 'Bahasa Melayu',
    'fil': 'Filipino',
    'fr': 'Français',
    'de': 'Deutsch',
    'es': 'Español',
    'pt': 'Português',
    'it': 'Italiano',
    'ru': 'Русский',
    'pl': 'Polski',
    'nl': 'Nederlands',
    'tr': 'Türkçe',
    'uk': 'Українська',
    'ar': 'العربية',
    'fa': 'فارسی',
    'he': 'עברית',
    'bn': 'বাংলা',
    'sw': 'Kiswahili',
  };

  /// Flag emojis for each language
  static const Map<String, String> languageFlags = {
    'en': '🇬🇧',
    'vi': '🇻🇳',
    'zh': '🇨🇳',
    'ja': '🇯🇵',
    'ko': '🇰🇷',
    'hi': '🇮🇳',
    'th': '🇹🇭',
    'id': '🇮🇩',
    'ms': '🇲🇾',
    'fil': '🇵🇭',
    'fr': '🇫🇷',
    'de': '🇩🇪',
    'es': '🇪🇸',
    'pt': '🇧🇷',
    'it': '🇮🇹',
    'ru': '🇷🇺',
    'pl': '🇵🇱',
    'nl': '🇳🇱',
    'tr': '🇹🇷',
    'uk': '🇺🇦',
    'ar': '🇸🇦',
    'fa': '🇮🇷',
    'he': '🇮🇱',
    'bn': '🇧🇩',
    'sw': '🇰🇪',
  };

  /// Load saved locale preference
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('app_locale');
    if (code != null && supportedLanguages.containsKey(code)) {
      _locale = Locale(code);
    }
  }

  /// Set and persist locale; null = follow device
  Future<void> setLocale(Locale? locale) async {
    _locale = locale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.remove('app_locale');
    } else {
      await prefs.setString('app_locale', locale.languageCode);
    }
  }

  /// Get display name for current locale
  String get currentLanguageName {
    if (_locale == null) return 'Auto';
    return supportedLanguages[_locale!.languageCode] ?? 'Auto';
  }
}
