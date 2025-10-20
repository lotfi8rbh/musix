import '../data/song.dart';

abstract class SongsRepository {
  List<Song> getSongs();
}
