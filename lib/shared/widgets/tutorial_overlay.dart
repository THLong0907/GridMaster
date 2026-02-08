import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:grid_master/l10n/generated/app_localizations.dart';

/// Tutorial overlay shown on first game launch
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
    with SingleTickerProviderStateMixin {
  int _currentStep = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;

  List<_TutorialStep> _getSteps(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      _TutorialStep(
        icon: Icons.touch_app_rounded,
        title: l10n.tutorialTitle,
        description: l10n.tutorialStep1,
        color: const Color(0xFF6C5CE7),
      ),
      _TutorialStep(
        icon: Icons.auto_awesome,
        title: l10n.tutorialTitle, // Reusing title or should have specific step titles? Using generic for now or mapping specific keys if available
        description: l10n.tutorialStep2,
        color: const Color(0xFF00B894),
      ),
      _TutorialStep(
        icon: Icons.bolt_rounded,
        title: l10n.tutorialTitle,
        description: l10n.tutorialStep3,
        color: const Color(0xFFFDCB6E),
      ),
      _TutorialStep(
        icon: Icons.construction_rounded,
        title: l10n.tutorialTitle,
        description: l10n.tutorialStep4,
        color: const Color(0xFFE17055),
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
  }

  @override
  void dispose() {
    _fadeController.dispose();
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
      color: Colors.black.withValues(alpha: 0.85),
      child: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Step indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(steps.length, (i) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: i == _currentStep ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: i == _currentStep
                            ? step.color
                            : Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 48),

                // Icon
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: step.color.withValues(alpha: 0.2),
                    border: Border.all(
                      color: step.color.withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                  child: Icon(step.icon, color: step.color, size: 56),
                ),
                const SizedBox(height: 32),

                // Title
                Text(
                  step.title,
                  style: GoogleFonts.fredoka(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  step.description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.fredoka(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 48),

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
    );
  }
}

class _TutorialStep {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _TutorialStep({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}
