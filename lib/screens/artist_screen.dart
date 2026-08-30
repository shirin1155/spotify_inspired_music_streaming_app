import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../utils/responsive.dart';

import '../data/song_data.dart';
import '../models/song.dart';
import 'player_screen.dart';
import 'home_screen.dart';

class ArtistPage extends StatefulWidget {
  final String artistName;
  final String monthlyListeners;
  final String artistImage;
  final int statusCode;

  const ArtistPage({
    super.key,
    required this.artistName,
    required this.monthlyListeners,
    required this.artistImage,
    required this.statusCode,
  });

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  bool isFollowing = false;
  bool isPlaying = false;
  int? selectedSong;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0d0d0d),
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildHeader(),
              _buildPopularHeader(),
              _buildSongList(),
              const SliverToBoxAdapter(
                child: SizedBox(height: 130),
              ),
            ],
          ),

          // Mini player
          if (selectedSong != null)
            Positioned(
              left: 14,
              right: 14,
              bottom: 78,
              child: _buildMiniPlayer(),
            ),

          // Bottom navigation
          _buildBottomNavigation(),
        ],
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return SliverAppBar(
      expandedHeight: math.min(R.h(context, 535), MediaQuery.of(context).size.height * 0.6),
      pinned: true,
      backgroundColor: const Color(0xff0d0d0d),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 21,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert_rounded),
          onPressed: () {},
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              60,
              20,
              20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Artist image (use local logo asset)
                Hero(
                  tag: widget.artistImage,
                  child: Container(
                    width: math.min(R.w(context, 285), MediaQuery.of(context).size.width * 0.7),
                    height: math.min(R.w(context, 285), MediaQuery.of(context).size.width * 0.7),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.6),
                          blurRadius: 45,
                          spreadRadius: 8,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        widget.artistImage,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Container(
                            color: const Color(0xff242424),
                            child: const Icon(
                              Icons.person,
                              size: 90,
                              color: Colors.white54,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                SizedBox(height: R.h(context, 25)),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  widget.artistName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: R.sp(context, 34),
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -1,
                                  ),
                                ),
                              ),
                              SizedBox(width: R.w(context, 7)),
                              const Icon(
                                Icons.verified_rounded,
                                color: Color(0xff5e9eff),
                                size: 21,
                              ),
                            ],
                          ),
                          SizedBox(height: R.h(context, 6)),
                          Text(
                            widget.monthlyListeners,
                            style: TextStyle(
                              color: Color(0xffa3a3a3),
                              fontSize: R.sp(context, 15.5),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: R.w(context, 12)),

                    _followButton(),
                  ],
                ),

                SizedBox(height: R.h(context, 15)),

                Row(
                  children: [
                    _roundAction(
                      icon: Icons.favorite_border_rounded,
                      onTap: () {},
                    ),
                    SizedBox(width: R.w(context, 4)),
                    _roundAction(
                      icon: Icons.share_outlined,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // FOLLOW BUTTON
  // ============================================================

  Widget _followButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFollowing = !isFollowing;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(
          horizontal: 19,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: isFollowing
              ? const Color(0xffc8ff3d)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isFollowing
                ? const Color(0xffc8ff3d)
                : Colors.white54,
          ),
        ),
        child: Text(
          isFollowing ? 'Following' : 'Follow',
          style: TextStyle(
            color: isFollowing
                ? Colors.black
                : Colors.white,
            fontSize: R.sp(context, 14),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // POPULAR HEADER
  // ============================================================

  Widget _buildPopularHeader() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          20,
          20,
          20,
          8,
        ),
        child: Row(
          children: [
            Text(
              'Popular',
              style: TextStyle(
                color: Colors.white,
                fontSize: R.sp(context, 22),
                fontWeight: FontWeight.w700,
              ),
            ),

            const Spacer(),

            // Shuffle
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shuffle_rounded,
                color: Color(0xffc8ff3d),
                size: 25,
              ),
            ),

            SizedBox(width: R.w(context, 5)),

            // Play button
            Container(
              width: 49,
              height: 49,
              decoration: const BoxDecoration(
                color: Color(0xffc8ff3d),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.black,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SONG LIST
  // ============================================================

  Widget _buildSongList() {
    final List<Song> list = songsByStatus(widget.statusCode);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final song = list[index];

          return _songTile(
            song: song,
            index: index,
          );
        },
        childCount: list.length,
      ),
    );
  }

  Widget _songTile({
    required Song song,
    required int index,
  }) {
    final bool active = selectedSong == index;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (!mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PlayerScreen(song: song),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 17,
            vertical: 9,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 32,
                child: active && isPlaying
                    ? const Icon(
                        Icons.equalizer_rounded,
                        color: Color(0xffc8ff3d),
                        size: 21,
                      )
                    : Text(
                        '${index + 1}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff9a9a9a),
                          fontSize: R.sp(context, 17),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),

              SizedBox(width: R.w(context, 8)),

              // Song cover (use asset images)
              ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image.asset(
                  song.image,
                  width: R.w(context, 84),
                  height: R.h(context, 84),
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      width: R.w(context, 84),
                      height: R.h(context, 84),
                      color: const Color(0xff242424),
                      child: const Icon(
                        Icons.music_note_rounded,
                        color: Colors.white38,
                      ),
                    );
                  },
                ),
              ),

              SizedBox(width: R.w(context, 15)),

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
                        color: active
                            ? const Color(0xffc8ff3d)
                            : Colors.white,
                        fontSize: R.sp(context, 17),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: R.h(context, 7)),
                    Text(
                      song.artist,
                      style: TextStyle(
                        color: Color(0xff969696),
                        fontSize: R.sp(context, 14.5),
                      ),
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: () {
                  _showSongOptions(song);
                },
                icon: const Icon(
                  Icons.more_horiz_rounded,
                  color: Colors.white70,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MINI PLAYER
  // ============================================================

  Widget _buildMiniPlayer() {
    final list = songsByStatus(widget.statusCode);
    final song = list[selectedSong!];

    return Container(
      height: R.h(context, 67),
      decoration: BoxDecoration(
        color: const Color(0xff252525),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            blurRadius: 25,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(14),
            ),
            child: Image.asset(
              song.image,
              width: R.w(context, 67),
              height: R.h(context, 67),
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: R.w(context, 12)),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: R.sp(context, 14.5),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: R.h(context, 3)),
                Text(
                  widget.artistName,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: R.sp(context, 12),
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              setState(() {
                isPlaying = !isPlaying;
              });
            },
            icon: Icon(
              isPlaying
                  ? Icons.pause_circle_filled_rounded
                  : Icons.play_circle_fill_rounded,
              color: Colors.white,
              size: 36,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  Widget _buildBottomNavigation() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: R.h(context, 76),
        decoration: BoxDecoration(
          color: const Color(0xff111111),
          border: Border(
            top: BorderSide(
              color: Colors.white.withOpacity(.06),
            ),
          ),
        ),
          child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home_rounded, 'Home', true, 0),
            _navItem(Icons.search_rounded, 'Search', false, 1),
            _navItem(
              Icons.library_music_rounded,
              'Library',
              false,
              2,
            ),
            _navItem(
              Icons.person_rounded,
              'Profile',
              false,
              3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
    IconData icon,
    String label,
    bool active,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        if (!mounted) return;

        switch (index) {
          case 0:
          case 1:
          case 2:
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HomeScreen(initialIndex: index),
              ),
            );
            break;
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 25,
            color: active
                ? const Color(0xffc8ff3d)
                : Colors.white54,
          ),
          SizedBox(height: R.h(context, 4)),
          Text(
            label,
            style: TextStyle(
              color: active
                  ? Colors.white
                  : Colors.white54,
              fontSize: R.sp(context, 11),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SMALL ACTION BUTTON
  // ============================================================

  Widget _roundAction({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        icon,
        size: 27,
        color: Colors.white,
      ),
    );
  }

  // ============================================================
  // SONG OPTIONS
  // ============================================================

  void _showSongOptions(Song song) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xff202020),
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              22,
              8,
              22,
              25,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      song.image,
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 55,
                        height: 55,
                        color: const Color(0xff242424),
                      ),
                    ),
                  ),
                  title: Text(
                    song.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(widget.artistName),
                ),
                const Divider(color: Colors.white12),
                _option(Icons.favorite_border, 'Add to favorites'),
                _option(Icons.playlist_add, 'Add to playlist'),
                _option(Icons.share_outlined, 'Share'),
                _option(Icons.download_outlined, 'Download'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _option(IconData icon, String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.white),
      title: Text(title),
      onTap: () => Navigator.pop(context),
    );
  }
}

// ============================================================
// SONG MODEL — শুধু UI-এর জন্য
// ============================================================

// ArtistSong model removed — this screen now uses the project's `Song` model.
