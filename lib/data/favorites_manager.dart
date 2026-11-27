
import 'package:flutter/foundation.dart';
import '../models/recipe.dart';

class FavoritesManager extends ChangeNotifier {
  final Map<int, Recipe> _favorites = {};

  List<Recipe> get favorites =>
      List.unmodifiable(_favorites.values);

  bool isFavorite(int recipeId) {
    return _favorites.containsKey(recipeId);
  }

  void toggleFavorite(Recipe recipe) {
    if (isFavorite(recipe.id)) {
      _favorites.remove(recipe.id);
    } else {
      _favorites[recipe.id] = recipe;
    }

    notifyListeners();
  }

  void removeFavorite(int recipeId) {
    _favorites.remove(recipeId);
    notifyListeners();
  }
}
