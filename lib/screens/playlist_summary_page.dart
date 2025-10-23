import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../../data/song.dart';

class PlaylistSummaryPage extends StatelessWidget {
  const PlaylistSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Song> selectedSongs =
        ModalRoute.of(context)!.settings.arguments as List<Song>;

    return Scaffold(
      appBar: AppBar(title: const Text("Playlist")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: selectedSongs.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(selectedSongs[index].title));
                },
              ),
            ),

            ElevatedButton(
              onPressed: () {
                // On prépare la chaîne de caractères à partager
                final songTitles = selectedSongs
                    .map((song) => song.title)
                    .toList();
                final String textToShare = songTitles.join('\n');

                Share.share(textToShare, subject: 'My Awesome Playlist');
              },
              child: const Text("Send to music app"),
            ),
            const SizedBox(height: 16),

            Image.asset('assets/note.png', height: 100),
          ],
        ),
      ),
    );
  }
}
