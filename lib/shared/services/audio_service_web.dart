import 'dart:js_interop';

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

class ToneData {
  final double freq;
  final double dur;
  final String type;
  final double vol;
  const ToneData(this.freq, this.dur, this.type, this.vol);
}

/// Web Audio API implementation
class AudioServicePlatform {
  void playTone({
    required double frequency,
    required double duration,
    String type = 'sine',
    double volume = 0.3,
    double? frequency2,
  }) {
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

  void playSequence(List<ToneData> tones) {
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
}
