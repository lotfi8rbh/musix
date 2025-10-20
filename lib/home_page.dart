// lib/features/home/home_page.dart
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../data/song.dart';
import '../../repository/songs_repository.dart';

// Enum pour gérer le type de tri de manière claire
enum SortType { title, artist, duration }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SongsRepository songsRepository = GetIt.instance<SongsRepository>();

  late List<Song> _songs;
  // L'état du tri est maintenant un Set, comme requis par SegmentedButton
  SortType _sortType = SortType.title;

  @override
  void initState() {
    super.initState();
    _songs = songsRepository.getSongs();
    _sortSongs();
  }

  Duration get _totalDuration {
    return _songs
        .where((song) => song.isSelected)
        .fold(Duration.zero, (prev, song) => prev + song.duration);
  }

  void _sortSongs() {
    // La logique de tri reste la même
    switch (_sortType) {
      case SortType.title:
        _songs.sort((a, b) => a.title.compareTo(b.title));
        break;
      case SortType.artist:
        _songs.sort((a, b) => a.artist.compareTo(b.artist));
        break;
      case SortType.duration:
        _songs.sort((a, b) => a.duration.compareTo(b.duration));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Compose your playlist")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SECTION "SORT BY" (MISE À JOUR) ---
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Sort by", style: textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  // Le nouveau widget SegmentedButton
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
                    // Le `selected` attend un Set, même pour une sélection unique
                    selected: <SortType>{_sortType},
                    // `onSelectionChanged` remplace tous les `onChanged` individuels
                    onSelectionChanged: (Set<SortType> newSelection) {
                      setState(() {
                        // On prend le premier (et unique) élément du Set
                        _sortType = newSelection.first;
                        _sortSongs();
                      });
                    },
                  ),
                ],
              ),
            ),

            // --- LE RESTE DU CODE RESTE INCHANGÉ ---
            Text("Songs", style: textTheme.headlineSmall),
            const SizedBox(height: 8),

            Expanded(
              child: ListView.builder(
                // ... (votre code ListView.builder existant)
                itemCount: _songs.length,
                itemBuilder: (context, index) {
                  final song = _songs[index];
                  return CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text('${song.title} - ${song.artist}'),
                    secondary: Text(
                      '${song.duration.inMinutes}:${(song.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                    ),
                    value: song.isSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        song.isSelected = value ?? false;
                      });
                    },
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                // ... (votre code pour la durée totale et le bouton)
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total duration"),
                      Text("${_totalDuration.inMinutes} minutes"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _totalDuration == Duration.zero
                          ? null
                          : () {
                              // TODO: Gérer la navigation
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
