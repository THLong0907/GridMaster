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
}

class _Tone {
  final double freq;
  final double dur;
  final String type;
  final double vol;
  const _Tone(this.freq, this.dur, this.type, this.vol);
}
