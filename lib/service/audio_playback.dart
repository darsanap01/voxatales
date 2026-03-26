import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> play(String audioPath) async {
    await _player.stop();
    await _player.play(AssetSource(audioPath));
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> stop() async {
    await _player.stop();
  }
  Future<void> pauseAudio() async {
  await _player.pause();
}

Future<void> seekForward() async {
  final Duration? currentPosition = await _player.getCurrentPosition();
  if (currentPosition != null) {
    await _player.seek(currentPosition + const Duration(seconds: 10));
  }
}

Future<void> seekBackward() async {
  final Duration? currentPosition = await _player.getCurrentPosition();
  if (currentPosition != null) {
    final Duration newPosition =
        currentPosition - const Duration(seconds: 10);

    await _player.seek(
      newPosition < Duration.zero ? Duration.zero : newPosition,
    );
  }
}

  void dispose() {
    _player.dispose();
  }
}