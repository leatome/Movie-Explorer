import 'package:flutter/material.dart';
import 'package:pedra_lea_movie_explorer/widgets/movie_card.dart';
import 'models/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'widgets/MovieSearchDelegate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

Future<List<Movie>> fetchMovies() async {
  const apiKey = "d91b587cd1587e471cee8e4c9dd6765b";

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Movie>> futureMovies;
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    futureMovies = fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Movie Explorer",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey[800],
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: MovieSearchDelegate(movies),
              );
            },
          ),
        ],
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[900],
      body: FutureBuilder<List<Movie>>(
        future: futureMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Erreur de chargement"));
          } else {
            movies = snapshot.data!;

            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return MovieCard(movie: movies[index]);
              },
            );
          }
        },
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: const Icon(Icons.home),
      ),*/
    );
  }
}
