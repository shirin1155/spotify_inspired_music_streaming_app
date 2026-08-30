import 'package:flutter/material.dart';

import '../data/song_data.dart';
import '../models/song.dart';
import 'player_screen.dart';
import 'artist_screen.dart';
import 'library_playlist_screen.dart';
import '../utils/responsive.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController =
      TextEditingController();

  final FocusNode searchFocusNode = FocusNode();

  String searchQuery = '';

  final List<String> recentSearches = [
    'Pop',
    'Happy Hits',
    'Imagine Dragons',
  ];

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  void openSong(Song song) {
    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PlayerScreen(song: song),
      ),
    );
  }

  List<Song> get filteredSongs {
    if (searchQuery.trim().isEmpty) {
      return [];
    }

    final query = searchQuery.toLowerCase().trim();

    return songs.where((song) {
      return song.title.toLowerCase().contains(query) ||
          song.artist.toLowerCase().contains(query);
    }).toList();
  }

  void performSearch(String value) {
    setState(() {
      searchQuery = value;
    });
  }

  void useRecentSearch(String value) {
    searchController.text = value;

    setState(() {
      searchQuery = value;
    });

    searchFocusNode.requestFocus();
  }

  void clearSearch() {
    searchController.clear();

    setState(() {
      searchQuery = '';
    });

    searchFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSearching = searchQuery.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                20,
                30,
                20,
                120,
              ),

              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // =====================================================
                  // TITLE
                  // =====================================================

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Search',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: R.sp(context, 42),
                            fontWeight: FontWeight.w800,
                            letterSpacing: -1.5,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1ED760),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.workspace_premium_rounded,
                                size: R.w(context, 16),
                                color: Colors.black,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Premium',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: R.sp(context, 12),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: R.h(context, 28)),

                  // =====================================================
                  // SEARCH BOX
                  // =====================================================

                  Container(
                    height: R.h(context, 62),

                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(14),
                    ),

                    child: TextField(
                      controller: searchController,
                      focusNode: searchFocusNode,

                      onChanged: performSearch,

                        style: TextStyle(
                        color: Colors.black87,
                        fontSize: R.sp(context, 17),
                        fontWeight: FontWeight.w500,
                      ),

                      decoration: InputDecoration(
                        border: InputBorder.none,

                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Colors.black87,
                          size: R.w(context, 32),
                        ),

                        suffixIcon: isSearching
                            ? IconButton(
                                onPressed: clearSearch,
                                icon: const Icon(
                                  Icons.close_rounded,
                                  color: Colors.black54,
                                ),
                              )
                            : null,

                        hintText:
                            'Artists, songs, or podcasts',

                        hintStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),

                        contentPadding:
                            EdgeInsets.symmetric(
                          vertical: R.h(context, 18),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: R.h(context, 34)),

                  // =====================================================
                  // SEARCH RESULTS
                  // =====================================================

                  if (isSearching) ...[
                    Text(
                      filteredSongs.isEmpty
                          ? 'No results'
                          : 'Search results',

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: R.sp(context, 25),
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: R.h(context, 18)),

                    if (filteredSongs.isEmpty)
                      _buildNoResults()
                    else
                      ...filteredSongs.map(
                        (song) => _buildSongResult(song),
                      ),
                  ]

                  // =====================================================
                  // DEFAULT SEARCH SCREEN
                  // =====================================================

                  else ...[
                    _buildRecentSearches(),

                    SizedBox(height: R.h(context, 48)),

                    _buildPopularSongs(),

                    SizedBox(height: R.h(context, 24)),

                    _buildPopularArtists(),

                    SizedBox(height: R.h(context, 48)),

                    _buildBrowseAll(),
                  ],
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // RECENT SEARCHES
  // ===========================================================

  Widget _buildRecentSearches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent searches',
          style: TextStyle(
            color: Colors.white,
            fontSize: R.sp(context, 25),
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),

        SizedBox(height: R.h(context, 22)),

        Row(
          children: [
            Expanded(
              child: _buildRecentCard(
                title: 'Pop Mix',
                subtitle:
                    'Hey Violet, VÉRITÉ, Timeflies',
                icon: Icons.music_note_rounded,
                gradient: const [
                  Color(0xFF9C1F75),
                  Color(0xFF35175D),
                ],
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: _buildRecentCard(
                title: 'Happy Hits!',
                subtitle:
                    'Hits to boost your mood',
                icon: Icons.sentiment_satisfied_alt_rounded,
                gradient: const [
                  Color(0xFF2774E8),
                  Color(0xFF173B91),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> gradient,
  }) {
    return GestureDetector(
      onTap: () {
        // Map recent card titles to status codes and open playlist
        int code = topPicksStatusCode;

        final t = title.toLowerCase();
        if (t.contains('pop')) code = popMixStatusCode;
        else if (t.contains('happy')) code = happyHitsStatusCode;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LibraryPlaylistScreen(
              title: title,
              statusCode: code,
            ),
          ),
        );
      },

      child: Container(
        height: R.h(context, 175),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),

          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Icon(
                  icon,
                  color: Colors.white70,
                  size: R.w(context, 27),
                ),
              ),

              const Spacer(),

              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,

                style: TextStyle(
                  color: Colors.white,
                  fontSize: R.sp(context, 20),
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: R.h(context, 5)),

              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,

                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // POPULAR ARTISTS
  // ===========================================================

  Widget _buildPopularSongs() {
    // Show top 3 trending songs
    final artistSongs = songs
        .where((s) => s.statusCodes.contains(trendingNowStatusCode))
        .take(3)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Popular Songs',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 22),

        SizedBox(
          height: R.h(context, 125),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: artistSongs.map((song) {
              return GestureDetector(
                onTap: () => openSong(song),

                child: SizedBox(
                  width: 100,

                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: Image.asset(
                          song.image,
                          width: 92,
                          height: 92,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(height: 7),

                      Text(
                        song.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,

                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPopularArtists() {
    // Three promoted artists (Taylor Swift, J Fla, Katy Perry)
    final artists = [
      {
        'name': 'Taylor Swift',
        'image': 'assets/images/taylor_swift_logo.png',
        'code': taylorStatusCode,
      },
      {
        'name': 'J Fla',
        'image': 'assets/images/j_fla_logo.jpg',
        'code': jFlaStatusCode,
      },
      {
        'name': 'Katy Perry',
        'image': 'assets/images/katy_perry_logo.png',
        'code': katyStatusCode,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Popular Artists',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 22),

        SizedBox(
          height: R.h(context, 125),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: artists.map((a) {
              return GestureDetector(
                onTap: () {
                  final int code = a['code'] as int;
                  final list = songsByStatus(code);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ArtistPage(
                        artistName: a['name'] as String,
                        monthlyListeners: '${list.length} songs',
                        artistImage: a['image'] as String,
                        statusCode: code,
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  width: 100,
                  child: Column(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          a['image'] as String,
                          width: 92,
                          height: 92,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(height: 7),

                      Text(
                        a['name'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,

                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // ===========================================================
  // BROWSE ALL
  // ===========================================================

  Widget _buildBrowseAll() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Browse all',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: _buildBrowseCard(
                title: 'New Releases',
                color: const Color(0xFFE83A00),
                icon: Icons.album_rounded,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: _buildBrowseCard(
                title: 'Podcasts',
                color: const Color(0xFFE90062),
                icon: Icons.mic_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBrowseCard({
    required String title,
    required Color color,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () {
        int code = topPicksStatusCode;

        final t = title.toLowerCase();
        if (t.contains('new')) code = newReleaseStatusCode;
        else if (t.contains('podcast')) code = podcastStatusCode;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LibraryPlaylistScreen(
              title: title,
              statusCode: code,
            ),
          ),
        );
      },

      child: Container(
        height: R.h(context, 150),

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),

        child: Stack(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: R.sp(context, 20),
                fontWeight: FontWeight.w800,
              ),
            ),

            Positioned(
              right: -10,
              bottom: -10,

              child: Icon(
                icon,
                size: 75,
                color: Colors.white.withOpacity(.18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // SEARCH RESULT
  // ===========================================================

  Widget _buildSongResult(Song song) {
    return GestureDetector(
      onTap: () => openSong(song),

      child: Container(
        margin: const EdgeInsets.only(bottom: 12),

        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(12),
        ),

        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),

              child: Image.asset(
                song.image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    song.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    song.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.white54,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoResults() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 50,
      ),

      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            color: Colors.white38,
            size: 60,
          ),

          SizedBox(height: 15),

          Text(
            'Nothing found',
            style: TextStyle(
              color: Colors.white,
              fontSize: R.sp(context, 20),
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 6),

          Text(
            'Try searching for another song or artist',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white54,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}