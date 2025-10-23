// lib/features/home/home_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/song.dart';
import '../../../state/playlist_manager.dart';

// Enum pour gérer le type de tri de manière claire
enum SortType { title, artist, duration }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // L'état du tri est toujours géré localement dans cette page
  SortType _sortType = SortType.title;

  // La logique de tri est maintenant une fonction qui prend la liste en paramètre
  void _sortSongs(List<Song> songs) {
    switch (_sortType) {
      case SortType.title:
        songs.sort((a, b) => a.title.compareTo(b.title));
        break;
      case SortType.artist:
        songs.sort((a, b) => a.artist.compareTo(b.artist));
        break;
      case SortType.duration:
        songs.sort((a, b) => a.duration.compareTo(b.duration));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // On récupère le manager via Provider
    final playlistManager = context.watch<PlaylistManager>();

    // On récupère la liste des chansons depuis le manager
    final List<Song> songs = playlistManager.songs;

    // On trie la liste à chaque reconstruction
    _sortSongs(songs);

    final textTheme = Theme.of(context).textTheme;

    // Calcul de la durée totale basé sur la liste du manager
    final totalDuration = songs
        .where((song) => song.isSelected)
        .fold(Duration.zero, (prev, song) => prev + song.duration);

    return Scaffold(
      appBar: AppBar(title: const Text("Compose your playlist")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Sort by", style: textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  SegmentedButton<SortType>(
                    segments: const <ButtonSegment<SortType>>[
                      ButtonSegment(
                        value: SortType.title,
                        label: Text('title'),
                      ),
                      ButtonSegment(
                        value: SortType.artist,
                        label: Text('artist'),
                      ),
                      ButtonSegment(
                        value: SortType.duration,
                        label: Text('duration'),
                      ),
                    ],
                    selected: <SortType>{_sortType},
                    onSelectionChanged: (Set<SortType> newSelection) {
                      setState(() {
                        _sortType = newSelection.first;
                      });
                    },
                  ),
                ],
              ),
            ),
            Text("Songs", style: textTheme.headlineSmall),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  final song = songs[index];
                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/songDetails',
                        arguments: song,
                      );
                    },
                    leading: Checkbox(
                      value: song.isSelected,
                      onChanged: (bool? value) {
                        // On doit maintenant mettre à jour l'état dans le manager.
                        // Pour l'instant, on le fait directement :)
                        setState(() {
                          song.isSelected = value ?? false;
                        });
                      },
                    ),
                    title: Text('${song.title} - ${song.artist}'),
                    trailing: Text(
                      '${song.duration.inMinutes}:${(song.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total duration"),
                      Text("${totalDuration.inMinutes} minutes"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: totalDuration == Duration.zero
                          ? null
                          : () {
                              final List<Song> selectedSongs = songs
                                  .where((song) => song.isSelected)
                                  .toList();
                              Navigator.pushNamed(
                                context,
                                '/playlistSummary',
                                arguments: selectedSongs,
                              );
                            },
                      child: const Text("Let's go"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
