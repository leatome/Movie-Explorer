import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'DetailsPage.dart';

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
        color: Colors.grey[800],
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
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                          size: 14,
                        ),
                        Text(
                          " ${movie.year}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      movie.description,
                      style: const TextStyle(color: Colors.white70),
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
                          style: const TextStyle(color: Colors.grey),
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
