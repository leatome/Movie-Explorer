class Movie {
  final int id;
  final String title;
  final String year;
  final String poster;
  final String description;
  final double rate;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.poster,
    required this.description,
    required this.rate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? 'Pas de titre',
      year: json['release_date'] ?? 'Année inconnue',
      poster: "https://image.tmdb.org/t/p/w500${json['poster_path']}",
      description: json['overview'] ?? 'Aucune description disponible.',
      rate: (json['vote_average'] is num)
          ? (json['vote_average'] as num).toDouble()
          : 0.0, //num gère int et double
    );
  }
}
