import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:grid_master/l10n/generated/app_localizations.dart';

/// Interactive tutorial overlay shown on first game launch
/// Features animated visuals demonstrating drag & drop, line clearing, combos
class TutorialOverlay extends StatefulWidget {
  final VoidCallback onDismiss;

  const TutorialOverlay({super.key, required this.onDismiss});

  /// Check if tutorial has been shown before
  static Future<bool> shouldShow() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool('tutorial_shown') ?? false);
  }

  /// Mark tutorial as shown
  static Future<void> markShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('tutorial_shown', true);
  }

  @override
  State<TutorialOverlay> createState() => _TutorialOverlayState();
}

class _TutorialOverlayState extends State<TutorialOverlay>
    with TickerProviderStateMixin {
  int _currentStep = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;
  late AnimationController _demoController;

  List<_TutorialStep> _getSteps(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      _TutorialStep(
        icon: Icons.touch_app_rounded,
        title: l10n.tutorialStepTitle1,
        description: l10n.tutorialStep1,
        color: const Color(0xFF6C5CE7),
        demoType: _DemoType.dragDrop,
      ),
      _TutorialStep(
        icon: Icons.auto_awesome,
        title: l10n.tutorialStepTitle2,
        description: l10n.tutorialStep2,
        color: const Color(0xFF00B894),
        demoType: _DemoType.lineClear,
      ),
      _TutorialStep(
        icon: Icons.bolt_rounded,
        title: l10n.tutorialStepTitle3,
        description: l10n.tutorialStep5,
        color: const Color(0xFFFF6B6B),
        demoType: _DemoType.combo,
      ),
      _TutorialStep(
        icon: Icons.construction_rounded,
        title: l10n.tutorialStepTitle4,
        description: l10n.tutorialStep3,
        color: const Color(0xFFE17055),
        demoType: _DemoType.hammer,
      ),
      _TutorialStep(
        icon: Icons.sports_esports_rounded,
        title: l10n.tutorialStepTitle5,
        description: l10n.tutorialStep6,
        color: const Color(0xFF74B9FF),
        demoType: _DemoType.modes,
      ),
      _TutorialStep(
        icon: Icons.emoji_events_rounded,
        title: l10n.tutorialStepTitle6,
        description: l10n.tutorialStep4,
        color: const Color(0xFFFDCB6E),
        demoType: _DemoType.goodLuck,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _fadeController.forward();

    _demoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _demoController.dispose();
    super.dispose();
  }

  void _nextStep() {
    final steps = _getSteps(context);
    if (_currentStep < steps.length - 1) {
      _fadeController.reverse().then((_) {
        setState(() => _currentStep++);
        _fadeController.forward();
      });
    } else {
      TutorialOverlay.markShown();
      widget.onDismiss();
    }
  }

  void _skip() {
    TutorialOverlay.markShown();
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    final steps = _getSteps(context);
    final step = steps[_currentStep];
    final isLast = _currentStep == steps.length - 1;
    final l10n = AppLocalizations.of(context)!;
    return Material(
      color: Colors.black.withValues(alpha: 0.88),
      child: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Step indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(steps.length, (i) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: i == _currentStep ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: i == _currentStep
                              ? step.color
                              : i < _currentStep
                                  ? step.color.withValues(alpha: 0.5)
                                  : Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 32),

                  // Animated demo area
                  Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: step.color.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: step.color.withValues(alpha: 0.2),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedBuilder(
                        animation: _demoController,
                        builder: (context, _) {
                          return _buildDemo(step);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Title
                  Text(
                    step.title,
                    style: GoogleFonts.fredoka(
                      color: step.color,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Description
                  Text(
                    step.description,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.fredoka(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!isLast)
                        TextButton(
                          onPressed: _skip,
                          child: Text(
                            l10n.skip,
                            style: GoogleFonts.fredoka(
                              color: Colors.white.withValues(alpha: 0.4),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      const SizedBox(width: 24),
                      ElevatedButton(
                        onPressed: _nextStep,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: step.color,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 8,
                          shadowColor: step.color.withValues(alpha: 0.5),
                        ),
                        child: Text(
                          isLast ? l10n.start : l10n.next,
                          style: GoogleFonts.fredoka(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDemo(_TutorialStep step) {
    switch (step.demoType) {
      case _DemoType.dragDrop:
        return _buildDragDropDemo(step.color);
      case _DemoType.lineClear:
        return _buildLineClearDemo(step.color);
      case _DemoType.combo:
        return _buildComboDemo(step.color);
      case _DemoType.hammer:
        return _buildHammerDemo(step.color);
      case _DemoType.modes:
        return _buildModesDemo(step.color);
      case _DemoType.goodLuck:
        return _buildGoodLuckDemo(step.color);
    }
  }

  // Demo 1: Animated hand dragging a block piece to the grid
  Widget _buildDragDropDemo(Color color) {
    final t = _demoController.value;
    // Hand moves from right to center
    final handX = 0.7 - t * 0.4;
    final handY = 0.3 + (t < 0.5 ? t * 0.4 : 0.2);
    final showPlaced = t > 0.6;

    return CustomPaint(
      painter: _DragDropDemoPainter(
        color: color,
        handX: handX,
        handY: handY,
        showPlaced: showPlaced,
        progress: t,
      ),
      size: Size.infinite,
    );
  }

  // Demo 2: Row filling up then flashing/clearing
  Widget _buildLineClearDemo(Color color) {
    final t = _demoController.value;
    final fillCount = (t * 6).floor().clamp(0, 5); // 0-5 cells fill up
    final isClearing = t > 0.8;
    final flashOpacity = isClearing ? (1.0 - (t - 0.8) * 5).clamp(0.0, 1.0) : 1.0;

    return CustomPaint(
      painter: _LineClearDemoPainter(
        color: color,
        fillCount: fillCount,
        isClearing: isClearing,
        flashOpacity: flashOpacity,
      ),
      size: Size.infinite,
    );
  }

  // Demo 3: Combo counter animating up
  Widget _buildComboDemo(Color color) {
    final t = _demoController.value;
    final comboCount = (t * 4).floor().clamp(0, 3);
    final scale = 1.0 + (t % 0.25) * 0.8;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.scale(
            scale: scale.clamp(1.0, 1.3),
            child: Text(
              '${comboCount + 1}x COMBO',
              style: GoogleFonts.fredoka(
                color: Color.lerp(color, Colors.yellowAccent, t)!,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(4, (i) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i <= comboCount
                      ? Color.lerp(color, Colors.yellowAccent, i / 3)!
                      : Colors.white.withValues(alpha: 0.15),
                  boxShadow: i <= comboCount
                      ? [
                          BoxShadow(
                            color: color.withValues(alpha: 0.5),
                            blurRadius: 6,
                          )
                        ]
                      : null,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // Demo 4: Hammer smashing a 3x3 area
  Widget _buildHammerDemo(Color color) {
    final t = _demoController.value;
    final hammerAngle = t < 0.4 ? -0.5 + t * 2.5 : (t < 0.5 ? 0.5 : 0.0);
    final showExplosion = t > 0.45 && t < 0.75;

    return CustomPaint(
      painter: _HammerDemoPainter(
        color: color,
        hammerAngle: hammerAngle,
        showExplosion: showExplosion,
        progress: t,
      ),
      size: Size.infinite,
    );
  }

  // Demo 5: Mode icons scrolling
  Widget _buildModesDemo(Color color) {
    final icons = [
      (Icons.grid_on_rounded, 'Easy', const Color(0xFF00B894)),
      (Icons.trending_up_rounded, 'Classic', const Color(0xFF0984E3)),
      (Icons.speed_rounded, 'Master', const Color(0xFFE17055)),
      (Icons.psychology_rounded, 'Memory', const Color(0xFFA29BFE)),
      (Icons.self_improvement_rounded, 'Zen', const Color(0xFF55EFC4)),
      (Icons.sports_esports_rounded, 'PvP', const Color(0xFFFF6B6B)),
    ];

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: icons.map((item) {
          final idx = icons.indexOf(item);
          final t = _demoController.value;
          final delay = idx * 0.12;
          final localT = ((t - delay) % 1.0).clamp(0.0, 1.0);
          final scale = (localT < 0.5 ? 0.8 + localT * 0.6 : 1.1 - (localT - 0.5) * 0.2).clamp(0.8, 1.1);

          return Transform.scale(
            scale: scale,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: item.$3.withValues(alpha: 0.2),
                    ),
                    child: Icon(item.$1, color: item.$3, size: 22),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.$2,
                    style: GoogleFonts.fredoka(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Demo 6: Trophy + sparkle
  Widget _buildGoodLuckDemo(Color color) {
    final t = _demoController.value;
    final scale = 1.0 + 0.1 * (0.5 - (t - 0.5).abs());

    return Center(
      child: Transform.scale(
        scale: scale,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Sparkle ring
            ...List.generate(8, (i) {
              final angle = (i / 8) * 3.14159 * 2 + t * 3.14159 * 2;
              final radius = 40.0 + 10.0 * (0.5 - (t - 0.5).abs());
              return Positioned(
                left: 70 + radius * _cos(angle) - 4,
                top: 70 + radius * _sin(angle) - 4,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.lerp(color, Colors.white, (i % 2) * 0.5)!
                        .withValues(alpha: 0.6 + 0.4 * _sin(t * 6.28 + i)),
                  ),
                ),
              );
            }),
            Icon(
              Icons.emoji_events_rounded,
              color: color,
              size: 52,
            ),
          ],
        ),
      ),
    );
  }

  double _sin(double x) => (x - (x * x * x / 6) + (x * x * x * x * x / 120)).clamp(-1.0, 1.0);
  double _cos(double x) => _sin(x + 1.5708);
}

// =================== Demo Painters ===================

class _DragDropDemoPainter extends CustomPainter {
  final Color color;
  final double handX, handY;
  final bool showPlaced;
  final double progress;

  _DragDropDemoPainter({
    required this.color,
    required this.handX,
    required this.handY,
    required this.showPlaced,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cellSize = size.height / 6;
    final gridLeft = size.width / 2 - cellSize * 2.5;
    final gridTop = size.height / 2 - cellSize * 2.5;

    // Draw mini 5x5 grid
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    for (int r = 0; r <= 5; r++) {
      canvas.drawLine(
        Offset(gridLeft, gridTop + r * cellSize),
        Offset(gridLeft + 5 * cellSize, gridTop + r * cellSize),
        gridPaint,
      );
    }
    for (int c = 0; c <= 5; c++) {
      canvas.drawLine(
        Offset(gridLeft + c * cellSize, gridTop),
        Offset(gridLeft + c * cellSize, gridTop + 5 * cellSize),
        gridPaint,
      );
    }

    // Some pre-placed blocks
    final placedPaint = Paint()..style = PaintingStyle.fill;
    final prePlaced = [(3, 1), (3, 2), (4, 0), (4, 1), (4, 2)];
    for (final pos in prePlaced) {
      placedPaint.color = Colors.tealAccent.withValues(alpha: 0.3);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            gridLeft + pos.$2 * cellSize + 1,
            gridTop + pos.$1 * cellSize + 1,
            cellSize - 2,
            cellSize - 2,
          ),
          const Radius.circular(3),
        ),
        placedPaint,
      );
    }

    // Dragging piece (L-shape)
    final pieceX = handX * size.width;
    final pieceY = handY * size.height;
    final piecePaint = Paint()
      ..color = showPlaced ? color.withValues(alpha: 0.6) : color
      ..style = PaintingStyle.fill;

    if (!showPlaced) {
      // Draw piece being dragged
      for (final offset in [(0, 0), (1, 0), (1, 1)]) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(
              pieceX + offset.$2 * cellSize,
              pieceY + offset.$1 * cellSize,
              cellSize - 2,
              cellSize - 2,
            ),
            const Radius.circular(3),
          ),
          piecePaint,
        );
      }

      // Hand icon indicator
      final handPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.6);
      canvas.drawCircle(
        Offset(pieceX + cellSize / 2, pieceY + cellSize * 2 + 8),
        6,
        handPaint,
      );
    } else {
      // Show placed on grid
      final targetPositions = [(1, 3), (2, 3), (2, 4)];
      for (final pos in targetPositions) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(
              gridLeft + pos.$2 * cellSize + 1,
              gridTop + pos.$1 * cellSize + 1,
              cellSize - 2,
              cellSize - 2,
            ),
            const Radius.circular(3),
          ),
          piecePaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DragDropDemoPainter old) => true;
}

class _LineClearDemoPainter extends CustomPainter {
  final Color color;
  final int fillCount;
  final bool isClearing;
  final double flashOpacity;

  _LineClearDemoPainter({
    required this.color,
    required this.fillCount,
    required this.isClearing,
    required this.flashOpacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cellSize = size.height / 6;
    final gridLeft = size.width / 2 - cellSize * 2.5;
    final gridTop = size.height / 2 - cellSize * 2.5;

    // Draw 5x5 grid
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    for (int r = 0; r <= 5; r++) {
      canvas.drawLine(
        Offset(gridLeft, gridTop + r * cellSize),
        Offset(gridLeft + 5 * cellSize, gridTop + r * cellSize),
        gridPaint,
      );
    }
    for (int c = 0; c <= 5; c++) {
      canvas.drawLine(
        Offset(gridLeft + c * cellSize, gridTop),
        Offset(gridLeft + c * cellSize, gridTop + 5 * cellSize),
        gridPaint,
      );
    }

    // Fill row 2 progressively
    final fillPaint = Paint()..style = PaintingStyle.fill;
    final colors = [
      const Color(0xFF6C5CE7),
      const Color(0xFF00B894),
      const Color(0xFFFF6B6B),
      const Color(0xFFFDCB6E),
      const Color(0xFF74B9FF),
    ];

    for (int c = 0; c < 5; c++) {
      if (c < fillCount) {
        fillPaint.color = isClearing
            ? colors[c].withValues(alpha: flashOpacity * 0.8)
            : colors[c].withValues(alpha: 0.7);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(
              gridLeft + c * cellSize + 1,
              gridTop + 2 * cellSize + 1,
              cellSize - 2,
              cellSize - 2,
            ),
            const Radius.circular(3),
          ),
          fillPaint,
        );
      }
    }

    // Clear flash glow
    if (isClearing) {
      final glowPaint = Paint()
        ..color = Colors.white.withValues(alpha: flashOpacity * 0.3)
        ..style = PaintingStyle.fill;
      canvas.drawRect(
        Rect.fromLTWH(
          gridLeft,
          gridTop + 2 * cellSize,
          5 * cellSize,
          cellSize,
        ),
        glowPaint,
      );
    }

    // Some random blocks in other rows for visual interest
    final otherBlocks = [(0, 1), (0, 3), (1, 0), (1, 4), (3, 2), (4, 1), (4, 4)];
    for (final pos in otherBlocks) {
      fillPaint.color = Colors.white.withValues(alpha: 0.15);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            gridLeft + pos.$2 * cellSize + 1,
            gridTop + pos.$1 * cellSize + 1,
            cellSize - 2,
            cellSize - 2,
          ),
          const Radius.circular(3),
        ),
        fillPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _LineClearDemoPainter old) => true;
}

class _HammerDemoPainter extends CustomPainter {
  final Color color;
  final double hammerAngle;
  final bool showExplosion;
  final double progress;

  _HammerDemoPainter({
    required this.color,
    required this.hammerAngle,
    required this.showExplosion,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw 3x3 target area
    final cellSize = size.height / 6;
    final targetLeft = centerX - cellSize * 1.5;
    final targetTop = centerY - cellSize * 1.5;

    final blockPaint = Paint()..style = PaintingStyle.fill;

    if (!showExplosion || progress > 0.7) {
      for (int r = 0; r < 3; r++) {
        for (int c = 0; c < 3; c++) {
          final alpha = showExplosion ? (1.0 - (progress - 0.45) * 3).clamp(0.0, 0.5) : 0.4;
          blockPaint.color = color.withValues(alpha: alpha);
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(
                targetLeft + c * cellSize + 1,
                targetTop + r * cellSize + 1,
                cellSize - 2,
                cellSize - 2,
              ),
              const Radius.circular(3),
            ),
            blockPaint,
          );
        }
      }
    }

    // Draw hammer
    if (!showExplosion) {
      canvas.save();
      canvas.translate(centerX + cellSize * 2, centerY - cellSize);
      canvas.rotate(hammerAngle);

      // Handle
      final handlePaint = Paint()
        ..color = const Color(0xFF8B6914)
        ..style = PaintingStyle.fill;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(-3, 0, 6, 30),
          const Radius.circular(2),
        ),
        handlePaint,
      );

      // Head
      final headPaint = Paint()
        ..color = Colors.grey.shade400
        ..style = PaintingStyle.fill;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(-10, -12, 20, 14),
          const Radius.circular(3),
        ),
        headPaint,
      );

      canvas.restore();
    }

    // Explosion particles
    if (showExplosion) {
      final explodeT = ((progress - 0.45) / 0.3).clamp(0.0, 1.0);
      for (int i = 0; i < 8; i++) {
        final angle = (i / 8) * 3.14159 * 2;
        final radius = explodeT * cellSize * 2;
        final px = centerX + radius * _cosSimple(angle);
        final py = centerY + radius * _sinSimple(angle);
        final particlePaint = Paint()
          ..color = color.withValues(alpha: (1.0 - explodeT) * 0.8);
        canvas.drawCircle(Offset(px, py), 4 * (1.0 - explodeT), particlePaint);
      }
    }
  }

  double _sinSimple(double x) {
    x = x % (3.14159 * 2);
    if (x > 3.14159) x -= 3.14159 * 2;
    return x - (x * x * x / 6);
  }

  double _cosSimple(double x) => _sinSimple(x + 1.5708);

  @override
  bool shouldRepaint(covariant _HammerDemoPainter old) => true;
}

// =================== Data Classes ===================

enum _DemoType {
  dragDrop,
  lineClear,
  combo,
  hammer,
  modes,
  goodLuck,
}

class _TutorialStep {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final _DemoType demoType;

  const _TutorialStep({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.demoType,
  });
}
