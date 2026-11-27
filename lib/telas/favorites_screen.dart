import 'package:flutter/material.dart';

import '../data/favorites_manager.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';
import '../widgets/state_message.dart';

class FavoritesScreen extends StatelessWidget {
  final FavoritesManager favoritesManager;
  final ValueChanged<Recipe> onRecipeTap;

  const FavoritesScreen({
    super.key,
    required this.favoritesManager,
    required this.onRecipeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas favoritas')),
      body: AnimatedBuilder(
        animation: favoritesManager,
        builder: (context, _) {
          final favorites = favoritesManager.favorites;

          if (favorites.isEmpty) {
            return const StateMessage(
              icon: Icons.favorite_border,
              title: 'Você ainda não tem favoritos',
              message: 'Toque no coração de uma receita para salvá-la aqui.',
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              mainAxisExtent: 218,
            ),
            itemBuilder: (context, index) {
              final recipe = favorites[index];
              return RecipeCard(
                recipe: recipe,
                isFavorite: true,
                onTap: () => onRecipeTap(recipe),
                onFavoriteTap: () => favoritesManager.removeFavorite(recipe.id),
              );
            },
          );
        },
      ),
    );
  }
}
