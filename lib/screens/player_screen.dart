import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../data/song_data.dart';
import '../models/song.dart';
import '../services/audio_player_service.dart';
import 'song_detail_screen.dart';

class PlayerScreen extends StatefulWidget {
  final Song song;

  const PlayerScreen({
    super.key,
    required this.song,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final audio = AudioPlayerService.instance;
  late Song _currentSong;

  bool get _isBuffering {
    final state = audio.player.processingState;
    return state == ProcessingState.loading ||
        state == ProcessingState.buffering;
  }

  @override
  void initState() {
    super.initState();
    _currentSong = widget.song;
    _loadSong(_currentSong);
  }

  Future<void> _loadSong(Song song) async {
    try {
      await audio.stop();
      await audio.playSong(song);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Could not play ${song.title}. Please check your connection.',
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  Future<void> _changeSong(int step) async {
    final currentIndex = songs.indexWhere(
      (song) =>
          song.title == _currentSong.title &&
          song.artist == _currentSong.artist,
    );

    if (currentIndex == -1) return;

    final nextIndex = (currentIndex + step + songs.length) % songs.length;
    final nextSong = songs[nextIndex];

    setState(() {
      _currentSong = nextSong;
    });

    await _loadSong(nextSong);
  }

  @override
  void dispose() {
    audio.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: StreamBuilder<Duration>(
          stream: audio.player.positionStream,
          builder: (context, snapshot) {
            final position = snapshot.data ?? Duration.zero;

            return StreamBuilder<Duration?>(
              stream: audio.player.durationStream,
              builder: (context, durationSnapshot) {
                final duration = durationSnapshot.data ?? Duration.zero;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await audio.stop();
                              if (!mounted) return;
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 400),
                                switchInCurve: Curves.easeInOut,
                                switchOutCurve: Curves.easeInOut,
                                child: Text(
                                  'playing ${_currentSong.title}',
                                  key: ValueKey(_currentSong.title),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SongDetailScreen(
                                    song: _currentSong,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 70),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        switchInCurve: Curves.easeInOut,
                        switchOutCurve: Curves.easeInOut,
                        child: Stack(
                          key: ValueKey(_currentSong.title + _currentSong.artist),
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.asset(
                                _currentSong.image,
                                width: double.infinity,
                                height: 430,
                                fit: BoxFit.cover,
                              ),
                            ),
                            StreamBuilder<ProcessingState>(
                              stream: audio.player.processingStateStream,
                              builder: (context, stateSnapshot) {
                                final isBuffering = _isBuffering;

                                if (!isBuffering) {
                                  return const SizedBox.shrink();
                                }

                                return Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.45),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 45),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        switchInCurve: Curves.easeInOut,
                        switchOutCurve: Curves.easeInOut,
                        child: Row(
                          key: ValueKey(_currentSong.title + _currentSong.artist),
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _currentSong.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 31,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _currentSong.artist,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 23,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                toggleFavoriteSong(_currentSong);
                                setState(() {});
                              },
                              child: Icon(
                                isSongFavorite(_currentSong)
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                color: isSongFavorite(_currentSong)
                                    ? const Color(0xFF1ED760)
                                    : Colors.white,
                                size: 42,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 45),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 5,
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 8,
                          ),
                        ),
                        child: Slider(
                          value: duration.inMilliseconds == 0
                              ? 0
                              : position.inMilliseconds
                                  .clamp(0, duration.inMilliseconds)
                                  .toDouble(),
                          max: duration.inMilliseconds == 0
                              ? 1
                              : duration.inMilliseconds.toDouble(),
                          activeColor: Colors.white,
                          inactiveColor: Colors.white24,
                          onChanged: (value) {
                            audio.player.seek(
                              Duration(milliseconds: value.toInt()),
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _format(position),
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            _format(duration),
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      StreamBuilder<bool>(
                        stream: audio.player.playingStream,
                        builder: (context, snapshot) {
                          final playing = snapshot.data ?? false;

                          return StreamBuilder<ProcessingState>(
                            stream: audio.player.processingStateStream,
                            builder: (context, stateSnapshot) {
                              final isBuffering = _isBuffering;

                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: isBuffering ? null : () => _changeSong(-1),
                                    child: const Icon(
                                      Icons.skip_previous,
                                      color: Colors.white,
                                      size: 42,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: isBuffering
                                        ? null
                                        : () {
                                            if (playing) {
                                              audio.pause();
                                            } else {
                                              audio.resume();
                                            }
                                          },
                                    child: Container(
                                      width: 82,
                                      height: 82,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: isBuffering
                                          ? const Center(
                                              child: SizedBox(
                                                width: 24,
                                                height: 24,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 3,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          : Icon(
                                              playing
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
                                              color: Colors.black,
                                              size: 45,
                                            ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: isBuffering ? null : () => _changeSong(1),
                                    child: const Icon(
                                      Icons.skip_next,
                                      color: Colors.white,
                                      size: 42,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  String _format(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(1, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}