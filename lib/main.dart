import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'pages/home_page.dart';
import 'services/movie_service.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  final MovieService movieService = MovieService(
    apiKey: dotenv.env['TMDB_API_KEY']!,
  );
  runApp(MyApp(movieService: movieService));
}

class MyApp extends StatelessWidget {
  final MovieService movieService;
  const MyApp({super.key, required this.movieService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Explorer',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[800],
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.grey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.grey),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(179, 116, 112, 112),
          ),
          bodyMedium: TextStyle(color: Color.fromARGB(255, 209, 207, 207)),
          bodySmall: TextStyle(color: Colors.grey),
        ),
      ),

      home: HomePage(),
    );
  }
}
