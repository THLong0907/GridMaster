import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:grid_master/l10n/generated/app_localizations.dart';
import 'package:grid_master/shared/services/consent_service.dart';

/// Full-screen GDPR consent dialog shown on first launch.
/// Offers Accept/Decline with link to privacy policy.
class ConsentDialog extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const ConsentDialog({
    super.key,
    required this.onAccept,
    required this.onDecline,
  });

  /// Show the consent dialog if not yet consented
  static Future<bool> showIfNeeded(BuildContext context) async {
    final hasConsented = await ConsentService.hasConsented();
    if (hasConsented) {
      return await ConsentService.isAccepted();
    }

    if (!context.mounted) return false;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.92),
      builder: (ctx) => ConsentDialog(
        onAccept: () {
          ConsentService.setConsent(true);
          Navigator.of(ctx).pop(true);
        },
        onDecline: () {
          ConsentService.setConsent(false);
          Navigator.of(ctx).pop(false);
        },
      ),
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final title = l10n?.consentTitle ?? 'Privacy & Data';
    final message = l10n?.consentMessage ??
        'We collect anonymous game analytics to improve your experience. No personal data is collected.';
    final accept = l10n?.consentAccept ?? 'Accept';
    final decline = l10n?.consentDecline ?? 'Decline';
    final learnMore = l10n?.consentLearnMore ?? 'Learn More';

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A3E),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Shield icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF6C5CE7).withValues(alpha: 0.15),
                  border: Border.all(
                    color: const Color(0xFF6C5CE7).withValues(alpha: 0.4),
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.shield_rounded,
                  color: Color(0xFF6C5CE7),
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                title,
                style: GoogleFonts.fredoka(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Message
              Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.fredoka(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),

              // Learn More link
              TextButton(
                onPressed: () {
                  context.push('/privacy');
                },
                child: Text(
                  learnMore,
                  style: GoogleFonts.fredoka(
                    color: const Color(0xFF74B9FF),
                    fontSize: 13,
                    decoration: TextDecoration.underline,
                    decorationColor: const Color(0xFF74B9FF),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Accept button (primary)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C5CE7),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 6,
                    shadowColor: const Color(0xFF6C5CE7).withValues(alpha: 0.4),
                  ),
                  child: Text(
                    accept,
                    style: GoogleFonts.fredoka(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Decline button (secondary)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: onDecline,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white54,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(
                      color: Colors.white.withValues(alpha: 0.15),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    decline,
                    style: GoogleFonts.fredoka(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
