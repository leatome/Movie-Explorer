import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../pages/details_page.dart';
import '../models/favorites.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          //MaterialPageRoute(builder: (context) => DetailsPage(movie: movie)),
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => DetailsPage(movie: movie),
            transitionsBuilder: (_, animation, __, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(1, 0), // côté droit
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  movie.poster,
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            movie.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        ValueListenableBuilder<Set<int>>(
                          valueListenable: Favorites.favoriteIds,
                          builder: (context, favs, _) {
                            final isFav = favs.contains(movie.id);
                            return IconButton(
                              icon: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                Favorites.toggle(movie);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 14),
                        Text(
                          " ${movie.year}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      movie.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis, // truc pour les ...
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 17,
                          color: Colors.amberAccent,
                        ),
                        Text(
                          " ${movie.rate.toStringAsFixed(1)}/10",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
