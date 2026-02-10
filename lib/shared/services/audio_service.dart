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

  /// Public tone method for external use (e.g. MusicService)
  void playTonePublic({
    required double frequency,
    required double duration,
    String type = 'sine',
    double volume = 0.3,
    double? frequency2,
  }) {
    _playTone(
      frequency: frequency,
      duration: duration,
      type: type,
      volume: volume,
      frequency2: frequency2,
    );
  }

  // =================== GAME SOUNDS ===================
  // Satisfying brick-like sounds — impactful and crunchy

  /// Solid brick placement — heavy thud with subtle click
  void playPiecePlaced() {
    // Impact thud
    _playTone(frequency: 150, duration: 0.08, type: 'triangle', volume: 0.35);
    // Click on top
    _playTone(frequency: 800, duration: 0.03, type: 'sine', volume: 0.20);
    // Sub-bass weight
    _playTone(frequency: 60, duration: 0.06, type: 'sine', volume: 0.25);
  }

  /// Smashing bricks — crunchy break + glass shatter + satisfying sweep
  void playLineClear() {
    // Brick crunch impact
    _playTone(frequency: 120, duration: 0.06, type: 'sawtooth', volume: 0.30);
    // Glass shatter sparkle
    _playSequence([
      ToneData(1200, 0.04, 'square', 0.18),
      ToneData(1800, 0.03, 'square', 0.15),
      ToneData(2400, 0.03, 'sine', 0.12),
      ToneData(1500, 0.03, 'square', 0.10),
    ]);
    // Satisfying rising sweep
    _playTone(
      frequency: 300,
      duration: 0.25,
      type: 'sine',
      volume: 0.25,
      frequency2: 900,
    );
  }

  /// Combo — escalating smash, each hit bigger
  void playCombo(int lines) {
    final impact = 100.0 + (lines * 20);
    final sparkle = 800.0 + (lines * 200);
    // Heavy impact
    _playTone(frequency: impact, duration: 0.06, type: 'sawtooth', volume: 0.35);
    // Escalating sparkle shatter
    _playSequence([
      ToneData(sparkle, 0.04, 'square', 0.20),
      ToneData(sparkle * 1.3, 0.04, 'sine', 0.22),
      ToneData(sparkle * 1.6, 0.04, 'sine', 0.24),
      ToneData(sparkle * 2.0, 0.06, 'sine', 0.26),
    ]);
    // Power sweep
    _playTone(
      frequency: 200 + (lines * 50),
      duration: 0.3,
      type: 'sine',
      volume: 0.28,
      frequency2: 1000 + (lines * 100),
    );
  }

  /// Game Over — heavy but not harsh, descending weight
  void playGameOver() {
    _playSequence([
      ToneData(400, 0.15, 'triangle', 0.30),
      ToneData(300, 0.20, 'triangle', 0.25),
      ToneData(200, 0.25, 'sine', 0.22),
      ToneData(100, 0.45, 'sine', 0.18),
    ]);
  }

  /// Button tap — crisp click
  void playButtonTap() {
    _playTone(frequency: 900, duration: 0.04, type: 'sine', volume: 0.18);
    _playTone(frequency: 450, duration: 0.03, type: 'triangle', volume: 0.10);
  }

  /// Timer warning — urgent ping
  void playTimerWarning() {
    _playTone(frequency: 880, duration: 0.06, type: 'triangle', volume: 0.20);
  }

  /// Auto drop — whoosh down with weight
  void playAutoDrop() {
    _playTone(
      frequency: 500,
      duration: 0.2,
      type: 'sawtooth',
      volume: 0.20,
      frequency2: 150,
    );
    _playTone(frequency: 80, duration: 0.08, type: 'triangle', volume: 0.25);
  }

  /// Rising row — rumble up
  void playRisingRow() {
    _playTone(
      frequency: 100,
      duration: 0.3,
      type: 'triangle',
      volume: 0.22,
      frequency2: 500,
    );
    _playTone(frequency: 60, duration: 0.15, type: 'sine', volume: 0.18);
  }

  /// Hammer smash — heavy impact crack
  void playHammer() {
    _playTone(frequency: 80, duration: 0.05, type: 'sawtooth', volume: 0.35);
    _playSequence([
      ToneData(200, 0.04, 'square', 0.25),
      ToneData(100, 0.10, 'triangle', 0.30),
    ]);
  }

  /// New high score — triumphant fanfare with sparkle
  void playNewHighScore() {
    _playSequence([
      ToneData(523.25, 0.10, 'sine', 0.25),
      ToneData(659.25, 0.10, 'sine', 0.28),
      ToneData(783.99, 0.10, 'sine', 0.30),
      ToneData(1046.50, 0.20, 'sine', 0.35),
    ]);
    // Sparkle overlay
    _playSequence([
      ToneData(0, 0.35, 'sine', 0),
      ToneData(1500, 0.05, 'sine', 0.15),
      ToneData(2000, 0.05, 'sine', 0.12),
      ToneData(2500, 0.05, 'sine', 0.10),
    ]);
  }

  // =================== EFFECT SOUNDS ===================
  // Impactful but not harsh — satisfying brick-game effects

  void playFireworkSound(double pitch) {
    final p = pitch;
    // Launch whoosh
    _playTone(
      frequency: 150 * p,
      duration: 0.10,
      type: 'sawtooth',
      volume: 0.20,
      frequency2: 600 * p,
    );
    // Explosion burst
    _playSequence([
      ToneData(0, 0.08, 'sine', 0),
      ToneData(100 * p, 0.10, 'sawtooth', 0.30),
      ToneData(70 * p, 0.08, 'sawtooth', 0.22),
    ]);
    // Sparkle crackle
    _playSequence([
      ToneData(0, 0.25, 'sine', 0),
      ToneData(1200 * p, 0.03, 'square', 0.10),
      ToneData(1800 * p, 0.03, 'sine', 0.08),
      ToneData(1000 * p, 0.04, 'square', 0.08),
      ToneData(2000 * p, 0.03, 'sine', 0.06),
      ToneData(1500 * p, 0.03, 'square', 0.07),
    ]);
  }

  void playSparkleSound(double pitch) {
    final p = pitch;
    _playSequence([
      ToneData(2000 * p, 0.05, 'sine', 0.15),
      ToneData(2400 * p, 0.05, 'sine', 0.13),
      ToneData(2800 * p, 0.04, 'sine', 0.12),
      ToneData(2200 * p, 0.05, 'sine', 0.11),
      ToneData(3000 * p, 0.04, 'sine', 0.10),
      ToneData(2600 * p, 0.05, 'sine', 0.08),
      ToneData(3200 * p, 0.06, 'sine', 0.07),
    ]);
  }

  void playShockwaveSound(double pitch) {
    final p = pitch;
    // Heavy bass thump
    _playTone(
      frequency: 60 * p,
      duration: 0.15,
      type: 'sine',
      volume: 0.35,
      frequency2: 30 * p,
    );
    // Impact crack
    _playTone(
      frequency: 120 * p,
      duration: 0.08,
      type: 'sawtooth',
      volume: 0.25,
    );
    // Rumble tail
    _playSequence([
      ToneData(0, 0.12, 'sine', 0),
      ToneData(200 * p, 0.4, 'sine', 0.12),
    ]);
    _playTone(
      frequency: 180 * p,
      duration: 0.5,
      type: 'sine',
      volume: 0.10,
      frequency2: 80 * p,
    );
  }

  void playExplosionSound(double pitch) {
    final p = pitch;
    // Heavy crunch
    _playTone(
      frequency: 80 * p,
      duration: 0.12,
      type: 'sawtooth',
      volume: 0.35,
    );
    // Debris burst
    _playSequence([
      ToneData(120 * p, 0.06, 'sawtooth', 0.30),
      ToneData(60 * p, 0.10, 'sawtooth', 0.25),
      ToneData(40 * p, 0.15, 'sine', 0.18),
    ]);
    // Shatter fragments
    _playSequence([
      ToneData(0, 0.20, 'sine', 0),
      ToneData(800 * p, 0.03, 'square', 0.10),
      ToneData(1200 * p, 0.03, 'square', 0.08),
      ToneData(600 * p, 0.03, 'square', 0.07),
      ToneData(1000 * p, 0.03, 'square', 0.06),
    ]);
  }

  void playFirePillarSound(double pitch) {
    final p = pitch;
    // Rising roar
    _playTone(
      frequency: 100 * p,
      duration: 0.5,
      type: 'sawtooth',
      volume: 0.22,
      frequency2: 800 * p,
    );
    // Crackling ascend
    _playSequence([
      ToneData(300 * p, 0.06, 'square', 0.12),
      ToneData(500 * p, 0.06, 'square', 0.14),
      ToneData(700 * p, 0.07, 'sine', 0.12),
      ToneData(900 * p, 0.08, 'sine', 0.10),
      ToneData(1100 * p, 0.10, 'sine', 0.08),
    ]);
  }

  void playLightningSound(double pitch) {
    final p = pitch;
    // Electric zap
    _playSequence([
      ToneData(2000 * p, 0.02, 'square', 0.12),
      ToneData(2500 * p, 0.02, 'square', 0.15),
      ToneData(3000 * p, 0.02, 'square', 0.18),
      ToneData(3500 * p, 0.01, 'square', 0.15),
    ]);
    // Strike
    _playSequence([
      ToneData(0, 0.06, 'sine', 0),
      ToneData(4000 * p, 0.02, 'square', 0.30),
      ToneData(100 * p, 0.05, 'sawtooth', 0.25),
    ]);
    // Thunder rumble
    _playSequence([
      ToneData(0, 0.12, 'sine', 0),
      ToneData(60 * p, 0.4, 'sawtooth', 0.20),
      ToneData(40 * p, 0.5, 'sawtooth', 0.12),
    ]);
  }

  void playRainbowSound(double pitch) {
    final p = pitch;
    // Bright ascending scale
    _playSequence([
      ToneData(523.25 * p, 0.07, 'sine', 0.20),
      ToneData(587.33 * p, 0.07, 'sine', 0.21),
      ToneData(659.25 * p, 0.07, 'sine', 0.22),
      ToneData(783.99 * p, 0.07, 'sine', 0.23),
      ToneData(880.00 * p, 0.07, 'sine', 0.24),
      ToneData(987.77 * p, 0.07, 'sine', 0.25),
      ToneData(1046.50 * p, 0.07, 'sine', 0.26),
      ToneData(1174.66 * p, 0.15, 'sine', 0.28),
    ]);
  }

  void playLiXiSound() {
    // Coin sparkle
    _playSequence([
      ToneData(2000, 0.04, 'sine', 0.15),
      ToneData(2500, 0.04, 'sine', 0.12),
      ToneData(3000, 0.03, 'sine', 0.10),
    ]);
    // Lucky chime
    _playSequence([
      ToneData(0, 0.10, 'sine', 0),
      ToneData(880, 0.07, 'sine', 0.20),
      ToneData(1047, 0.07, 'sine', 0.22),
      ToneData(1175, 0.08, 'sine', 0.24),
      ToneData(1319, 0.12, 'sine', 0.20),
    ]);
  }

  void playLanternSound() {
    _playTone(
      frequency: 250,
      duration: 0.6,
      type: 'sine',
      volume: 0.10,
      frequency2: 150,
    );
    _playTone(
      frequency: 300,
      duration: 0.4,
      type: 'sine',
      volume: 0.08,
      frequency2: 200,
    );
  }

  void playShakeRumble(double pitch) {
    final p = pitch;
    // Heavy rumble
    _playTone(frequency: 40 * p, duration: 0.3, type: 'sawtooth', volume: 0.25);
    _playTone(frequency: 55 * p, duration: 0.2, type: 'sine', volume: 0.18);
  }

  void playHighScoreCelebration() {
    // Big triumphant fanfare
    _playSequence([
      ToneData(523.25, 0.08, 'sine', 0.25),
      ToneData(659.25, 0.08, 'sine', 0.27),
      ToneData(783.99, 0.08, 'sine', 0.29),
      ToneData(1046.5, 0.12, 'sine', 0.32),
      ToneData(1318.5, 0.12, 'sine', 0.28),
      ToneData(1568.0, 0.15, 'sine', 0.26),
      ToneData(2093.0, 0.25, 'sine', 0.35),
    ]);
  }
}
