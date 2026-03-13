import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grid_master/shared/widgets/animated_block_background.dart';

/// Splash screen with animated puzzle icon, GRID MASTER title,
/// loading bar with percentage, and version number.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _loadingController;
  late AnimationController _titleController;
  late AnimationController _shimmerController;
  late AnimationController _iconController;
  late Animation<double> _titleFade;
  late Animation<double> _titleScale;
  late Animation<double> _iconRotation;
  late Animation<double> _iconScale;

  @override
  void initState() {
    super.initState();

    // Icon animation — scale + gentle rotation
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _iconRotation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.easeInOut),
    );
    _iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.elasticOut),
    );

    // Title animation
    _titleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _titleFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _titleController, curve: Curves.easeOut));
    _titleScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _titleController, curve: Curves.elasticOut),
    );

    // Shimmer on loading bar
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    // Loading bar — fills up over ~3 seconds
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    // Sequence: icon → title → loading → navigate
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!mounted) return;
      _iconController.forward();
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      _titleController.forward();
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      _loadingController.forward();
    });

    _loadingController.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted) {
            context.go('/');
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _loadingController.dispose();
    _titleController.dispose();
    _shimmerController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Same animated background as lobby screen
          const AnimatedBlockBackground(
            accentColor: Color(0xFF6C5CE7),
            bgColor1: Color(0xFF0D0D1A),
            bgColor2: Color(0xFF2D1B69),
            shapeCount: 16,
          ),

          // Main content - centered
          Positioned.fill(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),

                  // Animated puzzle piece icon
                  AnimatedBuilder(
                    animation: _iconController,
                    builder: (context, _) {
                      return Transform.scale(
                        scale: _iconScale.value,
                        child: Transform.rotate(
                          angle: _iconRotation.value,
                          child: CustomPaint(
                            size: const Size(80, 80),
                            painter: _PuzzleIconPainter(
                              progress: _iconController.value,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // Title "GRID MASTER" - same style as lobby
                  Center(
                    child: FadeTransition(
                      opacity: _titleFade,
                      child: ScaleTransition(
                        scale: _titleScale,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // "GRID" with gradient
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                      colors: [
                                        Color(0xFF6C5CE7),
                                        Color(0xFFA29BFE),
                                        Color(0xFF74B9FF),
                                      ],
                                    ).createShader(bounds),
                                child: Text(
                                  'GRID',
                                  style: GoogleFonts.fredoka(
                                    fontSize: 72,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: 12,
                                    height: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            // "MASTER" with gradient
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                      colors: [
                                        Color(0xFFFF6B6B),
                                        Color(0xFFFF8E53),
                                        Color(0xFFFFC107),
                                      ],
                                    ).createShader(bounds),
                                child: Text(
                                  'MASTER',
                                  style: GoogleFonts.fredoka(
                                    fontSize: 56,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: 8,
                                    height: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const Spacer(flex: 3),

                  // Loading bar with percentage
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48),
                    child: AnimatedBuilder(
                      animation: Listenable.merge([
                        _loadingController,
                        _shimmerController,
                      ]),
                      builder: (context, _) {
                        return _buildLoadingBar();
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Version number
                  FadeTransition(
                    opacity: _titleFade,
                    child: Text(
                      'v1.0.0',
                      style: GoogleFonts.fredoka(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.25),
                        letterSpacing: 2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingBar() {
    final progress = _loadingController.value;
    final shimmer = _shimmerController.value;
    final percent = (progress * 100).toInt();

    return Column(
      children: [
        // Loading text with percentage
        AnimatedOpacity(
          opacity: progress > 0 ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: Text(
            'Loading... $percent%',
            textAlign: TextAlign.center,
            style: GoogleFonts.fredoka(
              fontSize: 14,
              color: Colors.white54,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Bar container
        Container(
          height: 16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFF1A1A3E),
            border: Border.all(
              color: const Color(0xFF6C5CE7).withValues(alpha: 0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Stack(
              children: [
                // Fill bar
                FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF6C5CE7),
                          Color(0xFFA29BFE),
                          Color(0xFF74B9FF),
                          Color(0xFFA29BFE),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C5CE7).withValues(alpha: 0.8),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),

                // Shimmer effect
                if (progress > 0.05)
                  Positioned(
                    left:
                        (shimmer * 1.4 - 0.2) *
                        MediaQuery.of(context).size.width *
                        0.7 *
                        progress,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.0),
                            Colors.white.withValues(alpha: 0.35),
                            Colors.white.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Custom painter that draws a colorful 3x3 block grid icon
class _PuzzleIconPainter extends CustomPainter {
  final double progress;

  _PuzzleIconPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final cellSize = size.width / 3.5;
    final originX = (size.width - cellSize * 3) / 2;
    final originY = (size.height - cellSize * 3) / 2;

    final colors = [
      const Color(0xFF6C5CE7),
      const Color(0xFF00B894),
      const Color(0xFFFF6B6B),
      const Color(0xFFFDCB6E),
      const Color(0xFF74B9FF),
      const Color(0xFFA29BFE),
      const Color(0xFFE17055),
      const Color(0xFF55EFC4),
      const Color(0xFFFF9FF3),
    ];

    // Draw 3x3 grid of colorful blocks with staggered animation
    int idx = 0;
    for (int r = 0; r < 3; r++) {
      for (int c = 0; c < 3; c++) {
        final delay = (r * 3 + c) * 0.08;
        final localProgress = ((progress - delay) / 0.6).clamp(0.0, 1.0);

        if (localProgress > 0) {
          final paint = Paint()
            ..color = colors[idx].withValues(alpha: localProgress * 0.85)
            ..style = PaintingStyle.fill;

          final x = originX + c * cellSize;
          final y = originY + r * cellSize;
          final scale = localProgress;

          canvas.save();
          canvas.translate(x + cellSize / 2, y + cellSize / 2);
          canvas.scale(scale);
          canvas.translate(-cellSize / 2, -cellSize / 2);

          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(1, 1, cellSize - 2, cellSize - 2),
              const Radius.circular(4),
            ),
            paint,
          );

          // Inner highlight
          final highlightPaint = Paint()
            ..color = Colors.white.withValues(alpha: localProgress * 0.15)
            ..style = PaintingStyle.fill;
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(2, 2, cellSize / 2 - 2, cellSize / 3),
              const Radius.circular(2),
            ),
            highlightPaint,
          );

          canvas.restore();
        }
        idx++;
      }
    }

    // Glow behind the grid
    final glowPaint = Paint()
      ..color = const Color(0xFF6C5CE7).withValues(alpha: progress * 0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2.5,
      glowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _PuzzleIconPainter old) =>
      old.progress != progress;
}
