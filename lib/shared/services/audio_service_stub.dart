import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';

/// Mobile audio implementation using generated WAV temp files + audioplayers.
/// Players are created on-demand and released after playback to avoid
/// MediaPlayer polling spam when idle.
class AudioServicePlatform {
  String? _tempDir;

  AudioServicePlatform() {
    _tempDir = Directory.systemTemp.path;
  }

  /// Create a player, play the source, and auto-release after playback.
  Future<void> _playAndRelease(String filePath, double volume) async {
    final player = AudioPlayer();
    try {
      await player.setReleaseMode(ReleaseMode.stop);
      await player.play(
        DeviceFileSource(filePath),
        volume: volume.clamp(0.0, 1.0),
      );
      // Listen for completion to release resources
      player.onPlayerComplete.listen((_) async {
        await player.dispose();
        File(filePath).delete().catchError((_) => File(filePath));
      });
    } catch (_) {
      await player.dispose();
      File(filePath).delete().catchError((_) => File(filePath));
    }
  }

  void playTone({
    required double frequency,
    required double duration,
    String type = 'sine',
    double volume = 0.3,
    double? frequency2,
  }) {
    if (frequency <= 0 && frequency2 == null) return;
    _playToneAsync(
      frequency: frequency,
      duration: duration,
      type: type,
      volume: volume,
      frequency2: frequency2,
    );
  }

  Future<void> _playToneAsync({
    required double frequency,
    required double duration,
    required String type,
    required double volume,
    double? frequency2,
  }) async {
    try {
      final wavBytes = _generateWav(
        frequency: frequency,
        duration: duration,
        type: type,
        volume: volume,
        frequency2: frequency2,
      );

      final dir = _tempDir ?? Directory.systemTemp.path;
      final filePath = '$dir/tone_${DateTime.now().microsecondsSinceEpoch}.wav';
      final file = File(filePath);
      await file.writeAsBytes(wavBytes);

      await _playAndRelease(filePath, volume);
    } catch (_) {}
  }

  void playSequence(List<ToneData> tones) {
    _playSequenceAsync(tones);
  }

  Future<void> _playSequenceAsync(List<ToneData> tones) async {
    try {
      final wavBytes = _generateSequenceWav(tones);

      final dir = _tempDir ?? Directory.systemTemp.path;
      final filePath = '$dir/seq_${DateTime.now().microsecondsSinceEpoch}.wav';
      final file = File(filePath);
      await file.writeAsBytes(wavBytes);

      await _playAndRelease(filePath, 1.0);
    } catch (_) {}
  }

  /// Generate WAV for a single tone
  Uint8List _generateWav({
    required double frequency,
    required double duration,
    required String type,
    required double volume,
    double? frequency2,
  }) {
    const sampleRate = 22050;
    final numSamples = (sampleRate * duration).round();
    final samples = Float64List(numSamples);

    for (int i = 0; i < numSamples; i++) {
      final t = i / sampleRate;
      final progress = i / numSamples;

      final freq = frequency2 != null
          ? frequency + (frequency2 - frequency) * progress
          : frequency;

      // Fade-out envelope
      final envelope = volume * (1.0 - progress);
      samples[i] = _oscillate(freq, t, type) * envelope;
    }

    return _samplesToWav(samples, sampleRate);
  }

  /// Generate WAV for a sequence of tones merged
  Uint8List _generateSequenceWav(List<ToneData> tones) {
    const sampleRate = 22050;

    double totalDuration = 0;
    final offsets = <double>[];
    for (final tone in tones) {
      offsets.add(totalDuration);
      totalDuration += tone.dur * 0.75;
    }
    if (tones.isNotEmpty) {
      totalDuration += tones.last.dur * 0.25;
    }

    final numSamples = (sampleRate * totalDuration).round();
    final samples = Float64List(numSamples);

    for (int ti = 0; ti < tones.length; ti++) {
      final tone = tones[ti];
      final offset = offsets[ti];
      final startSample = (offset * sampleRate).round();
      final toneSamples = (tone.dur * sampleRate).round();

      for (int i = 0; i < toneSamples; i++) {
        final idx = startSample + i;
        if (idx >= numSamples) break;

        final t = i / sampleRate;
        final progress = i / toneSamples;
        final envelope = tone.vol * (1.0 - progress);

        samples[idx] += _oscillate(tone.freq, t, tone.type) * envelope;
      }
    }

    // Clamp
    for (int i = 0; i < numSamples; i++) {
      samples[i] = samples[i].clamp(-1.0, 1.0);
    }

    return _samplesToWav(samples, sampleRate);
  }

  double _oscillate(double frequency, double t, String type) {
    if (frequency <= 0) return 0.0;
    final phase = frequency * t;

    switch (type) {
      case 'square':
        return (sin(2 * pi * phase) >= 0) ? 1.0 : -1.0;
      case 'sawtooth':
        return 2.0 * (phase % 1.0) - 1.0;
      case 'triangle':
        final v = (phase % 1.0);
        return v < 0.5 ? (4.0 * v - 1.0) : (3.0 - 4.0 * v);
      case 'sine':
      default:
        return sin(2 * pi * phase);
    }
  }

  /// Convert float samples to WAV (16-bit PCM mono)
  Uint8List _samplesToWav(Float64List samples, int sampleRate) {
    final numSamples = samples.length;
    const bitsPerSample = 16;
    const numChannels = 1;
    final byteRate = sampleRate * numChannels * bitsPerSample ~/ 8;
    final blockAlign = numChannels * bitsPerSample ~/ 8;
    final dataSize = numSamples * blockAlign;
    final fileSize = 36 + dataSize;

    final buffer = ByteData(44 + dataSize);
    int offset = 0;

    // RIFF header
    buffer.setUint8(offset++, 0x52); // R
    buffer.setUint8(offset++, 0x49); // I
    buffer.setUint8(offset++, 0x46); // F
    buffer.setUint8(offset++, 0x46); // F
    buffer.setUint32(offset, fileSize, Endian.little);
    offset += 4;
    buffer.setUint8(offset++, 0x57); // W
    buffer.setUint8(offset++, 0x41); // A
    buffer.setUint8(offset++, 0x56); // V
    buffer.setUint8(offset++, 0x45); // E

    // fmt chunk
    buffer.setUint8(offset++, 0x66); // f
    buffer.setUint8(offset++, 0x6D); // m
    buffer.setUint8(offset++, 0x74); // t
    buffer.setUint8(offset++, 0x20); // space
    buffer.setUint32(offset, 16, Endian.little);
    offset += 4;
    buffer.setUint16(offset, 1, Endian.little); // PCM
    offset += 2;
    buffer.setUint16(offset, numChannels, Endian.little);
    offset += 2;
    buffer.setUint32(offset, sampleRate, Endian.little);
    offset += 4;
    buffer.setUint32(offset, byteRate, Endian.little);
    offset += 4;
    buffer.setUint16(offset, blockAlign, Endian.little);
    offset += 2;
    buffer.setUint16(offset, bitsPerSample, Endian.little);
    offset += 2;

    // data chunk
    buffer.setUint8(offset++, 0x64); // d
    buffer.setUint8(offset++, 0x61); // a
    buffer.setUint8(offset++, 0x74); // t
    buffer.setUint8(offset++, 0x61); // a
    buffer.setUint32(offset, dataSize, Endian.little);
    offset += 4;

    // PCM samples
    for (int i = 0; i < numSamples; i++) {
      final sample = (samples[i] * 32767).round().clamp(-32768, 32767);
      buffer.setInt16(offset, sample, Endian.little);
      offset += 2;
    }

    return buffer.buffer.asUint8List();
  }
}

class ToneData {
  final double freq;
  final double dur;
  final String type;
  final double vol;
  const ToneData(this.freq, this.dur, this.type, this.vol);
}
