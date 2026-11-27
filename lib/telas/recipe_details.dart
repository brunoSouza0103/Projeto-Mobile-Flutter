import 'package:flutter/material.dart';

import '../data/favorites_manager.dart';
import '../models/recipe.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final Recipe recipe;
  final FavoritesManager favoritesManager;

  const RecipeDetailsScreen({
    super.key,
    required this.recipe,
    required this.favoritesManager,
  });

  @override
  Widget build(BuildContext context) {
    const orange = Color(0xFFE96B43);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 270,
            pinned: true,
            backgroundColor: orange,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: recipe.image == null
                  ? _imageFallback()
                  : Image.network(
                recipe.image!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _imageFallback(),
              ),
            ),
            actions: [
              AnimatedBuilder(
                animation: favoritesManager,
                builder: (context, _) {
                  final favorite = favoritesManager.isFavorite(recipe.id);
                  return IconButton(
                    tooltip: favorite
                        ? 'Remover dos favoritos'
                        : 'Adicionar aos favoritos',
                    onPressed: () => favoritesManager.toggleFavorite(recipe),
                    icon: Icon(
                      favorite ? Icons.favorite : Icons.favorite_border,
                    ),
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF292524),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 18,
                    runSpacing: 10,
                    children: [
                      if (recipe.rating != null)
                        _info(Icons.star, 'Nota ${recipe.rating!.toStringAsFixed(1)}'),
                      if (recipe.prepTimeMinutes != null)
                        _info(Icons.timer_outlined, 'Preparo: ${recipe.prepTimeMinutes} min'),
                      if (recipe.cookTimeMinutes != null)
                        _info(Icons.local_fire_department_outlined, 'Cozimento: ${recipe.cookTimeMinutes} min'),
                      if (recipe.servings != null)
                        _info(Icons.people_outline, '${recipe.servings} porções'),
                      if (recipe.cuisine != null)
                        _info(Icons.public, recipe.cuisine!),
                      if (recipe.difficulty != null)
                        _info(Icons.signal_cellular_alt, recipe.difficulty!),
                    ],
                  ),
                  if (recipe.mealType.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      'Tipo de refeição: ${recipe.mealType.join(', ')}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                  const SizedBox(height: 28),
                  const Text(
                    'Ingredientes',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 14),
                  if (recipe.ingredients.isEmpty)
                    const Text('Ingredientes não informados.')
                  else
                    ...recipe.ingredients.map(
                          (ingredient) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.check_circle, color: orange, size: 20),
                            const SizedBox(width: 10),
                            Expanded(child: Text(ingredient, style: const TextStyle(fontSize: 15))),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  const Text(
                    'Modo de preparo',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 14),
                  if (recipe.instructions.isEmpty)
                    const Text('Instruções não informadas.')
                  else
                    ...List.generate(
                      recipe.instructions.length,
                          (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: orange,
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                recipe.instructions[index],
                                style: const TextStyle(fontSize: 15, height: 1.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _info(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: const Color(0xFFE96B43), size: 18),
        const SizedBox(width: 5),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _imageFallback() {
    return Container(
      color: const Color(0xFFE7DED4),
      alignment: Alignment.center,
      child: const Icon(Icons.restaurant, size: 65, color: Colors.white),
    );
  }
}
