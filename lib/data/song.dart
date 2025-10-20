class Song {
  final String title;
  final String artist;
  final Duration duration;
  final String album;
  bool isSelected;

  Song({
    required this.title,
    required this.artist,
    required this.duration,
    required this.album,
    this.isSelected = false,
  });
}
