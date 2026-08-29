import 'package:just_audio/just_audio.dart';
import '../models/song.dart';

class AudioPlayerService {
  AudioPlayerService._();

  static final AudioPlayerService instance =
      AudioPlayerService._();

  final AudioPlayer player = AudioPlayer();

  Song? currentSong;

  Future<void> playSong(Song song) async {
    currentSong = song;

    await player.setUrl(song.audioUrl);
    await player.play();
  }

  Future<void> pause() async {
    await player.pause();
  }

  Future<void> resume() async {
    await player.play();
  }

  Future<void> seek(Duration position) async {
    await player.seek(position);
  }

  Future<void> stop() async {
    await player.stop();
    currentSong = null;
  }

  bool get isPlaying => player.playing;
}