import '../models/song.dart';

const int recentlyPlayedStatusCode = 1;
const int trendingNowStatusCode = 2;
const int topPicksStatusCode = 3;
const int favouriteStatusCode = 4;
const int downloadedStatusCode = 5;
const int workoutStatusCode = 6;
const int drivingStatusCode = 7;
const int podcastStatusCode = 8;
const int popularArtistStatusCode = 9;
const int popMixStatusCode = 10;
const int happyHitsStatusCode = 11;
const int newReleaseStatusCode = 12;
const int taylorStatusCode = 13;
const int katyStatusCode = 14;
const int jFlaStatusCode = 15;

final Set<String> _favoriteSongKeys = <String>{};

String songKey(Song song) => '${song.title}::${song.artist}';

bool isSongFavorite(Song song) {
  return _favoriteSongKeys.contains(songKey(song)) ||
      song.statusCodes.contains(favouriteStatusCode);
}

void toggleFavoriteSong(Song song) {
  final key = songKey(song);

  if (_favoriteSongKeys.contains(key)) {
    _favoriteSongKeys.remove(key);
  } else {
    _favoriteSongKeys.add(key);
  }
}

List<Song> songsByStatus(int statusCode) {
  if (statusCode == favouriteStatusCode) {
    return songs.where((song) {
      return song.statusCodes.contains(favouriteStatusCode) ||
          _favoriteSongKeys.contains(songKey(song));
    }).toList();
  }

  return songs.where((song) => song.statusCodes.contains(statusCode)).toList();
}

const List<Song> songs = [
  Song(
    title: 'Anime Lofi',
    artist: 'Canyon City',
    image: 'assets/images/anime_lofi.png',
    audioUrl: 'https://github.com/shirin1155/music-app-tracks/raw/refs/heads/main/anime-lofi.mp3',
    description:
        'A nostalgic lofi track that starts with distant rain and vinyl noise, followed by a simple piano melody. Soft drums and warm bass gradually enter, creating the feeling of walking home alone under the moon after an emotional anime episode.',
    statusCodes: [
      recentlyPlayedStatusCode,
      trendingNowStatusCode,
      popMixStatusCode,
      taylorStatusCode,
      jFlaStatusCode,
      downloadedStatusCode,
    ],
  ),

  Song(
    title: 'Your Power',
    artist: 'Billie Eilish',
    image: 'assets/images/your_power.jpg',
    audioUrl: 'https://github.com/shirin1155/music-app-tracks/raw/refs/heads/main/Your%20Power.mp3',
    description:
        'A smooth and emotional track with soft vocals and a modern atmospheric sound.',
    statusCodes: [
      recentlyPlayedStatusCode,
      topPicksStatusCode,
      newReleaseStatusCode,
      favouriteStatusCode,
    ],
  ),

  Song(
    title: 'On My Way',
    artist: 'Alan Walker',
    image: 'assets/images/on_my_way.jpg',
    audioUrl: 'https://github.com/shirin1155/music-app-tracks/raw/refs/heads/main/On%20My%20Way%20Alan%20Walker%20128%20Kbps.mp3',
    description:
        'Music Composer: Alan Walker, Sabrina Carpenter, Julia Karlsson, Anton Rundberg, Jesper Borgen, Anders Fr�en, Gunnar Greve, Fredrik Bor',
    statusCodes: [
      trendingNowStatusCode,
      popularArtistStatusCode,
      topPicksStatusCode,
      workoutStatusCode,
    ],
  ),

  Song(
    title: 'lovely',
    artist: 'Billie Eilish, Khalid',
    image: 'assets/images/lovely-Billie-Eilish.jpg',
    audioUrl: 'https://github.com/shirin1155/music-app-tracks/raw/refs/heads/main/Lovely%20Billie%20Eilish%20128%20Kbps.mp3',
    description:
        'Music Composer: Finneas O"Connell, Billie Eilish O "Connell, Khalid Robinson',
    statusCodes: [
      recentlyPlayedStatusCode,
      trendingNowStatusCode,
      topPicksStatusCode,
      happyHitsStatusCode,
      favouriteStatusCode,
      drivingStatusCode,
    ],
  ),

  Song(
    title: 'Daily Mix 1',
    artist: 'Ayra Starr',
    image: 'assets/images/daily_mix.png',
    audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    description:
        'A fresh daily mix with energetic rhythms and a modern pop atmosphere.',
    statusCodes: [
      recentlyPlayedStatusCode,
      downloadedStatusCode,
      podcastStatusCode,
      taylorStatusCode,
      jFlaStatusCode,
      drivingStatusCode,
    ],
  ),

  Song(
    title: 'Believer',
    artist: 'Imagine Dragons',
    image: 'assets/images/believer.png',
    audioUrl: 'https://github.com/shirin1155/music-app-tracks/raw/refs/heads/main/Imagine_Dragon_-_Believer.mp3',
    description:
        'A powerful and energetic track with an intense rhythm and emotional vocals.',
    statusCodes: [
      trendingNowStatusCode,
      workoutStatusCode,
      jFlaStatusCode,
      favouriteStatusCode,
      podcastStatusCode,
    ],
  ),

  Song(
    title: 'Harley’s in Hawaii',
    artist: 'Katy Perry',
    image: 'assets/images/harleys.png',
    audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
    description:
        'A relaxed pop track with a tropical atmosphere and smooth production.',
    statusCodes: [
      popMixStatusCode,
      katyStatusCode,
      topPicksStatusCode,
      downloadedStatusCode,
      drivingStatusCode,
    ],
  ),

  Song(
    title: 'Cheap Thrills',
    artist: 'Sia',
    image: 'assets/images/cheap_thrills.png',
    audioUrl: 'https://github.com/shirin1155/music-app-tracks/raw/refs/heads/main/Cheap%20Thrills%20Sia.mp3',
    description:
        'An upbeat pop song with catchy rhythms and an energetic feel.',
    statusCodes: [
      trendingNowStatusCode,
      topPicksStatusCode,
      happyHitsStatusCode,
      katyStatusCode,
      favouriteStatusCode,
      workoutStatusCode,
    ],
  ),
  // (podcast example entries removed — leaving `podcastStatusCode` constant only)
];