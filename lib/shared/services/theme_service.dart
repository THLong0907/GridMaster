import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Block theme definition
class BlockTheme {
  final String id;
  final String name;
  final IconData icon;
  final List<Color> blockColors;
  final Color gridBg;
  final Color accentColor;

  const BlockTheme({
    required this.id,
    required this.name,
    required this.icon,
    required this.blockColors,
    required this.gridBg,
    required this.accentColor,
  });
}

/// Theme service — manages available block themes and selection
class ThemeService {
  ThemeService._();
  static final instance = ThemeService._();

  int _selectedIndex = 0;

  static const List<BlockTheme> themes = [
    BlockTheme(
      id: 'classic',
      name: 'Classic',
      icon: Icons.sports_esports_rounded,
      blockColors: [
        Color(0xFF6C5CE7), Color(0xFF00B894), Color(0xFFFDCB6E),
        Color(0xFFE17055), Color(0xFF0984E3), Color(0xFFD63031),
        Color(0xFFE84393), Color(0xFF00CEC9),
      ],
      gridBg: Color(0xFF1A1A2E),
      accentColor: Color(0xFF6C5CE7),
    ),
    BlockTheme(
      id: 'neon',
      name: 'Neon',
      icon: Icons.flash_on_rounded,
      blockColors: [
        Color(0xFFFF006E), Color(0xFF8338EC), Color(0xFF3A86FF),
        Color(0xFFFF006E), Color(0xFFFB5607), Color(0xFFFFBE0B),
        Color(0xFF06D6A0), Color(0xFF118AB2),
      ],
      gridBg: Color(0xFF0A0A1A),
      accentColor: Color(0xFFFF006E),
    ),
    BlockTheme(
      id: 'ocean',
      name: 'Ocean',
      icon: Icons.water_rounded,
      blockColors: [
        Color(0xFF0077B6), Color(0xFF00B4D8), Color(0xFF90E0EF),
        Color(0xFF48CAE4), Color(0xFF023E8A), Color(0xFF0096C7),
        Color(0xFFADE8F4), Color(0xFF0077B6),
      ],
      gridBg: Color(0xFF03045E),
      accentColor: Color(0xFF00B4D8),
    ),
    BlockTheme(
      id: 'sunset',
      name: 'Sunset',
      icon: Icons.wb_twilight_rounded,
      blockColors: [
        Color(0xFFFF6B35), Color(0xFFF7C59F), Color(0xFFFFBF69),
        Color(0xFFFF006E), Color(0xFFCB997E), Color(0xFFD4A373),
        Color(0xFFE63946), Color(0xFFF4A261),
      ],
      gridBg: Color(0xFF1A0A2E),
      accentColor: Color(0xFFFF6B35),
    ),
    BlockTheme(
      id: 'forest',
      name: 'Forest',
      icon: Icons.park_rounded,
      blockColors: [
        Color(0xFF2D6A4F), Color(0xFF40916C), Color(0xFF52B788),
        Color(0xFF74C69D), Color(0xFF95D5B2), Color(0xFF1B4332),
        Color(0xFFB7E4C7), Color(0xFF3A5A40),
      ],
      gridBg: Color(0xFF081C15),
      accentColor: Color(0xFF52B788),
    ),
    BlockTheme(
      id: 'candy',
      name: 'Candy',
      icon: Icons.cake_rounded,
      blockColors: [
        Color(0xFFFF69B4), Color(0xFFBA55D3), Color(0xFF87CEEB),
        Color(0xFFFFB6C1), Color(0xFFDDA0DD), Color(0xFFFFC0CB),
        Color(0xFFE6E6FA), Color(0xFFFF1493),
      ],
      gridBg: Color(0xFF1A0020),
      accentColor: Color(0xFFFF69B4),
    ),
  ];

  int get selectedIndex => _selectedIndex;
  BlockTheme get currentTheme => themes[_selectedIndex];

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedIndex = prefs.getInt('block_theme_index') ?? 0;
    if (_selectedIndex >= themes.length) _selectedIndex = 0;
  }

  Future<void> setTheme(int index) async {
    if (index < 0 || index >= themes.length) return;
    _selectedIndex = index;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('block_theme_index', index);
  }
}
