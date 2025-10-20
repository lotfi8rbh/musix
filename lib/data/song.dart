class Song {
  final String title;
  final String artist;
  final Duration duration;
  final String album;
  final String albumArtPath;
  bool isSelected;

  Song({
    required this.title,
    required this.artist,
    required this.duration,
    required this.album,
    required this.albumArtPath,
    this.isSelected = false,
  });
}
