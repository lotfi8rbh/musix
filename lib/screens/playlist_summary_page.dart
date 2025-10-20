import 'package:flutter/material.dart';
import '../../../data/song.dart';

class PlaylistSummaryPage extends StatelessWidget {
  const PlaylistSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // On récupère la liste des chansons sélectionnées passée en argument
    final List<Song> selectedSongs =
        ModalRoute.of(context)!.settings.arguments as List<Song>;

    return Scaffold(
      appBar: AppBar(title: const Text("Playlist")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. La liste des titres des chansons
            Expanded(
              child: ListView.builder(
                itemCount: selectedSongs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    // On n'affiche que le titre de la chanson
                    title: Text(selectedSongs[index].title),
                  );
                },
              ),
            ),

            // 2. Le bouton pour partager
            ElevatedButton(
              onPressed: () {
                // TODO: Logique pour le partage (prochaine étape)
              },
              child: const Text("Send to music app"),
            ),
            const SizedBox(height: 16),

            // 3. L'image décorative
            Image.asset('assets/note.png', height: 100),
          ],
        ),
      ),
    );
  }
}
