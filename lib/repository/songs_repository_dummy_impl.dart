import '../data/song.dart';
import 'songs_repository.dart';

class SongsRepositoryDummyImpl implements SongsRepository {
  @override
  List<Song> getSongs() {
    return [
      Song(
        title: "Wish you were here",
        artist: "Pink Floyd",
        duration: Duration(minutes: 5, seconds: 30),
        album: "Wish You Were Here",
        albumArtPath: 'assets/Pink.jpg',
      ),
      Song(
        title: "Gimme shelter",
        artist: "Rolling Stones",
        duration: Duration(minutes: 4, seconds: 31),
        album: "Let It Bleed",
        albumArtPath: 'assets/LetitbleedRS.jpg',
      ),
      Song(
        title: "Come Together",
        artist: "The Beatles",
        duration: Duration(minutes: 4, seconds: 19),
        album: "Abbey Road",
        albumArtPath: 'assets/Beatles.jpg',
      ),
      Song(
        title: "Hotel California",
        artist: "Eagles",
        duration: Duration(minutes: 6, seconds: 30),
        album: "Hotel California",
        albumArtPath: 'assets/Hotel.jpg',
      ),
      Song(
        title: "Bohemian Rhapsody",
        artist: "Queen",
        duration: Duration(minutes: 5, seconds: 55),
        album: "A Night at the Opera",
        albumArtPath: 'assets/Bohemian.jpg',
      ),
      Song(
        title: "Stairway to Heaven",
        artist: "Led Zeppelin",
        duration: Duration(minutes: 8, seconds: 2),
        album: "Led Zeppelin IV",
        albumArtPath: 'assets/Led.jpg',
      ),
      Song(
        title: "Imagine",
        artist: "John Lennon",
        duration: Duration(minutes: 3, seconds: 3),
        album: "Imagine",
        albumArtPath: 'assets/Lennon.jpg',
      ),
    ];
  }
}
