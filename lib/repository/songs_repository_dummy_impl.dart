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
      ),
      Song(
        title: "Gimme shelter",
        artist: "Rolling Stones",
        duration: Duration(minutes: 4, seconds: 31),
        album: "Let It Bleed",
      ),
      Song(
        title: "Come Together",
        artist: "The Beatles",
        duration: Duration(minutes: 4, seconds: 19),
        album: "Abbey Road",
      ),
      Song(
        title: "Hotel California",
        artist: "Eagles",
        duration: Duration(minutes: 6, seconds: 30),
        album: "Hotel California",
      ),
      Song(
        title: "Bohemian Rhapsody",
        artist: "Queen",
        duration: Duration(minutes: 5, seconds: 55),
        album: "A Night at the Opera",
      ),
      Song(
        title: "Stairway to Heaven",
        artist: "Led Zeppelin",
        duration: Duration(minutes: 8, seconds: 2),
        album: "Led Zeppelin IV",
      ),
      Song(
        title: "Imagine",
        artist: "John Lennon",
        duration: Duration(minutes: 3, seconds: 3),
        album: "Imagine",
      ),
    ];
  }
}
