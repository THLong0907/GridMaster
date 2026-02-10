import 'package:flutter/painting.dart';
import 'package:grid_master/shared/services/theme_service.dart';

/// 8 block colors with glossy palette (main, light, dark, glow)
class BlockColors {
  BlockColors._();

  static const int colorCount = 8;

  // Color indexes (1-based to match grid model where 0 = empty)
  static const int red = 1;
  static const int blue = 2;
  static const int green = 3;
  static const int yellow = 4;
  static const int purple = 5;
  static const int orange = 6;
  static const int cyan = 7;
  static const int pink = 8;

  static const List<BlockColorSet> all = [
    BlockColorSet(
      main: Color(0xFFFF4757),
      light: Color(0xFFFF6B81),
      dark: Color(0xFFC0392B),
      glow: Color(0x66FF4757),
    ),
    BlockColorSet(
      main: Color(0xFF3498DB),
      light: Color(0xFF5DADE2),
      dark: Color(0xFF2471A3),
      glow: Color(0x663498DB),
    ),
    BlockColorSet(
      main: Color(0xFF2ECC71),
      light: Color(0xFF58D68D),
      dark: Color(0xFF1E8449),
      glow: Color(0x662ECC71),
    ),
    BlockColorSet(
      main: Color(0xFFF1C40F),
      light: Color(0xFFF4D03F),
      dark: Color(0xFFB7950B),
      glow: Color(0x66F1C40F),
    ),
    BlockColorSet(
      main: Color(0xFF9B59B6),
      light: Color(0xFFAF7AC5),
      dark: Color(0xFF7D3C98),
      glow: Color(0x669B59B6),
    ),
    BlockColorSet(
      main: Color(0xFFE67E22),
      light: Color(0xFFEB984E),
      dark: Color(0xFFCA6F1E),
      glow: Color(0x66E67E22),
    ),
    BlockColorSet(
      main: Color(0xFF1ABC9C),
      light: Color(0xFF48C9B0),
      dark: Color(0xFF148F77),
      glow: Color(0x661ABC9C),
    ),
    BlockColorSet(
      main: Color(0xFFE84393),
      light: Color(0xFFF06292),
      dark: Color(0xFFC2185B),
      glow: Color(0x66E84393),
    ),
  ];

  // Active palette (may be overridden by ThemeService)
  static List<BlockColorSet>? _activeColors;

  /// Get color set by index (1-based)
  static BlockColorSet getColor(int colorIndex) {
    assert(colorIndex >= 1 && colorIndex <= colorCount);
    final palette = _activeColors ?? all;
    return palette[(colorIndex - 1) % palette.length];
  }

  /// Apply a BlockTheme from ThemeService — generates BlockColorSets from the theme's flat colors
  static void applyTheme(BlockTheme theme) {
    _activeColors = theme.blockColors.map((c) {
      // Auto-generate light/dark/glow variants from the main color
      final hsl = HSLColor.fromColor(c);
      final light = hsl.withLightness((hsl.lightness + 0.15).clamp(0.0, 1.0)).toColor();
      final dark = hsl.withLightness((hsl.lightness - 0.15).clamp(0.0, 1.0)).toColor();
      final glow = c.withValues(alpha: 0.4);
      return BlockColorSet(main: c, light: light, dark: dark, glow: glow);
    }).toList();
  }

  /// Reset to default palette
  static void resetToDefault() {
    _activeColors = null;
  }

  /// Build a GridTheme from a BlockTheme
  static GridTheme gridThemeFromBlockTheme(BlockTheme theme) {
    final bgHsl = HSLColor.fromColor(theme.gridBg);
    return GridTheme(
      name: theme.name,
      bgColor: theme.gridBg,
      gridLineColor: bgHsl.withLightness((bgHsl.lightness + 0.12).clamp(0.0, 1.0)).toColor(),
      borderColor: bgHsl.withLightness((bgHsl.lightness + 0.15).clamp(0.0, 1.0)).toColor(),
      accentGlow: theme.accentColor,
    );
  }
}

class BlockColorSet {
  final Color main;
  final Color light;
  final Color dark;
  final Color glow;

  const BlockColorSet({
    required this.main,
    required this.light,
    required this.dark,
    required this.glow,
  });
}

/// Theme colors for grid background — changes on line clear
class GridTheme {
  final Color bgColor;
  final Color gridLineColor;
  final Color borderColor;
  final Color accentGlow;
  final String name;

  const GridTheme({
    required this.bgColor,
    required this.gridLineColor,
    required this.borderColor,
    required this.accentGlow,
    required this.name,
  });

  /// All available grid themes
  static const List<GridTheme> themes = [
    GridTheme(
      name: 'Midnight',
      bgColor: Color(0xFF1A1A2E),
      gridLineColor: Color(0xFF3D3D6B),
      borderColor: Color(0xFF404080),
      accentGlow: Color(0xFF6C5CE7),
    ),
    GridTheme(
      name: 'Crimson',
      bgColor: Color(0xFF2E1A1A),
      gridLineColor: Color(0xFF6B3D3D),
      borderColor: Color(0xFF804040),
      accentGlow: Color(0xFFFF4757),
    ),
    GridTheme(
      name: 'Ocean',
      bgColor: Color(0xFF1A2A2E),
      gridLineColor: Color(0xFF3D5060),
      borderColor: Color(0xFF406080),
      accentGlow: Color(0xFF3498DB),
    ),
    GridTheme(
      name: 'Emerald',
      bgColor: Color(0xFF1A2E1A),
      gridLineColor: Color(0xFF3D6B3D),
      borderColor: Color(0xFF408040),
      accentGlow: Color(0xFF2ECC71),
    ),
    GridTheme(
      name: 'Royal',
      bgColor: Color(0xFF2A1A2E),
      gridLineColor: Color(0xFF503D6B),
      borderColor: Color(0xFF604080),
      accentGlow: Color(0xFF9B59B6),
    ),
    GridTheme(
      name: 'Sunset',
      bgColor: Color(0xFF2E2A1A),
      gridLineColor: Color(0xFF6B503D),
      borderColor: Color(0xFF806040),
      accentGlow: Color(0xFFE67E22),
    ),
    GridTheme(
      name: 'Frost',
      bgColor: Color(0xFF1A2E2A),
      gridLineColor: Color(0xFF3D6B50),
      borderColor: Color(0xFF408060),
      accentGlow: Color(0xFF1ABC9C),
    ),
    GridTheme(
      name: 'Rose',
      bgColor: Color(0xFF2E1A2A),
      gridLineColor: Color(0xFF6B3D50),
      borderColor: Color(0xFF804060),
      accentGlow: Color(0xFFE84393),
    ),
  ];
}
