import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../data/song.dart';
import '../repository/songs_repository.dart';

class PlaylistManager extends ChangeNotifier {
  final SongsRepository _songsRepository = GetIt.instance<SongsRepository>();
  late List<Song> _songs;

  PlaylistManager() {
    _songs = _songsRepository.getSongs();
  }

  List<Song> get songs => _songs;

  void updateSong(
    Song originalSong, {
    String? newTitle,
    String? newArtist,
    String? newAlbum,
    Duration? newDuration,
  }) {
    final index = _songs.indexOf(originalSong);
    if (index != -1) {
      final oldSong = _songs[index];
      _songs[index] = Song(
        title: newTitle ?? oldSong.title,
        artist: newArtist ?? oldSong.artist,
        album: newAlbum ?? oldSong.album,
        duration: newDuration ?? oldSong.duration,
        albumArtPath: oldSong.albumArtPath,
        isSelected: oldSong.isSelected,
      );

      notifyListeners();
    }
  }
}
