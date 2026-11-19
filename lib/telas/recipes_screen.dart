
import 'package:flutter/material.dart';
import '../data/recipes_mock.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';

class RecipesScreen extends StatelessWidget {
  final ValueChanged<Recipe> onRecipeTap;

  const RecipesScreen({
    super.key,
    required this.onRecipeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8F0),
        title: const Text(
          'Explorar Receitas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: recipesMock.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          mainAxisExtent: 215,
        ),
        itemBuilder: (context, index) {
          final recipe = recipesMock[index];

          return RecipeCard(
            recipe: recipe,
            onTap: () => onRecipeTap(recipe),
          );
        },
      ),
    );
  }
}
