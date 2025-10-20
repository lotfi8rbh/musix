import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
//
import 'screens/home_page.dart';
import 'screens/playlist_summary_page.dart';
import 'screens/song_details.dart';
import 'repository/songs_repository_dummy_impl.dart';
import 'repository/songs_repository.dart';

void main() {
  GetIt.instance.registerSingleton<SongsRepository>(SongsRepositoryDummyImpl());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Musix',
      theme: ThemeData(
        // Palette de couleurs principale
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        useMaterial3: true,

        textTheme: const TextTheme(
          // Style pour les titres de section comme "Sort by" et "Songs"
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),

          // Style pour le corps du texte (titres de chansons, etc.)
          bodyLarge: TextStyle(fontSize: 16),

          // Style pour le texte à côté des radios
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/songDetails': (context) => const SongDetails(),
        '/playlistSummary': (context) => const PlaylistSummaryPage(),
      },
    );
  }
}
