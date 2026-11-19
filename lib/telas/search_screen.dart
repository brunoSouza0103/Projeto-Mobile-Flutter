
import 'package:flutter/material.dart';
import '../data/recipes_mock.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';

class SearchScreen extends StatelessWidget {
  final ValueChanged<Recipe> onRecipeTap;

  const SearchScreen({
    super.key,
    required this.onRecipeTap,
  });

  @override
  Widget build(BuildContext context) {
    const orange = Color(0xFFE96B43);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8F0),
        title: const Text(
          'Search Recipes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar receitas...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: orange,
                ),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.close),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Discover recipes',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          Expanded(
            child: GridView.builder(
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
          ),
        ],
      ),
    );
  }
}
