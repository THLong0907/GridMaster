import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grid_master/shared/widgets/animated_block_background.dart';

/// Splash screen reusing the lobby's AnimatedBlockBackground,
/// with "GRID MASTER" title and a loading bar that fills up.
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
  late Animation<double> _titleFade;
  late Animation<double> _titleScale;

  @override
  void initState() {
    super.initState();

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

    // Sequence: show title → start loading → navigate
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      _titleController.forward();
    });

    Future.delayed(const Duration(milliseconds: 500), () {
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
                  const Spacer(flex: 3),

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

                  const Spacer(flex: 4),

                  // Loading bar - centered
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

                  const SizedBox(height: 48),
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

    return Column(
      children: [
        // Loading text
        AnimatedOpacity(
          opacity: progress > 0 ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: Text(
            'Loading...',
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
