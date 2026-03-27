import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'movie_card.dart';

class MovieSearchDelegate extends SearchDelegate {
  final List<Movie> movies;

  MovieSearchDelegate(this.movies);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ""),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = movies
        .where((m) => m.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return Center(
        child: Text(
          "Aucun film trouvé",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return MovieCard(movie: results[index]);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = movies
        .where((m) => m.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (suggestions.isEmpty) {
      return Center(
        child: Text(
          "Aucun film trouvé",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return ListView.separated(
      itemCount: suggestions.length,
      separatorBuilder: (context, index) => const Divider(
        color: Colors.white24,
        thickness: 1,
        indent: 16,
        endIndent: 16,
      ),
      itemBuilder: (context, index) {
        final movie = suggestions[index];
        return ListTile(
          title: Text(
            movie.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          onTap: () {
            query = movie.title;
            showResults(context);
          },
        );
      },
    );
  }
}
