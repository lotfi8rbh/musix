import 'package:flutter/material.dart';
import '../../../data/song.dart'; // Assurez-vous que le chemin est correct

class SongDetails extends StatelessWidget {
  const SongDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. RÉCUPÉRATION DE LA CHANSON
    final song = ModalRoute.of(context)!.settings.arguments as Song;

    return Scaffold(
      appBar: AppBar(
        // Le titre de la page est le nom de la chanson
        title: Text(song.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 2. IMAGE DE L'ALBUM
              Center(
                child: Image.asset(
                  '../../assets/Letitbleed.jpg',
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),

              // 3. CHAMPS DE TEXTE AVEC LABELS
              TextFormField(
                initialValue: song.title,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: song.artist,
                decoration: const InputDecoration(labelText: 'Artist'),
              ),
              const SizedBox(height: 16),

              TextFormField(
                initialValue: song.album,
                decoration: const InputDecoration(labelText: 'Album'),
              ),
              const SizedBox(height: 16),

              TextFormField(
                initialValue:
                    '${song.duration.inMinutes}:${(song.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                decoration: const InputDecoration(labelText: 'Duration'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
