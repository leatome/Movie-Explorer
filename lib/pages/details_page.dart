import 'package:flutter/material.dart';
import '../models/movie.dart';

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
