import 'package:shared_preferences/shared_preferences.dart';
import 'audio_service_stub.dart'
    if (dart.library.js_interop) 'audio_service_web.dart';

/// Audio service using Web Audio API for sound effects (web only).
/// On non-web platforms, all sound methods are no-ops.
class AudioService {
  static AudioService? _instance;
  static AudioService get instance => _instance ??= AudioService._();

  bool _soundEnabled = true;
  bool get soundEnabled => _soundEnabled;

  final AudioServicePlatform _platform = AudioServicePlatform();

  AudioService._();

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _soundEnabled = prefs.getBool('sound_enabled') ?? true;
  }

  Future<void> setSoundEnabled(bool value) async {
    _soundEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sound_enabled', value);
  }

  /// Play a tone
  void _playTone({
    required double frequency,
    required double duration,
    String type = 'sine',
    double volume = 0.3,
    double? frequency2,
  }) {
    if (!_soundEnabled) return;
    _platform.playTone(
      frequency: frequency,
      duration: duration,
      type: type,
      volume: volume,
      frequency2: frequency2,
    );
  }

  /// Play tones in sequence
  void _playSequence(List<ToneData> tones) {
    if (!_soundEnabled) return;
    _platform.playSequence(tones);
  }

  // =================== GAME SOUNDS ===================

  void playPiecePlaced() {
    _playTone(frequency: 440, duration: 0.08, type: 'sine', volume: 0.15);
  }

  void playLineClear() {
    _playSequence([
      ToneData(523.25, 0.1, 'sine', 0.2),
      ToneData(659.25, 0.1, 'sine', 0.2),
      ToneData(783.99, 0.15, 'sine', 0.25),
    ]);
  }

  void playCombo(int lines) {
    final f = 523.25 + (lines * 100);
    _playSequence([
      ToneData(f, 0.08, 'square', 0.15),
      ToneData(f * 1.25, 0.08, 'square', 0.15),
      ToneData(f * 1.5, 0.08, 'square', 0.2),
      ToneData(f * 2, 0.2, 'sine', 0.25),
    ]);
  }

  void playGameOver() {
    _playSequence([
      ToneData(392.0, 0.2, 'sawtooth', 0.15),
      ToneData(330.0, 0.2, 'sawtooth', 0.15),
      ToneData(262.0, 0.3, 'sawtooth', 0.2),
      ToneData(196.0, 0.5, 'sine', 0.15),
    ]);
  }

  void playButtonTap() {
    _playTone(frequency: 800, duration: 0.04, type: 'sine', volume: 0.1);
  }

  void playTimerWarning() {
    _playTone(frequency: 600, duration: 0.06, type: 'square', volume: 0.1);
  }

  void playAutoDrop() {
    _playTone(
      frequency: 300,
      duration: 0.3,
      type: 'triangle',
      volume: 0.2,
      frequency2: 150,
    );
  }

  void playRisingRow() {
    _playTone(
      frequency: 150,
      duration: 0.4,
      type: 'triangle',
      volume: 0.15,
      frequency2: 300,
    );
  }

  void playHammer() {
    _playSequence([
      ToneData(200, 0.05, 'sawtooth', 0.2),
      ToneData(100, 0.15, 'sawtooth', 0.25),
    ]);
  }

  void playNewHighScore() {
    _playSequence([
      ToneData(523.25, 0.12, 'sine', 0.2),
      ToneData(659.25, 0.12, 'sine', 0.2),
      ToneData(783.99, 0.12, 'sine', 0.25),
      ToneData(1046.5, 0.3, 'sine', 0.3),
    ]);
  }

  // =================== EFFECT SOUNDS ===================

  void playFireworkSound(double pitch) {
    final p = pitch;
    _playTone(
      frequency: 180 * p,
      duration: 0.08,
      type: 'sawtooth',
      volume: 0.15,
      frequency2: 400 * p,
    );
    _playSequence([
      ToneData(0, 0.12, 'sine', 0),
      ToneData(120 * p, 0.12, 'sawtooth', 0.28),
      ToneData(80 * p, 0.08, 'sawtooth', 0.22),
    ]);
    _playSequence([
      ToneData(0, 0.3, 'sine', 0),
      ToneData(1200 * p, 0.03, 'square', 0.08),
      ToneData(1800 * p, 0.02, 'square', 0.06),
      ToneData(1000 * p, 0.04, 'square', 0.07),
      ToneData(2000 * p, 0.03, 'square', 0.05),
      ToneData(1500 * p, 0.03, 'square', 0.06),
      ToneData(2200 * p, 0.04, 'square', 0.04),
    ]);
  }

  void playSparkleSound(double pitch) {
    final p = pitch;
    _playSequence([
      ToneData(2400 * p, 0.06, 'sine', 0.1),
      ToneData(2800 * p, 0.06, 'sine', 0.08),
      ToneData(3200 * p, 0.06, 'sine', 0.07),
      ToneData(2600 * p, 0.08, 'sine', 0.06),
      ToneData(3400 * p, 0.06, 'sine', 0.05),
      ToneData(3000 * p, 0.08, 'sine', 0.04),
      ToneData(3600 * p, 0.1, 'sine', 0.03),
    ]);
  }

  void playShockwaveSound(double pitch) {
    final p = pitch;
    _playTone(
      frequency: 60 * p,
      duration: 0.15,
      type: 'sine',
      volume: 0.3,
      frequency2: 30 * p,
    );
    _playTone(
      frequency: 120 * p,
      duration: 0.08,
      type: 'sawtooth',
      volume: 0.2,
    );
    _playSequence([
      ToneData(0, 0.15, 'sine', 0),
      ToneData(200 * p, 0.5, 'sine', 0.1),
    ]);
    _playTone(
      frequency: 180 * p,
      duration: 0.6,
      type: 'sine',
      volume: 0.08,
      frequency2: 80 * p,
    );
  }

  void playExplosionSound(double pitch) {
    final p = pitch;
    _playTone(
      frequency: 80 * p,
      duration: 0.12,
      type: 'sawtooth',
      volume: 0.35,
    );
    _playSequence([
      ToneData(120 * p, 0.06, 'sawtooth', 0.3),
      ToneData(60 * p, 0.1, 'sawtooth', 0.25),
      ToneData(40 * p, 0.15, 'sine', 0.18),
    ]);
    _playSequence([
      ToneData(0, 0.25, 'sine', 0),
      ToneData(800 * p, 0.02, 'square', 0.06),
      ToneData(1200 * p, 0.02, 'square', 0.05),
      ToneData(600 * p, 0.03, 'square', 0.04),
      ToneData(1000 * p, 0.02, 'square', 0.04),
      ToneData(900 * p, 0.03, 'square', 0.03),
    ]);
  }

  void playFirePillarSound(double pitch) {
    final p = pitch;
    _playTone(
      frequency: 100 * p,
      duration: 0.6,
      type: 'sawtooth',
      volume: 0.18,
      frequency2: 800 * p,
    );
    _playSequence([
      ToneData(300 * p, 0.06, 'square', 0.08),
      ToneData(500 * p, 0.06, 'square', 0.1),
      ToneData(700 * p, 0.08, 'square', 0.09),
      ToneData(900 * p, 0.1, 'sine', 0.08),
      ToneData(1100 * p, 0.12, 'sine', 0.06),
    ]);
  }

  void playLightningSound(double pitch) {
    final p = pitch;
    _playSequence([
      ToneData(2000 * p, 0.02, 'square', 0.06),
      ToneData(2500 * p, 0.02, 'square', 0.08),
      ToneData(3000 * p, 0.02, 'square', 0.1),
      ToneData(3500 * p, 0.01, 'square', 0.12),
    ]);
    _playSequence([
      ToneData(0, 0.08, 'sine', 0),
      ToneData(4000 * p, 0.02, 'square', 0.3),
      ToneData(100 * p, 0.05, 'sawtooth', 0.25),
    ]);
    _playSequence([
      ToneData(0, 0.15, 'sine', 0),
      ToneData(60 * p, 0.4, 'sawtooth', 0.2),
      ToneData(40 * p, 0.5, 'sawtooth', 0.12),
    ]);
  }

  void playRainbowSound(double pitch) {
    final p = pitch;
    _playSequence([
      ToneData(523.25 * p, 0.08, 'sine', 0.15),
      ToneData(587.33 * p, 0.08, 'sine', 0.15),
      ToneData(659.25 * p, 0.08, 'sine', 0.16),
      ToneData(698.46 * p, 0.08, 'sine', 0.17),
      ToneData(783.99 * p, 0.08, 'sine', 0.18),
      ToneData(880.00 * p, 0.08, 'sine', 0.19),
      ToneData(987.77 * p, 0.08, 'sine', 0.2),
      ToneData(1046.5 * p, 0.25, 'sine', 0.25),
    ]);
  }

  void playLiXiSound() {
    _playSequence([
      ToneData(2000, 0.04, 'sine', 0.12),
      ToneData(2500, 0.04, 'sine', 0.1),
      ToneData(3000, 0.03, 'sine', 0.08),
    ]);
    _playSequence([
      ToneData(0, 0.12, 'sine', 0),
      ToneData(880, 0.08, 'sine', 0.15),
      ToneData(1047, 0.08, 'sine', 0.18),
      ToneData(1175, 0.1, 'sine', 0.2),
      ToneData(1319, 0.15, 'sine', 0.15),
    ]);
  }

  void playLanternSound() {
    _playTone(
      frequency: 250,
      duration: 0.8,
      type: 'sine',
      volume: 0.06,
      frequency2: 150,
    );
    _playTone(
      frequency: 300,
      duration: 0.5,
      type: 'sine',
      volume: 0.04,
      frequency2: 200,
    );
  }

  void playShakeRumble(double pitch) {
    final p = pitch;
    _playTone(frequency: 40 * p, duration: 0.3, type: 'sawtooth', volume: 0.15);
    _playTone(frequency: 55 * p, duration: 0.2, type: 'sine', volume: 0.1);
  }

  void playHighScoreCelebration() {
    _playSequence([
      ToneData(523.25, 0.1, 'sine', 0.2),
      ToneData(659.25, 0.1, 'sine', 0.2),
      ToneData(783.99, 0.1, 'sine', 0.22),
      ToneData(1046.5, 0.15, 'sine', 0.25),
      ToneData(1318.5, 0.15, 'sine', 0.22),
      ToneData(1568.0, 0.2, 'sine', 0.2),
      ToneData(2093.0, 0.3, 'sine', 0.3),
    ]);
  }
}
