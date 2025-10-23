import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
import 'screens/home_page.dart';
import 'screens/playlist_summary_page.dart';
import 'screens/song_details.dart';
import 'repository/songs_repository_dummy_impl.dart';
import 'repository/songs_repository.dart';
import './state/playlist_manager.dart';

void main() {
  // On garde GetIt pour l'injection initiale du repository dans le manager
  GetIt.instance.registerSingleton<SongsRepository>(SongsRepositoryDummyImpl());

  runApp(
    // On enveloppe toute l'application dans le ChangeNotifierProvider
    // pour que le PlaylistManager soit accessible partout.
    ChangeNotifierProvider(
      create: (context) => PlaylistManager(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Musix',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),

      // Définition de la route de démarrage et de toutes les routes de l'application
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/songDetails': (context) => const SongDetails(),
        '/playlistSummary': (context) => const PlaylistSummaryPage(),
      },
    );
  }
}
