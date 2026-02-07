import 'dart:ui';

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

  /// Get color set by index (1-based)
  static BlockColorSet getColor(int colorIndex) {
    assert(colorIndex >= 1 && colorIndex <= colorCount);
    return all[colorIndex - 1];
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
