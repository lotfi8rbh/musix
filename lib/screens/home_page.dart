// lib/features/home/home_page.dart
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../data/song.dart';
import '../../../repository/songs_repository.dart';

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
                        _sortSongs();
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
                itemCount: _songs.length,
                itemBuilder: (context, index) {
                  final song = _songs[index];
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
                              final List<Song> selectedSongs = _songs
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
