import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import '../models/favorites.dart';

class FavoritesPage extends StatelessWidget {
  final List<Movie> allMovies;
  const FavoritesPage({super.key, required this.allMovies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mes favoris")),
      body: ValueListenableBuilder<Set<int>>(
        valueListenable: Favorites.favoriteIds,
        builder: (context, favs, _) {
          final favMovies = allMovies
              .where((m) => favs.contains(m.id))
              .toList();
          if (favMovies.isEmpty) {
            return Center(
              child: Text(
                "Aucun favori",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }
          return ListView.builder(
            itemCount: favMovies.length,
            itemBuilder: (context, index) {
              return MovieCard(movie: favMovies[index]);
            },
          );
        },
      ),
    );
  }
}
