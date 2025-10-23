// lib/features/details/song_details.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/song.dart';
import '../../../state/playlist_manager.dart';

class SongDetails extends StatefulWidget {
  const SongDetails({super.key});

  @override
  State<SongDetails> createState() => _SongDetailsState();
}

class _SongDetailsState extends State<SongDetails> {
  // On déclare les variables ici pour qu'elles soient accessibles dans toute la classe
  late Song song;
  late TextEditingController _titleController;
  late TextEditingController _artistController;
  late TextEditingController _albumController;
  bool _isInitialized =
      false; // Une sécurité pour n'initialiser qu'une seule fois

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // On vérifie si les données ont déjà été initialisées
    if (!_isInitialized) {
      // C'est ici qu'on peut utiliser le context en toute sécurité
      song = ModalRoute.of(context)!.settings.arguments as Song;

      // On initialise les contrôleurs avec les données de la chanson
      _titleController = TextEditingController(text: song.title);
      _artistController = TextEditingController(text: song.artist);
      _albumController = TextEditingController(text: song.album);

      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _artistController.dispose();
    _albumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playlistManager = context.read<PlaylistManager>();

    return Scaffold(
      appBar: AppBar(title: Text(_titleController.text)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  song.albumArtPath,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (newTitle) {
                  playlistManager.updateSong(song, newTitle: newTitle);
                  setState(() {});
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _artistController,
                decoration: const InputDecoration(labelText: 'Artist'),
                onChanged: (newArtist) {
                  playlistManager.updateSong(song, newArtist: newArtist);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _albumController,
                decoration: const InputDecoration(labelText: 'Album'),
                onChanged: (newAlbum) {
                  playlistManager.updateSong(song, newAlbum: newAlbum);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue:
                    '${song.duration.inMinutes}:${(song.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                decoration: const InputDecoration(labelText: 'Duration'),
                enabled: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
