import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../models/favorites.dart';

class DetailsPage extends StatelessWidget {
  final Movie movie;

  const DetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                movie.poster,
                width: 300,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 15),
            Text(movie.title, style: Theme.of(context).textTheme.titleLarge),
            ValueListenableBuilder<Set<int>>(
              valueListenable: Favorites.favoriteIds,
              builder: (context, favs, _) {
                final isFav = favs.contains(movie.id);
                return IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: Colors.redAccent,
                    size: 30,
                  ),
                  onPressed: () {
                    Favorites.toggle(movie);
                  },
                );
              },
            ),
            const SizedBox(height: 10),
            Text(
              movie.description,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
