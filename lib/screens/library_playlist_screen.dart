import 'package:flutter/material.dart';

import '../data/song_data.dart';
import '../models/song.dart';
import 'player_screen.dart';

class LibraryPlaylistScreen extends StatefulWidget {
  const LibraryPlaylistScreen({
    super.key,
    required this.title,
    required this.statusCode,
  });

  final String title;
  final int statusCode;

  @override
  State<LibraryPlaylistScreen> createState() => _LibraryPlaylistScreenState();
}

class _LibraryPlaylistScreenState extends State<LibraryPlaylistScreen> {
  // =========================================================
  // STATE
  // =========================================================

  int selectedFilter = 0;

  bool isSearching = false;

  String searchText = '';

  final TextEditingController searchController =
      TextEditingController();

  // Store favourite songs by their index
  final Set<int> favouriteSongs = {};

  // =========================================================
  // GET SONGS
  // =========================================================

  List<Song> get librarySongs {
    return songsByStatus(widget.statusCode);
  }

  // =========================================================
  // FILTER SONGS
  // =========================================================

  List<Song> get filteredSongs {
    List<Song> songs = List<Song>.from(librarySongs);

    // Search
    if (searchText.trim().isNotEmpty) {
      final query = searchText.toLowerCase();

      songs = songs.where((song) {
        return song.title.toLowerCase().contains(query) ||
            song.artist.toLowerCase().contains(query);
      }).toList();
    }

    return songs;
  }

  // =========================================================
  // OPEN PLAYER
  // =========================================================

  void openSong(Song song) {
    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PlayerScreen(song: song),
      ),
    );
  }

  // =========================================================
  // TOGGLE FAVOURITE
  // =========================================================

  void toggleFavourite(Song song) {
    final wasFavorite = isSongFavorite(song);
    toggleFavoriteSong(song);

    setState(() {
      final nowFavorite = isSongFavorite(song);

      if (nowFavorite && !wasFavorite) {
        _showMessage('Added to favourites');
      } else if (!nowFavorite && wasFavorite) {
        _showMessage('Removed from favourites');
      }
    });
  }

  // =========================================================
  // MESSAGE
  // =========================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: Color(0xFF1ED760),
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF292929),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(
          16,
          0,
          16,
          16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        duration: const Duration(
          milliseconds: 1300,
        ),
      ),
    );
  }

  // =========================================================
  // SONG OPTIONS
  // =========================================================

  void showSongOptions(Song song) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF202020),
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              14,
              20,
              20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 22),

                // Song info
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        song.image,
                        width: 58,
                        height: 58,
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
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            song.artist,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                _buildBottomOption(
                  icon: Icons.play_circle_outline_rounded,
                  title: 'Play song',
                  onTap: () {
                    Navigator.pop(context);
                    openSong(song);
                  },
                ),

                _buildBottomOption(
                  icon: Icons.playlist_add_rounded,
                  title: 'Add to playlist',
                  onTap: () {
                    Navigator.pop(context);
                    _showMessage(
                      'Added to playlist',
                    );
                  },
                ),

                _buildBottomOption(
                  icon: Icons.share_outlined,
                  title: 'Share',
                  onTap: () {
                    Navigator.pop(context);
                    _showMessage(
                      'Share option selected',
                    );
                  },
                ),

                _buildBottomOption(
                  icon: Icons.info_outline_rounded,
                  title: 'View song details',
                  onTap: () {
                    Navigator.pop(context);
                    _showMessage(
                      'Song details',
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // =========================================================
  // BOTTOM SHEET OPTION
  // =========================================================

  Widget _buildBottomOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 8,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white70,
                size: 24,
              ),
              const SizedBox(width: 18),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // FILTER CHIP
  // =========================================================

  Widget _buildFilterChip({
    required String title,
    required int index,
  }) {
    final bool selected = selectedFilter == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 220,
        ),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF1ED760)
              : const Color(0xFF292929),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: selected
                ? const Color(0xFF1ED760)
                : Colors.white.withOpacity(0.06),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selected
                ? Colors.black
                : Colors.white70,
            fontSize: 13,
            fontWeight: selected
                ? FontWeight.w700
                : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // =========================================================
  // SEARCH HEADER
  // =========================================================

  Widget _buildHeader() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: isSearching
          ? Container(
              key: const ValueKey('search'),
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF292929),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 14),
                  const Icon(
                    Icons.search_rounded,
                    color: Colors.white54,
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      autofocus: true,
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      cursorColor: const Color(0xFF1ED760),
                      decoration: const InputDecoration(
                        hintText: 'Search your playlist',
                        hintStyle: TextStyle(
                          color: Colors.white38,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      searchController.clear();
                      setState(() {
                        searchText = '';
                        isSearching = false;
                      });
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            )
          : Row(
              key: const ValueKey('normal'),
              children: [
                IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isSearching = true;
                      });
                    },
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFF202020),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                        size: 23,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  // =========================================================
  // SONG CARD
  // =========================================================

  Widget _buildSongItem(
    Song song,
    int index,
  ) {
    final bool favourite = isSongFavorite(song);

    return TweenAnimationBuilder<double>(
      duration: Duration(
        milliseconds: 250 + (index * 50),
      ),
      tween: Tween(
        begin: 0,
        end: 1,
      ),
      curve: Curves.easeOut,
      builder: (
        context,
        value,
        child,
      ) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(
              20 * (1 - value),
              0,
            ),
            child: child,
          ),
        );
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            openSong(song);
          },
          borderRadius:
              BorderRadius.circular(18),
          splashColor:
              const Color(0xFF1ED760)
                  .withOpacity(0.08),
          highlightColor:
              Colors.white.withOpacity(0.025),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Row(
              children: [
                // =================================================
                // IMAGE
                // =================================================

                Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(13),
                      child: Image.asset(
                        song.image,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) {
                          return Container(
                            width: 70,
                            height: 70,
                            color:
                                const Color(0xFF292929),
                            child: const Icon(
                              Icons.music_note_rounded,
                              color: Colors.white54,
                              size: 28,
                            ),
                          );
                        },
                      ),
                    ),

                    // Small play icon
                    Positioned(
                      right: 5,
                      bottom: 5,
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.black
                              .withOpacity(0.70),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 14),

                // =================================================
                // SONG INFORMATION
                // =================================================

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        song.title,
                        maxLines: 1,
                        overflow:
                            TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 7),

                      Row(
                        children: [
                          // Lyrics badge
                          Container(
                            padding:
                                const EdgeInsets
                                    .symmetric(
                              horizontal: 7,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  Colors.white70,
                              borderRadius:
                                  BorderRadius
                                      .circular(4),
                            ),
                            child: const Text(
                              'LYRICS',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 9,
                                fontWeight:
                                    FontWeight.w800,
                                letterSpacing:
                                    0.3,
                              ),
                            ),
                          ),

                          const SizedBox(width: 7),

                          Expanded(
                            child: Text(
                              song.artist,
                              maxLines: 1,
                              overflow:
                                  TextOverflow
                                      .ellipsis,
                              style: const TextStyle(
                                color:
                                    Colors.white54,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // =================================================
                // FAVOURITE
                // =================================================

                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      toggleFavourite(song);
                    },
                    borderRadius:
                        BorderRadius.circular(20),
                    child: Padding(
                      padding:
                          const EdgeInsets.all(7),
                      child: AnimatedSwitcher(
                        duration: const Duration(
                          milliseconds: 200,
                        ),
                        transitionBuilder:
                            (child, animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: Icon(
                          favourite
                              ? Icons.favorite_rounded
                              : Icons
                                  .favorite_border_rounded,
                          key: ValueKey(favourite),
                          color: favourite
                              ? const Color(
                                  0xFF1ED760,
                                )
                              : Colors.white54,
                          size: 21,
                        ),
                      ),
                    ),
                  ),
                ),

                // =================================================
                // MORE
                // =================================================

                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      showSongOptions(song);
                    },
                    borderRadius:
                        BorderRadius.circular(20),
                    child: const Padding(
                      padding:
                          EdgeInsets.all(7),
                      child: Icon(
                        Icons.more_vert_rounded,
                        color: Colors.white70,
                        size: 23,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // EMPTY SEARCH
  // =========================================================

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 80,
      ),
      child: Column(
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: const Color(0xFF202020),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.search_off_rounded,
              color: Colors.white38,
              size: 35,
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'No songs found',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 7),

          const Text(
            'Try searching for another song or artist.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white38,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final songs = filteredSongs;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      body: SafeArea(
        child: CustomScrollView(
          physics:
              const BouncingScrollPhysics(),

          slivers: [
            // =================================================
            // TOP CONTENT
            // =================================================

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                20,
                18,
                20,
                30,
              ),
              sliver: SliverList(
                delegate:
                    SliverChildListDelegate([
                  _buildHeader(),

                  const SizedBox(height: 22),

                  if (songs.isNotEmpty)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${songs.length} songs',
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 12,
                        ),
                      ),
                    ),

                  const SizedBox(height: 12),
                ]),
              ),
            ),

            // =================================================
            // SONG LIST
            // =================================================

            if (songs.isEmpty)
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                sliver: SliverToBoxAdapter(
                  child: _buildEmptyState(),
                ),
              )
            else
              SliverPadding(
                padding:
                    const EdgeInsets.fromLTRB(
                  20,
                  0,
                  20,
                  100,
                ),
                sliver: SliverList(
                  delegate:
                      SliverChildBuilderDelegate(
                    (context, index) {
                      final song =
                          songs[index];

                      return _buildSongItem(
                        song,
                        index,
                      );
                    },
                    childCount:
                        songs.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}