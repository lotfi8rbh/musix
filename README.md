# Musix - Compositeur de Playlist

Ce projet a été réalisé dans le cadre du cours "Approche comparative des technologies mobiles" (Master 2 SIME). Il s'agit d'une application mobile développée avec Flutter permettant de composer, modifier et partager des playlists à partir d'une liste de chansons prédéfinie.

## Fonctionnalités

-   [x] **Affichage de la liste de chansons** : La page d'accueil présente la liste complète des chansons disponibles.
-   [x] **Tri dynamique** : L'utilisateur peut trier la liste des chansons par **titre**, **artiste** ou **durée**.
-   [x] **Sélection multiple** : Les chansons peuvent être sélectionnées ou désélectionnées via des cases à cocher.
-   [x] **Calcul de la durée totale** : La durée totale de la playlist en cours de composition est affichée et mise à jour en temps réel.
-   [x] **Navigation vers les détails** : Un clic sur une chanson mène à un écran de détails.
-   [x] **Modification des informations** : L'écran de détails contient des champs de texte permettant de modifier le **titre**, l'**artiste**, l'**album** et la **durée** de la chanson.
-   [x] **Récapitulatif de la playlist** : Le bouton "Let's go" mène à une page de résumé affichant les titres de la playlist finale.
-   [x] **Partage de la playlist** : Le bouton "Send to music app" permet de partager la liste des titres sous forme de texte avec d'autres applications (messagerie, notes, etc.) via la fonctionnalité de partage native du téléphone.

---

## Architecture et Choix Techniques

L'architecture de ce projet a été fortement inspirée par les concepts et les bonnes pratiques présentés en cours.

### 1. Gestion de l'État (`State Management`)

Pour gérer l'état de l'application de manière centralisée et réactive, nous avons utilisé le package **`Provider`** avec un **`ChangeNotifier`**.

-   **`PlaylistManager` (`ChangeNotifier`)** : Cette classe agit comme la **source de vérité unique** (`single source of truth`) pour la liste des chansons. Elle contient la liste et les méthodes pour la modifier (ex: `updateSong`).
-   **`notifyListeners()`** : Lorsqu'une chanson est modifiée dans l'écran de détails, cette méthode est appelée pour notifier les widgets "auditeurs".
-   **`context.watch<T>()`** : La page d'accueil (`HomePage`) utilise cette méthode pour s'abonner aux changements du `PlaylistManager` et se reconstruire automatiquement, garantissant que les modifications sont visibles immédiatement après être revenu de la page de détails.

### 2. Séparation des Responsabilités (Repository Pattern)

Pour découpler la logique d'accès aux données de l'interface utilisateur, le **Repository Pattern** a été mis en œuvre.

-   **`SongsRepository`** (classe abstraite) : Définit le contrat pour l'accès aux données.
-   **`SongsRepositoryDummyImpl`** (implémentation) : Fournit une liste de chansons statiques pour le développement.

### 3. Navigation

La navigation entre les écrans est gérée à l'aide de **routes nommées** (`named routes`).

-   **`main.dart`** : Le fichier principal déclare toutes les routes de l'application (`/`, `/songDetails`, `/playlistSummary`).
-   **`Navigator.pushNamed()`** : Cette méthode est utilisée pour déclencher la navigation, en passant des objets (`Song` ou `List<Song>`) en tant qu'arguments.
-   **`ModalRoute.of(context)`** : Les écrans de destination récupèrent les arguments passés via cette méthode.

---

## Structure du Projet

Le code source est organisé par fonctionnalités pour une meilleure lisibilité et maintenabilité.
```
lib/
├── data/
│ └── song.dart # Le modèle de données pour une chanson
├── repository/
│ ├── songs_repository.dart # L'interface du repository
│ └── songs_repository_dummy_impl.dart # L'implémentation statique
├── screens/
│ ├── home_page.dart # L'écran principal (liste des chansons)
│ ├── playlist_summary_page.dart # L'écran de récapitulatif
│ └── song_details.dart # L'écran de détails d'une chanson
├── state/
│ └── playlist_manager.dart # Le ChangeNotifier (gestion de l'état)
└── main.dart # Le point d'entrée de l'application
```
## Comment Lancer le Projet
1.  Clonez ce dépôt.
2.  Ouvrez un terminal à la racine du projet et exécutez la commande suivante pour installer les dépendances :
    ```bash
    flutter pub get
    ```
3.  Lancez l'application sur un émulateur ou un appareil connecté :
    ```bash
    flutter run
    ```
