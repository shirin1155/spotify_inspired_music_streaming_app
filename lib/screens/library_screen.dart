import 'package:flutter/material.dart';

import '../data/song_data.dart';
import '../models/song.dart';
import 'library_playlist_screen.dart';
import 'player_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int selectedCategory = 0;

  final List<String> categories = [
    'Playlists',
    'Artists',
    'Albums',
    'Podcasts',
  ];

  void openSong(Song song) {
    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PlayerScreen(song: song),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 120),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 20),
                  _buildLibraryItem(
                    icon: Icons.favorite_rounded,
                    iconBackground: const LinearGradient(
                      colors: [
                        Color(0xFF5736E7),
                        Color(0xFFA8D7D7),
                      ],
                    ),
                    title: 'Favourite Songs',
                    subtitle: '${songsByStatus(favouriteStatusCode).length} songs',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LibraryPlaylistScreen(
                            title: 'Favourite Songs',
                            statusCode: favouriteStatusCode,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 34),
                  _buildLibraryItem(
                    icon: Icons.download_rounded,
                    iconBackground: const LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white,
                      ],
                    ),
                    iconColor: Colors.black,
                    title: 'Downloaded Songs',
                    subtitle: '${songsByStatus(downloadedStatusCode).length} songs',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LibraryPlaylistScreen(
                            title: 'Downloaded Songs',
                            statusCode: downloadedStatusCode,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 34),
                  _buildLibraryItem(
                    icon: Icons.fitness_center_rounded,
                    iconBackground: const LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                      ],
                    ),
                    title: 'Workout',
                    subtitle: '${songsByStatus(workoutStatusCode).length} songs',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LibraryPlaylistScreen(
                            title: 'Workout',
                            statusCode: workoutStatusCode,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 34),
                  _buildLibraryItem(
                    icon: Icons.directions_car_rounded,
                    iconBackground: const LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                      ],
                    ),
                    title: 'Driving',
                    subtitle: '${songsByStatus(drivingStatusCode).length} songs',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LibraryPlaylistScreen(
                            title: 'Driving',
                            statusCode: drivingStatusCode,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 115),
                  const Text(
                    'Based on your recent listening',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 26),
                  if (songs.isNotEmpty) _buildRecentSong(songs.first),
                  const SizedBox(height: 20),
                  if (songs.length > 1) _buildRecentSong(songs[1]),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLibraryItem({
    required IconData icon,
    required Gradient iconBackground,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color iconColor = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: iconBackground,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 34,
            ),
          ),
          const SizedBox(width: 34),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: Colors.white30,
            size: 28,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSong(Song song) {
    return GestureDetector(
      onTap: () => openSong(song),
      child: Container(
        height: 102,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF175C5B),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                song.image,
                width: 76,
                height: 76,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    song.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => openSong(song),
              icon: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 34,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
