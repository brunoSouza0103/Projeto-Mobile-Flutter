
import 'package:flutter/material.dart';
import '../data/recipes_mock.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';

class FavoritesScreen extends StatelessWidget {
  final ValueChanged<Recipe> onRecipeTap;

  const FavoritesScreen({
    super.key,
    required this.onRecipeTap,
  });

  @override
  Widget build(BuildContext context) {
    final favorites = recipesMock.take(2).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8F0),
        title: const Text(
          'Meus Favoritos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: favorites.isEmpty
          ? const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.favorite_border,
              size: 70,
              color: Color(0xFFE96B43),
            ),
            SizedBox(height: 15),
            Text(
              'Nenhum há favorito ainda!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Suas receitas favoritas aparecerão aqui.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: favorites.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          mainAxisExtent: 215,
        ),
        itemBuilder: (context, index) {
          final recipe = favorites[index];

          return RecipeCard(
            recipe: recipe,
            onTap: () => onRecipeTap(recipe),
          );
        },
      ),
    );
  }
}
