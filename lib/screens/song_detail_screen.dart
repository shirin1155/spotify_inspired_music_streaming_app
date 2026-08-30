import 'package:flutter/material.dart';

import '../utils/responsive.dart';

import '../models/song.dart';

class SongDetailScreen extends StatelessWidget {
  final Song song;

  const SongDetailScreen({
    super.key,
    required this.song,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.fromLTRB(28, 15, 28, 40),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),

                  Expanded(
                    child: Center(
                      child: Text(
                        'About the Song',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 48),
                ],
              ),

              SizedBox(height: R.h(context, 65)),

              ClipRRect(
                borderRadius:
                    BorderRadius.circular(18),

                child: Image.asset(
                  song.image,
                  width: double.infinity,
                  height: R.h(context, 430),
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(height: R.h(context, 42)),

              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        Text(
                          song.title,

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: R.sp(context, 31),
                          ),
                        ),

                        SizedBox(height: R.h(context, 8)),

                        Text(
                          song.artist,

                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: R.sp(context, 23),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 42,
                  ),
                ],
              ),

              SizedBox(height: R.h(context, 45)),

              Text(
                song.description,

                style: TextStyle(
                  color: Colors.white,
                  fontSize: R.sp(context, 17),
                  height: 1.55,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}