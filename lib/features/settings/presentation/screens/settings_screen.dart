import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:grid_master/shared/services/audio_service.dart';
import 'package:grid_master/shared/widgets/animated_block_background.dart';

/// Settings screen for sound, vibration, and preferences
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _soundEnabled = prefs.getBool('sound_enabled') ?? true;
      _vibrationEnabled = prefs.getBool('vibration_enabled') ?? true;
    });
  }

  Future<void> _setSoundEnabled(bool value) async {
    setState(() => _soundEnabled = value);
    await AudioService.instance.setSoundEnabled(value);
  }

  Future<void> _setVibrationEnabled(bool value) async {
    setState(() => _vibrationEnabled = value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('vibration_enabled', value);
  }

  Future<void> _resetTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('tutorial_shown', false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Tutorial sẽ hiện lại lần chơi tiếp theo',
            style: GoogleFonts.fredoka(),
          ),
          backgroundColor: const Color(0xFF6C5CE7),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  Future<void> _clearHighScores() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Xóa Điểm Cao?',
          style: GoogleFonts.fredoka(color: Colors.white),
        ),
        content: Text(
          'Tất cả điểm cao sẽ bị xóa. Không thể hoàn tác.',
          style: GoogleFonts.fredoka(
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('Hủy', style: GoogleFonts.fredoka()),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            child: Text('Xóa', style: GoogleFonts.fredoka()),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final prefs = await SharedPreferences.getInstance();
      for (final key in prefs.getKeys().toList()) {
        if (key.startsWith('high_score_')) {
          await prefs.remove(key);
        }
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Đã xóa tất cả điểm cao',
              style: GoogleFonts.fredoka(),
            ),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedBlockBackground(
            accentColor: Color(0xFF6C5CE7),
            bgColor1: Color(0xFF0D0D1A),
            bgColor2: Color(0xFF1A1A2E),
          ),
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      _buildBackButton(),
                      const SizedBox(width: 12),
                      Text(
                        'Cài Đặt',
                        style: GoogleFonts.fredoka(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Settings list
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildSection('Âm thanh & Rung'),
                      const SizedBox(height: 8),
                      _buildToggle(
                        icon: Icons.volume_up_rounded,
                        title: 'Âm thanh',
                        subtitle: 'Hiệu ứng âm thanh trong game',
                        value: _soundEnabled,
                        color: const Color(0xFF6C5CE7),
                        onChanged: _setSoundEnabled,
                      ),
                      const SizedBox(height: 8),
                      _buildToggle(
                        icon: Icons.vibration_rounded,
                        title: 'Rung',
                        subtitle: 'Phản hồi rung khi đặt khối',
                        value: _vibrationEnabled,
                        color: const Color(0xFF00B894),
                        onChanged: _setVibrationEnabled,
                      ),

                      const SizedBox(height: 24),
                      _buildSection('Dữ liệu'),
                      const SizedBox(height: 8),
                      _buildActionButton(
                        icon: Icons.school_rounded,
                        title: 'Xem lại Tutorial',
                        subtitle: 'Hiện hướng dẫn chơi lần sau',
                        color: const Color(0xFF0984E3),
                        onTap: _resetTutorial,
                      ),
                      const SizedBox(height: 8),
                      _buildActionButton(
                        icon: Icons.delete_forever_rounded,
                        title: 'Xóa Điểm Cao',
                        subtitle: 'Reset tất cả high scores',
                        color: const Color(0xFFE17055),
                        onTap: _clearHighScores,
                      ),

                      const SizedBox(height: 24),
                      _buildSection('Thông tin'),
                      const SizedBox(height: 8),
                      _buildInfoTile(
                        icon: Icons.info_outline_rounded,
                        title: 'Phiên bản',
                        value: '1.0.0',
                      ),
                      const SizedBox(height: 8),
                      _buildInfoTile(
                        icon: Icons.gamepad_rounded,
                        title: 'Engine',
                        value: 'Flame + Flutter',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.go('/'),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          ),
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Text(
      title.toUpperCase(),
      style: GoogleFonts.fredoka(
        color: Colors.white.withValues(alpha: 0.4),
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 2,
      ),
    );
  }

  Widget _buildToggle({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Color color,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.fredoka(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.fredoka(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: color,
            activeTrackColor: color.withValues(alpha: 0.3),
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey.withValues(alpha: 0.2),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.fredoka(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.fredoka(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.white.withValues(alpha: 0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white54, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.fredoka(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.fredoka(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
