class Song {
  final String title;
  final String artist;
  final String image;
  final String audioUrl;
  final String description;
  final List<int> statusCodes;

  const Song({
    required this.title,
    required this.artist,
    required this.image,
    required this.audioUrl,
    required this.description,
    required this.statusCodes,
  });
}