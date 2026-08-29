import 'package:flutter_test/flutter_test.dart';
import 'package:spotify_inspired_music_streaming_app/data/song_data.dart';

void main() {
  test('all songs use real audio mp3 URLs', () {
    final invalidSongs = songs.where(
      (song) => !song.audioUrl.toLowerCase().contains('.mp3'),
    );

    expect(invalidSongs, isEmpty,
        reason: 'Every song must point to an actual mp3 audio file.');
  });

  test('songs are assigned to their matching sections by status code', () {
    expect(
      songs.where((song) => song.statusCodes.contains(1)).isNotEmpty,
      isTrue,
    );
    expect(
      songs.where((song) => song.statusCodes.contains(2)).isNotEmpty,
      isTrue,
    );
    expect(
      songs.where((song) => song.statusCodes.contains(3)).isNotEmpty,
      isTrue,
    );
    expect(
      songs.where((song) => song.statusCodes.contains(favouriteStatusCode)).isNotEmpty,
      isTrue,
    );
    expect(
      songs.where((song) => song.statusCodes.contains(downloadedStatusCode)).isNotEmpty,
      isTrue,
    );

    final recentAndTrending = songs
        .where((song) => song.statusCodes.contains(1) && song.statusCodes.contains(2))
        .toList();
    final recentAndTopPicks = songs
        .where((song) => song.statusCodes.contains(1) && song.statusCodes.contains(3))
        .toList();

    expect(recentAndTrending, isNotEmpty);
    expect(recentAndTopPicks, isNotEmpty);
  });
}
