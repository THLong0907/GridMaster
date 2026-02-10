import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:grid_master/shared/services/audio_service.dart';
import 'package:grid_master/shared/services/music_service.dart';
import 'package:grid_master/shared/services/theme_service.dart';
import 'package:grid_master/shared/services/locale_provider.dart';
import 'package:grid_master/shared/widgets/animated_block_background.dart';
import 'package:grid_master/l10n/generated/app_localizations.dart';

/// Settings screen for sound, vibration, and preferences
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  bool _tetEffectsEnabled = true;
  bool _musicEnabled = true;
  int _selectedThemeIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await MusicService.instance.init();
    await ThemeService.instance.init();
    setState(() {
      _soundEnabled = prefs.getBool('sound_enabled') ?? true;
      _vibrationEnabled = prefs.getBool('vibration_enabled') ?? true;
      _tetEffectsEnabled = prefs.getBool('tet_effects_enabled') ?? true;
      _musicEnabled = MusicService.instance.isEnabled;
      _selectedThemeIndex = ThemeService.instance.selectedIndex;
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

  Future<void> _setTetEffectsEnabled(bool value) async {
    setState(() => _tetEffectsEnabled = value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('tet_effects_enabled', value);
  }

  Future<void> _resetTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('tutorial_shown', false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Tutorial sẽ hiện lại lần chơi tiếp theo', // Keep this or add key? "Tutorial reset"
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
          AppLocalizations.of(ctx)!.resetConfirmTitle,
          style: GoogleFonts.fredoka(color: Colors.white),
        ),
        content: Text(
          AppLocalizations.of(ctx)!.resetConfirmContent,
          style: GoogleFonts.fredoka(
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(AppLocalizations.of(ctx)!.cancel, style: GoogleFonts.fredoka()),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            child: Text(AppLocalizations.of(ctx)!.delete, style: GoogleFonts.fredoka()),
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
                        AppLocalizations.of(context)!.settings,
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
                      _buildSection('${AppLocalizations.of(context)!.sound} & ${AppLocalizations.of(context)!.haptics}'),
                      const SizedBox(height: 8),
                      _buildToggle(
                        icon: Icons.volume_up_rounded,
                        title: AppLocalizations.of(context)!.sound,
                        subtitle: AppLocalizations.of(context)!.sound,
                        value: _soundEnabled,
                        color: const Color(0xFF6C5CE7),
                        onChanged: _setSoundEnabled,
                      ),
                      const SizedBox(height: 8),
                      _buildToggle(
                        icon: Icons.vibration_rounded,
                        title: AppLocalizations.of(context)!.haptics,
                        subtitle: AppLocalizations.of(context)!.haptics,
                        value: _vibrationEnabled,
                        color: const Color(0xFF00B894),
                        onChanged: _setVibrationEnabled,
                      ),
                      const SizedBox(height: 8),
                      _buildToggle(
                        icon: Icons.music_note_rounded,
                        title: AppLocalizations.of(context)!.music,
                        subtitle: AppLocalizations.of(context)!.music,
                        value: _musicEnabled,
                        color: const Color(0xFFE84393),
                        onChanged: (v) async {
                          setState(() => _musicEnabled = v);
                          await MusicService.instance.setEnabled(v);
                        },
                      ),

                      const SizedBox(height: 24),
                      _buildSection(AppLocalizations.of(context)!.themes),
                      const SizedBox(height: 8),
                      _buildThemeSelector(),

                      const SizedBox(height: 24),
                      _buildSection(AppLocalizations.of(context)!.data),
                      const SizedBox(height: 8),
                      _buildActionButton(
                        icon: Icons.school_rounded,
                        title: AppLocalizations.of(context)!.tutorialTitle,
                        subtitle: AppLocalizations.of(context)!.tutorialTitle,
                        color: const Color(0xFF0984E3),
                        onTap: _resetTutorial,
                      ),
                      const SizedBox(height: 8),
                      _buildActionButton(
                        icon: Icons.delete_forever_rounded,
                        title: AppLocalizations.of(context)!.resetProgress,
                        subtitle: AppLocalizations.of(context)!.resetProgress,
                        color: const Color(0xFFE17055),
                        onTap: _clearHighScores,
                      ),

                      const SizedBox(height: 24),
                      _buildSection(AppLocalizations.of(context)!.tetEffects),
                      const SizedBox(height: 8),
                      _buildToggle(
                        icon: Icons.celebration_rounded,
                        title: AppLocalizations.of(context)!.tetEffects,
                        subtitle: AppLocalizations.of(context)!.tetEffects,
                        value: _tetEffectsEnabled,
                        color: const Color(0xFFFF0000),
                        onChanged: _setTetEffectsEnabled,
                      ),

                      const SizedBox(height: 24),
                      _buildSection(AppLocalizations.of(context)!.language),
                      const SizedBox(height: 8),
                      _buildLanguageTile(),

                      const SizedBox(height: 24),
                      _buildSection(AppLocalizations.of(context)!.settings),
                      const SizedBox(height: 8),
                      _buildInfoTile(
                        icon: Icons.info_outline_rounded,
                        title: 'Version',
                        value: '1.0.0',
                      ),
                      const SizedBox(height: 8),
                      _buildInfoTile(
                        icon: Icons.gamepad_rounded,
                        title: 'Engine',
                        value: 'Flame + Flutter',
                      ),
                      const SizedBox(height: 8),
                      _buildActionButton(
                        icon: Icons.auto_awesome_rounded,
                        title: AppLocalizations.of(context)!.newFeatures,
                        subtitle: AppLocalizations.of(context)!.newFeatures,
                        color: const Color(0xFF6C5CE7),
                        onTap: () => context.push('/features'),
                      ),
                      const SizedBox(height: 8),
                      _buildActionButton(
                        icon: Icons.privacy_tip_rounded,
                        title: AppLocalizations.of(context)!.privacyPolicy,
                        subtitle: AppLocalizations.of(context)!.privacyPolicy,
                        color: const Color(0xFF636E72),
                        onTap: () => context.push('/privacy'),
                      ),
                      const SizedBox(height: 32),
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
            activeThumbColor: color,
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

  Widget _buildLanguageTile() {
    final provider = LocaleProvider.instance;
    final currentCode = provider.locale?.languageCode;
    final displayName = currentCode != null
        ? '${LocaleProvider.languageFlags[currentCode] ?? ''} ${LocaleProvider.supportedLanguages[currentCode] ?? 'Auto'}'
        : AppLocalizations.of(context)!.autoDevice;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _showLanguagePicker,
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
                  color: const Color(0xFF6C5CE7).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.language_rounded,
                    color: Color(0xFF6C5CE7), size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.language,
                      style: GoogleFonts.fredoka(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      displayName,
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

  void _showLanguagePicker() {
    final provider = LocaleProvider.instance;
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          expand: false,
          builder: (ctx, scrollController) {
            return Column(
              children: [
                // Handle
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    AppLocalizations.of(context)!.chooseLanguage,
                    style: GoogleFonts.fredoka(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(color: Colors.white12),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    children: [
                      // Auto option
                      _languageOption(
                        ctx: ctx,
                        flag: '',
                        name: AppLocalizations.of(context)!.autoDevice,
                        isSelected: provider.locale == null,
                        onTap: () {
                          provider.setLocale(null);
                          Navigator.pop(ctx);
                          setState(() {});
                        },
                      ),
                      const Divider(color: Colors.white12, height: 1),
                      // All languages
                      ...LocaleProvider.supportedLanguages.entries.map((e) {
                        final flag = LocaleProvider.languageFlags[e.key] ?? '';
                        return _languageOption(
                          ctx: ctx,
                          flag: flag,
                          name: e.value,
                          isSelected: provider.locale?.languageCode == e.key,
                          onTap: () {
                            provider.setLocale(Locale(e.key));
                            Navigator.pop(ctx);
                            setState(() {});
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _languageOption({
    required BuildContext ctx,
    required String flag,
    required String name,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF6C5CE7).withValues(alpha: 0.15) : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Text(flag, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  name,
                  style: GoogleFonts.fredoka(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(Icons.check_circle_rounded,
                    color: Color(0xFF6C5CE7), size: 22),
            ],
          ),
        ),
      ),
    );
  }

  // =============== THEME SELECTOR ===============

  Widget _buildThemeSelector() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ThemeService.themes.length,
        itemBuilder: (context, index) {
          final theme = ThemeService.themes[index];
          final isSelected = index == _selectedThemeIndex;
          return GestureDetector(
            onTap: () async {
              await ThemeService.instance.setTheme(index);
              setState(() => _selectedThemeIndex = index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 72,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: theme.gridBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected
                      ? theme.accentColor
                      : Colors.white.withValues(alpha: 0.1),
                  width: isSelected ? 2.5 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: theme.accentColor.withValues(alpha: 0.3),
                          blurRadius: 8,
                        ),
                      ]
                    : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(theme.icon, size: 20, color: theme.accentColor),
                  const SizedBox(height: 4),
                  // Color swatches
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: theme.blockColors
                        .take(4)
                        .map(
                          (c) => Container(
                            width: 10,
                            height: 10,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            decoration: BoxDecoration(
                              color: c,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    theme.name,
                    style: GoogleFonts.fredoka(
                      color: isSelected
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.5),
                      fontSize: 9,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
