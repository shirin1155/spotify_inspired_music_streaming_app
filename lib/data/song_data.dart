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
      favouriteStatusCode,
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
   Song(
    title: 'Let Me Down Slowly',
    artist: 'J.Fla',
    image: 'assets/images/let_me_down_jfla.jpg',
    audioUrl: 'https://github.com/shirin1155/music-app-tracks/raw/refs/heads/main/Alec%20Benjamin%20-%20Let%20Me%20Down%20Slowly%20(%20cover%20by%20J.Fla%20).mp3',
    description:
        'A smooth and emotional track with soft vocals and a modern atmospheric sound.',
    statusCodes: [
      jFlaStatusCode,
    ],
  ),

 Song(
    title: 'Let Me Love You & Faded (MASHUP)',
    artist: 'J.Fla',
    image: 'assets/images/let_me_love_faded.jpg',
    audioUrl: 'https://github.com/shirin1155/music-app-tracks/raw/refs/heads/main/Jfla/Let%20Me%20Love%20You%20&%20Faded%20(%20MASHUP%20cover%20by%20J.Fla%20).mp3',
    description:
        'A smooth and emotional track with soft vocals and a modern atmospheric sound.',
    statusCodes: [
      jFlaStatusCode,
    ],
  ),

 Song(
    title: 'Camila Cabello - Havana',
    artist: 'J.Fla',
    image: 'assets/images/camila_Cabello_Havana_jfla.jpg',
    audioUrl: 'https://github.com/shirin1155/music-app-tracks/raw/refs/heads/main/Jfla/Camila%20Cabello%20-%20Havana%20(%20cover%20by%20J.Fla%20).mp3',
    description:
        'A smooth and emotional track with soft vocals and a modern atmospheric sound.',
    statusCodes: [
      jFlaStatusCode,
    ],
  ),
 


Song(
    title: 'Cheap Thrills',
    artist: 'J.Fla',
    image: 'assets/images/cheap_thrills_jfla.jpg',
    audioUrl: 'https://github.com/shirin1155/music-app-tracks/raw/refs/heads/main/Cheap%20Thrills%20Down%20(%20cover%20by%20J.Fla%20).mp3',
    description:
        'A smooth and emotional track with soft vocals and a modern atmospheric sound.',
    statusCodes: [
      jFlaStatusCode,
    ],
  ),

 Song(
    title: 'Eminem - Love The Way You Lie',
    artist: 'J.Fla',
    image: 'assets/images/love_the_way_jfla.jpg',
    audioUrl: 'https://github.com/shirin1155/music-app-tracks/raw/refs/heads/main/Jfla/Eminem%20-%20Love%20The%20Way%20You%20Lie%20ft.%20Rihanna%20(%20cover%20by%20J.Fla%20).mp3',
    description:
        'A smooth and emotional track with soft vocals and a modern atmospheric sound.',
    statusCodes: [
      jFlaStatusCode,
    ],
  ),

 Song(
    title: 'Look What You Made Me Do',
    artist: 'Taylor Swift',
    image: 'assets/images/look_what_tailor.jpg',
    audioUrl: 'https://github.com/shirin1155/music-app-tracks/raw/refs/heads/main/taylor/Taylor%20Swift%20-%20Look%20What%20You%20Made%20Me%20Do.mp3',
    description:
        'A smooth and emotional track with soft vocals and a modern atmospheric sound.',
    statusCodes: [
      taylorStatusCode,
    ],
  ),

 Song(
    title: 'Blank Space',
    artist: 'Taylor Swift',
    image: 'assets/images/taylor_blank_space.jpg',
    audioUrl: 'https://github.com/shirin1155/music-app-tracks/raw/refs/heads/main/taylor/Taylor%20Swift%20-%20Blank%20Space.mp3',
    description:
        'A smooth and emotional track with soft vocals and a modern atmospheric sound.',
    statusCodes: [
      taylorStatusCode,
    ],
  ),
 Song(
    title: 'Love Story',
    artist: 'Taylor Swift',
    image: 'assets/images/taylor_love_story.jpg',
    audioUrl: 'https://github.com/shirin1155/music-app-tracks/raw/refs/heads/main/taylor/Taylor%20Swift%20-%20Love%20Story.mp3',
    description:
        'A smooth and emotional track with soft vocals and a modern atmospheric sound.',
    statusCodes: [
      taylorStatusCode,
    ],
  ),

 Song(
    title: 'Roar',
    artist: 'Katy Perry',
    image: 'assets/images/katy_roar.jpg',
    audioUrl: 'https://github.com/shirin1155/music-app-tracks/raw/refs/heads/main/katy_perry/Katy%20Perry%20-%20Roar.mp3',
    description:
        'A smooth and emotional track with soft vocals and a modern atmospheric sound.',
    statusCodes: [
      katyStatusCode,
    ],
  ),


 Song(
    title: 'Bon Appétit',
    artist: 'Katy Perry',
    image: 'assets/images/katy_bon.jpg',
    audioUrl: 'https://github.com/shirin1155/music-app-tracks/raw/refs/heads/main/katy_perry/Katy%20Perry%20-%20Bon%20App%C3%A9tit%20(Official)%20ft.%20Migos.mp3',
    description:
        'A smooth and emotional track with soft vocals and a modern atmospheric sound.',
    statusCodes: [
      katyStatusCode,
    ],
  ),
 Song(
    title: 'Unconditionally',
    artist: 'Katy Perry',
    image: 'assets/images/katy_unconditional.jpg',
    audioUrl: 'https://github.com/shirin1155/music-app-tracks/raw/refs/heads/main/katy_perry/Katy%20Perry%20-%20Unconditionally%20(Official).mp3',
    description:
        'A smooth and emotional track with soft vocals and a modern atmospheric sound.',
    statusCodes: [
      katyStatusCode,
    ],
  ),

 Song(
    title: 'All The Stars',
    artist: 'SZA',
    image: 'assets/images/all_the_star_sza.jpg',
    audioUrl: 'https://github.com/shirin1155/music-app-tracks/raw/refs/heads/main/playlist/Kendrick%20Lamar,%20SZA%20-%20All%20The%20Stars.mp3',
    description: 'A smooth and emotional track with soft vocals and a modern atmospheric sound.',
    statusCodes: [
      topPicksStatusCode,
      newReleaseStatusCode,
      popularArtistStatusCode,
      workoutStatusCode,
    ],
  ),

  Song(
    title: 'Another Love',
    artist: 'Tom Odell',
    image: 'assets/images/another_love.jpg',
    audioUrl: 'https://github.com/shirin1155/music-app-tracks/raw/refs/heads/main/playlist/Tom%20Odell%20-%20Another%20Love%20(Official%20Video).mp3',
    description: 'A smooth and emotional track with soft vocals and a modern atmospheric sound.',
    statusCodes: [
      recentlyPlayedStatusCode,
      topPicksStatusCode,
      favouriteStatusCode,
      trendingNowStatusCode,
      popMixStatusCode,
      drivingStatusCode,
    ],
  ),

  Song(
    title: 'On The Floor',
    artist: 'Jennifer Lopez, Pitbull',
    image: 'assets/images/on_the_floor.jpg',
    audioUrl: 'https://github.com/shirin1155/music-app-tracks/raw/refs/heads/main/playlist/Jennifer%20Lopez,%20Pitbull%20-%20On%20The%20Floor%20(Official%20Music%20Video).mp3',
    description: 'A smooth and emotional track with soft vocals and a modern atmospheric sound.',
    statusCodes: [popMixStatusCode],
  ),

  Song(
    title: 'Change Your Brain',
    artist: 'Dr. Andrew Huberman',
    image: 'assets/images/change_your_brain.jpg',
    audioUrl: 'https://github.com/shirin1155/music-app-tracks/raw/refs/heads/main/playlist/15%20Minutes%20of%20Podcasts%20That%20Beat%2015%20Self-Help%20Books.mp3',
    description: 'A smooth and emotional track with soft vocals and a modern atmospheric sound.',
    statusCodes: [podcastStatusCode],
  ),

  // (podcast example entries removed — leaving `podcastStatusCode` constant only)
];