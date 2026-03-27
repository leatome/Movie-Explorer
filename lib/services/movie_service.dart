import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class MovieService {
  final String apiKey;

  MovieService({required this.apiKey});

  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(
      Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=fr-FR",
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List results = data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load movies");
    }
  }
}
