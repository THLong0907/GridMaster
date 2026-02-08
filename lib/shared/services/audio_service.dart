import 'dart:js_interop';
import 'package:shared_preferences/shared_preferences.dart';

// Web Audio API bindings via dart:js_interop
@JS('AudioContext')
extension type JSAudioContext._(JSObject _) implements JSObject {
  external factory JSAudioContext();
  external JSAudioDestinationNode get destination;
  external double get currentTime;
  external JSOscillatorNode createOscillator();
  external JSGainNode createGain();
}

@JS()
extension type JSAudioDestinationNode._(JSObject _) implements JSObject {}

@JS()
extension type JSOscillatorNode._(JSObject _) implements JSObject {
  external JSAudioParam get frequency;
  external set type(String value);
  external void connect(JSObject destination);
  external void start([double when]);
  external void stop([double when]);
}

@JS()
extension type JSGainNode._(JSObject _) implements JSObject {
  external JSAudioParam get gain;
  external void connect(JSObject destination);
}

@JS()
extension type JSAudioParam._(JSObject _) implements JSObject {
  external void setValueAtTime(double value, double startTime);
  external void linearRampToValueAtTime(double value, double endTime);
}

/// Audio service using Web Audio API for sound effects
class AudioService {
  static AudioService? _instance;
  static AudioService get instance => _instance ??= AudioService._();

  bool _soundEnabled = true;
  bool get soundEnabled => _soundEnabled;

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

  /// Play a tone using Web Audio API
  void _playTone({
    required double frequency,
    required double duration,
    String type = 'sine',
    double volume = 0.3,
    double? frequency2,
  }) {
    if (!_soundEnabled) return;

    try {
      final ctx = JSAudioContext();
      final oscillator = ctx.createOscillator();
      final gainNode = ctx.createGain();

      oscillator.type = type;
      oscillator.frequency.setValueAtTime(frequency, ctx.currentTime);

      if (frequency2 != null) {
        oscillator.frequency.linearRampToValueAtTime(
          frequency2,
          ctx.currentTime + duration,
        );
      }

      gainNode.gain.setValueAtTime(volume, ctx.currentTime);
      gainNode.gain.linearRampToValueAtTime(0.0, ctx.currentTime + duration);

      oscillator.connect(gainNode as JSObject);
      gainNode.connect(ctx.destination as JSObject);

      oscillator.start(ctx.currentTime);
      oscillator.stop(ctx.currentTime + duration);
    } catch (_) {
      // Silently fail if audio not supported
    }
  }

  /// Play tones in sequence
  void _playSequence(List<_Tone> tones) {
    if (!_soundEnabled) return;

    try {
      final ctx = JSAudioContext();
      double t = ctx.currentTime;

      for (final tone in tones) {
        final osc = ctx.createOscillator();
        final gain = ctx.createGain();

        osc.type = tone.type;
        osc.frequency.setValueAtTime(tone.freq, t);

        gain.gain.setValueAtTime(tone.vol, t);
        gain.gain.linearRampToValueAtTime(0.0, t + tone.dur);

        osc.connect(gain as JSObject);
        gain.connect(ctx.destination as JSObject);

        osc.start(t);
        osc.stop(t + tone.dur);

        t += tone.dur * 0.75;
      }
    } catch (_) {}
  }

  // =================== GAME SOUNDS ===================

  void playPiecePlaced() {
    _playTone(frequency: 440, duration: 0.08, type: 'sine', volume: 0.15);
  }

  void playLineClear() {
    _playSequence([
      _Tone(523.25, 0.1, 'sine', 0.2),
      _Tone(659.25, 0.1, 'sine', 0.2),
      _Tone(783.99, 0.15, 'sine', 0.25),
    ]);
  }

  void playCombo(int lines) {
    final f = 523.25 + (lines * 100);
    _playSequence([
      _Tone(f, 0.08, 'square', 0.15),
      _Tone(f * 1.25, 0.08, 'square', 0.15),
      _Tone(f * 1.5, 0.08, 'square', 0.2),
      _Tone(f * 2, 0.2, 'sine', 0.25),
    ]);
  }

  void playGameOver() {
    _playSequence([
      _Tone(392.0, 0.2, 'sawtooth', 0.15),
      _Tone(330.0, 0.2, 'sawtooth', 0.15),
      _Tone(262.0, 0.3, 'sawtooth', 0.2),
      _Tone(196.0, 0.5, 'sine', 0.15),
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
      _Tone(200, 0.05, 'sawtooth', 0.2),
      _Tone(100, 0.15, 'sawtooth', 0.25),
    ]);
  }

  void playNewHighScore() {
    _playSequence([
      _Tone(523.25, 0.12, 'sine', 0.2),
      _Tone(659.25, 0.12, 'sine', 0.2),
      _Tone(783.99, 0.12, 'sine', 0.25),
      _Tone(1046.5, 0.3, 'sine', 0.3),
    ]);
  }

  // =================== EFFECT SOUNDS ===================

  /// 🎆 Firework: phụt launch → pause → BÙM explosion → xèo xèo crackle
  void playFireworkSound(double pitch) {
    final p = pitch;
    // Phase 1: Launch whoosh
    _playTone(frequency: 180 * p, duration: 0.08, type: 'sawtooth', volume: 0.15, frequency2: 400 * p);
    // Phase 2: BÙM explosion (after short pause)
    _playSequence([
      _Tone(0, 0.12, 'sine', 0), // silence gap
      _Tone(120 * p, 0.12, 'sawtooth', 0.28),
      _Tone(80 * p, 0.08, 'sawtooth', 0.22),
    ]);
    // Phase 3: Crackle (xèo xèo)
    _playSequence([
      _Tone(0, 0.3, 'sine', 0), // wait for explosion
      _Tone(1200 * p, 0.03, 'square', 0.08),
      _Tone(1800 * p, 0.02, 'square', 0.06),
      _Tone(1000 * p, 0.04, 'square', 0.07),
      _Tone(2000 * p, 0.03, 'square', 0.05),
      _Tone(1500 * p, 0.03, 'square', 0.06),
      _Tone(2200 * p, 0.04, 'square', 0.04),
    ]);
  }

  /// ✨ Sparkle: ting ting ting chime sequence
  void playSparkleSound(double pitch) {
    final p = pitch;
    _playSequence([
      _Tone(2400 * p, 0.06, 'sine', 0.1),
      _Tone(2800 * p, 0.06, 'sine', 0.08),
      _Tone(3200 * p, 0.06, 'sine', 0.07),
      _Tone(2600 * p, 0.08, 'sine', 0.06),
      _Tone(3400 * p, 0.06, 'sine', 0.05),
      _Tone(3000 * p, 0.08, 'sine', 0.04),
      _Tone(3600 * p, 0.1, 'sine', 0.03),
    ]);
  }

  /// 🌊 Shockwave: Deep BOOM bass → uuuuu expanding
  void playShockwaveSound(double pitch) {
    final p = pitch;
    // Deep BOOM
    _playTone(frequency: 60 * p, duration: 0.15, type: 'sine', volume: 0.3, frequency2: 30 * p);
    _playTone(frequency: 120 * p, duration: 0.08, type: 'sawtooth', volume: 0.2);
    // uuuuu expanding ring
    _playSequence([
      _Tone(0, 0.15, 'sine', 0), // after boom
      _Tone(200 * p, 0.5, 'sine', 0.1),
    ]);
    _playTone(frequency: 180 * p, duration: 0.6, type: 'sine', volume: 0.08, frequency2: 80 * p);
  }

  /// 💥 Explosion: Heavy BỤPP impact → lách cách debris
  void playExplosionSound(double pitch) {
    final p = pitch;
    // BỤPP heavy impact
    _playTone(frequency: 80 * p, duration: 0.12, type: 'sawtooth', volume: 0.35);
    _playSequence([
      _Tone(120 * p, 0.06, 'sawtooth', 0.3),
      _Tone(60 * p, 0.1, 'sawtooth', 0.25),
      _Tone(40 * p, 0.15, 'sine', 0.18),
    ]);
    // Debris sounds (lách cách)
    _playSequence([
      _Tone(0, 0.25, 'sine', 0), // wait
      _Tone(800 * p, 0.02, 'square', 0.06),
      _Tone(1200 * p, 0.02, 'square', 0.05),
      _Tone(600 * p, 0.03, 'square', 0.04),
      _Tone(1000 * p, 0.02, 'square', 0.04),
      _Tone(900 * p, 0.03, 'square', 0.03),
    ]);
  }

  /// 🔥 Fire Pillar: Rising whoosh
  void playFirePillarSound(double pitch) {
    final p = pitch;
    // Rising whoosh
    _playTone(frequency: 100 * p, duration: 0.6, type: 'sawtooth', volume: 0.18, frequency2: 800 * p);
    // Fire crackle overlay
    _playSequence([
      _Tone(300 * p, 0.06, 'square', 0.08),
      _Tone(500 * p, 0.06, 'square', 0.1),
      _Tone(700 * p, 0.08, 'square', 0.09),
      _Tone(900 * p, 0.1, 'sine', 0.08),
      _Tone(1100 * p, 0.12, 'sine', 0.06),
    ]);
  }

  /// ⚡ Lightning: tích tích buildup → CRACK strike → rùm rùm thunder
  void playLightningSound(double pitch) {
    final p = pitch;
    // Phase 1: tích tích charge up
    _playSequence([
      _Tone(2000 * p, 0.02, 'square', 0.06),
      _Tone(2500 * p, 0.02, 'square', 0.08),
      _Tone(3000 * p, 0.02, 'square', 0.1),
      _Tone(3500 * p, 0.01, 'square', 0.12),
    ]);
    // Phase 2: CRACK! (sharp strike after buildup)
    _playSequence([
      _Tone(0, 0.08, 'sine', 0), // short gap
      _Tone(4000 * p, 0.02, 'square', 0.3),
      _Tone(100 * p, 0.05, 'sawtooth', 0.25),
    ]);
    // Phase 3: Thunder rumble fade
    _playSequence([
      _Tone(0, 0.15, 'sine', 0), // gap
      _Tone(60 * p, 0.4, 'sawtooth', 0.2),
      _Tone(40 * p, 0.5, 'sawtooth', 0.12),
    ]);
  }

  /// 🌈 Rainbow: Do-Re-Mi-Fa-Sol-La-Si-Do ascending
  void playRainbowSound(double pitch) {
    final p = pitch;
    _playSequence([
      _Tone(523.25 * p, 0.08, 'sine', 0.15),
      _Tone(587.33 * p, 0.08, 'sine', 0.15),
      _Tone(659.25 * p, 0.08, 'sine', 0.16),
      _Tone(698.46 * p, 0.08, 'sine', 0.17),
      _Tone(783.99 * p, 0.08, 'sine', 0.18),
      _Tone(880.00 * p, 0.08, 'sine', 0.19),
      _Tone(987.77 * p, 0.08, 'sine', 0.2),
      _Tone(1046.5 * p, 0.25, 'sine', 0.25),
    ]);
  }

  /// 🧧 Lì xì: keng keng coin + spring melody
  void playLiXiSound() {
    // Coin sounds
    _playSequence([
      _Tone(2000, 0.04, 'sine', 0.12),
      _Tone(2500, 0.04, 'sine', 0.1),
      _Tone(3000, 0.03, 'sine', 0.08),
    ]);
    // Short spring melody
    _playSequence([
      _Tone(0, 0.12, 'sine', 0), // gap
      _Tone(880, 0.08, 'sine', 0.15),
      _Tone(1047, 0.08, 'sine', 0.18),
      _Tone(1175, 0.1, 'sine', 0.2),
      _Tone(1319, 0.15, 'sine', 0.15),
    ]);
  }

  /// 🏮 Lantern: soft whoosh wind
  void playLanternSound() {
    _playTone(frequency: 250, duration: 0.8, type: 'sine', volume: 0.06, frequency2: 150);
    _playTone(frequency: 300, duration: 0.5, type: 'sine', volume: 0.04, frequency2: 200);
  }

  /// 📳 Screen shake rumble
  void playShakeRumble(double pitch) {
    final p = pitch;
    _playTone(frequency: 40 * p, duration: 0.3, type: 'sawtooth', volume: 0.15);
    _playTone(frequency: 55 * p, duration: 0.2, type: 'sine', volume: 0.1);
  }

  /// 🎇 High score celebration fanfare
  void playHighScoreCelebration() {
    _playSequence([
      _Tone(523.25, 0.1, 'sine', 0.2),
      _Tone(659.25, 0.1, 'sine', 0.2),
      _Tone(783.99, 0.1, 'sine', 0.22),
      _Tone(1046.5, 0.15, 'sine', 0.25),
      _Tone(1318.5, 0.15, 'sine', 0.22),
      _Tone(1568.0, 0.2, 'sine', 0.2),
      _Tone(2093.0, 0.3, 'sine', 0.3),
    ]);
  }
}

class _Tone {
  final double freq;
  final double dur;
  final String type;
  final double vol;
  const _Tone(this.freq, this.dur, this.type, this.vol);
}
