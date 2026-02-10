import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grid_master/shared/widgets/animated_block_background.dart';

/// Privacy Policy screen
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      body: Stack(
        children: [
          const AnimatedBlockBackground(),
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.white70),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'PRIVACY POLICY',
                        style: GoogleFonts.fredoka(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E2E),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionTitle('Last Updated'),
                          _bodyText('February 2025'),
                          const SizedBox(height: 20),
                          _sectionTitle('Introduction'),
                          _bodyText(
                            'Grid Master ("we", "our", or "us") is a puzzle block game developed for entertainment purposes. '
                            'This Privacy Policy explains how we collect, use, and protect your information when you use our application.',
                          ),
                          const SizedBox(height: 20),
                          _sectionTitle('Information We Collect'),
                          _bodyText(
                            '• Anonymous User ID: Generated automatically for leaderboard functionality.\n'
                            '• Display Name: Your chosen name for the leaderboard (optional).\n'
                            '• Game Scores: Your scores submitted to the leaderboard.\n'
                            '• Game Statistics: Local data such as games played, time played, and achievements (stored on your device only).',
                          ),
                          const SizedBox(height: 20),
                          _sectionTitle('How We Use Your Information'),
                          _bodyText(
                            '• To provide leaderboard rankings across players.\n'
                            '• To save your game progress and high scores locally on your device.\n'
                            '• To improve the game experience.',
                          ),
                          const SizedBox(height: 20),
                          _sectionTitle('Data Storage'),
                          _bodyText(
                            '• Local data (high scores, settings, statistics) is stored on your device using SharedPreferences.\n'
                            '• Leaderboard data is stored on Firebase Cloud Firestore servers.\n'
                            '• We do not sell or share your data with third parties.',
                          ),
                          const SizedBox(height: 20),
                          _sectionTitle('Third-Party Services'),
                          _bodyText(
                            '• Firebase Authentication: For anonymous user identification.\n'
                            '• Firebase Cloud Firestore: For leaderboard data storage.\n'
                            '• Google Fonts: For typography rendering.',
                          ),
                          const SizedBox(height: 20),
                          _sectionTitle('Children\'s Privacy'),
                          _bodyText(
                            'Grid Master is suitable for all ages. We do not knowingly collect personal information from children under 13. '
                            'The only data collected is an anonymous user ID and an optional display name.',
                          ),
                          const SizedBox(height: 20),
                          _sectionTitle('Your Rights'),
                          _bodyText(
                            '• You can clear all local data by using the "Clear High Scores" option in Settings.\n'
                            '• Your leaderboard data is associated with an anonymous ID only.\n'
                            '• You can request deletion of your data by contacting us.',
                          ),
                          const SizedBox(height: 20),
                          _sectionTitle('Contact'),
                          _bodyText(
                            'If you have any questions about this Privacy Policy, please contact us at:\n'
                            'gridmaster.game@gmail.com',
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.fredoka(
          color: const Color(0xFF6C5CE7),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _bodyText(String text) {
    return Text(
      text,
      style: GoogleFonts.fredoka(
        color: Colors.white.withValues(alpha: 0.7),
        fontSize: 14,
        height: 1.6,
      ),
    );
  }
}
