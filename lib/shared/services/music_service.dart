import 'dart:async';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'audio_service.dart';

/// Background music service — generates ambient procedural music
/// Uses the existing AudioServicePlatform for tone generation
class MusicService {
  MusicService._();
  static final instance = MusicService._();

  bool _enabled = true;
  bool _isPlaying = false;
  Timer? _melodyTimer;
  final Random _rng = Random();

  bool get isEnabled => _enabled;
  bool get isPlaying => _isPlaying;

  /// Pentatonic scale notes for calm ambient music (octave 4-5)
  static const List<double> _scale = [
    261.63, // C4
    293.66, // D4
    329.63, // E4
    392.00, // G4
    440.00, // A4
    523.25, // C5
    587.33, // D5
    659.25, // E5
  ];

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _enabled = prefs.getBool('music_enabled') ?? true;
  }

  Future<void> setEnabled(bool value) async {
    _enabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('music_enabled', value);
    if (!value) {
      stop();
    }
  }

  /// Start playing ambient background music
  void play() {
    if (!_enabled || _isPlaying) return;
    _isPlaying = true;
    _scheduleNextNote();
  }

  /// Stop background music
  void stop() {
    _isPlaying = false;
    _melodyTimer?.cancel();
    _melodyTimer = null;
  }

  void _scheduleNextNote() {
    if (!_isPlaying || !_enabled) return;

    // Play a calm note
    final note = _scale[_rng.nextInt(_scale.length)];
    final duration = 0.4 + _rng.nextDouble() * 0.6; // 0.4-1.0s
    final volume = 0.04 + _rng.nextDouble() * 0.03; // Very quiet: 0.04-0.07

    AudioService.instance.playTonePublic(
      frequency: note,
      duration: duration,
      type: 'sine',
      volume: volume,
    );

    // Sometimes play a harmony note
    if (_rng.nextDouble() > 0.6) {
      final harmony = _scale[_rng.nextInt(_scale.length)];
      AudioService.instance.playTonePublic(
        frequency: harmony,
        duration: duration * 0.8,
        type: 'sine',
        volume: volume * 0.6,
      );
    }

    // Schedule next note with variable timing (1-3 seconds apart for calm feel)
    final delayMs = 1500 + _rng.nextInt(2000);
    _melodyTimer = Timer(Duration(milliseconds: delayMs), _scheduleNextNote);
  }

  void dispose() {
    stop();
  }
}
