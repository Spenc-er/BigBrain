import 'package:audioplayers/audioplayers.dart';

class AudioSequencePlayer {
  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playSequence(String sequence) async {
    for (int i = 0; i < sequence.length; i++) {
      String audioFile = 'numbers_audio/number${sequence[i]}.mp3';
      await audioPlayer.play(AssetSource(audioFile));
      await audioPlayer.onPlayerComplete.first;
    }
  }

  void stop() {
    audioPlayer.stop();
  }
}
