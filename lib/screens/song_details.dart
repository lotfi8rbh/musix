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
  late Song song;
  late TextEditingController _titleController;
  late TextEditingController _artistController;
  late TextEditingController _albumController;
  late TextEditingController
  _durationController; // <-- CONTRÔLEUR POUR LA DURÉE
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      song = ModalRoute.of(context)!.settings.arguments as Song;

      _titleController = TextEditingController(text: song.title);
      _artistController = TextEditingController(text: song.artist);
      _albumController = TextEditingController(text: song.album);

      // On initialise le contrôleur de durée avec le bon format "minutes:secondes"
      final String durationString =
          '${song.duration.inMinutes}:${(song.duration.inSeconds % 60).toString().padLeft(2, '0')}';
      _durationController = TextEditingController(text: durationString);

      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _artistController.dispose();
    _albumController.dispose();
    _durationController.dispose(); // <-- N'OUBLIEZ PAS DE LE DISPOSE
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
              // ... (Image.asset, etc.)
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
              // --- CHAMP DURÉE MAINTENANT MODIFIABLE ---
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(
                  labelText: 'Duration (mm:ss)',
                ),
                keyboardType:
                    TextInputType.datetime, // Affiche un clavier adapté
                onChanged: (newDurationText) {
                  // On essaie de convertir le texte en Duration
                  try {
                    final parts = newDurationText.split(':');
                    if (parts.length == 2) {
                      final minutes = int.parse(parts[0]);
                      final seconds = int.parse(parts[1]);
                      final newDuration = Duration(
                        minutes: minutes,
                        seconds: seconds,
                      );
                      playlistManager.updateSong(
                        song,
                        newDuration: newDuration,
                      );
                    }
                  } catch (e) {
                    // Si le format est incorrect (ex: "5:abc"), on ne fait rien
                    // On pourrait afficher un message d'erreur ici
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
