import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'movie_card.dart';

class MovieSearchDelegate extends SearchDelegate {
  final List<Movie> movies;

  MovieSearchDelegate(this.movies);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[800],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white54),
      ),
      textTheme: const TextTheme(titleLarge: TextStyle(color: Colors.white)),
      scaffoldBackgroundColor: Colors.grey[900],
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.white),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container(color: Colors.grey[900]);
    }

    final results = movies
        .where((m) => m.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return Center(
        child: Text(
          "Aucun film trouvé",
          style: const TextStyle(color: Colors.white),
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
    if (query.isEmpty) {
      // Rien d'affiché tant que l'utilisateur n'a pas commencé à taper
      return Container(color: Colors.grey[900]);
    }

    final suggestions = movies
        .where((m) => m.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (suggestions.isEmpty) {
      return Center(
        child: Text(
          "Aucun film trouvé",
          style: const TextStyle(color: Colors.white),
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
          title: Text(movie.title, style: const TextStyle(color: Colors.white)),
          onTap: () {
            query = movie.title;
            showResults(context);
          },
        );
      },
    );
  }
}
