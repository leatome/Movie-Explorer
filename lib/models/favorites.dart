import '../models/movie.dart';
import 'package:flutter/foundation.dart';

class Favorites {
  static final ValueNotifier<Set<int>> favoriteIds = ValueNotifier<Set<int>>(
    {},
  );

  static bool isFavorite(Movie movie) => favoriteIds.value.contains(movie.id);

  static void toggle(Movie movie) {
    final current = Set<int>.from(favoriteIds.value);
    if (current.contains(movie.id)) {
      current.remove(movie.id);
    } else {
      current.add(movie.id);
    }
    favoriteIds.value = current;
  }
}
