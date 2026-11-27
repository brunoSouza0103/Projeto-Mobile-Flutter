import 'package:flutter/material.dart';

import '../data/favorites_manager.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';
import '../widgets/state_message.dart';

class HomeScreen extends StatelessWidget {
  final Future<List<Recipe>> recipesFuture;
  final VoidCallback onExplore;
  final VoidCallback onSearch;
  final ValueChanged<Recipe> onRecipeTap;
  final FavoritesManager favoritesManager;

  const HomeScreen({
    super.key,
    required this.recipesFuture,
    required this.onExplore,
    required this.onSearch,
    required this.onRecipeTap,
    required this.favoritesManager,
  });

  @override
  Widget build(BuildContext context) {
    const orange = Color(0xFFE96B43);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: SafeArea(
        child: FutureBuilder<List<Recipe>>(
          future: recipesFuture,
          builder: (context, snapshot) {
            final recipes = snapshot.data ?? [];

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: orange,
                        child: Icon(Icons.restaurant_menu, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Menue',
                        style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      const Icon(Icons.spa_outlined, color: orange, size: 28),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Olá, chef!',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    'O que você gostaria de cozinhar hoje?',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: onSearch,
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: orange),
                          SizedBox(width: 12),
                          Text('Buscar receitas...', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        if (recipes.isNotEmpty && recipes.first.image != null)
                          Image.network(
                            recipes.first.image!,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _bannerFallback(),
                          )
                        else
                          _bannerFallback(),
                        Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.black.withOpacity(0.72), Colors.transparent],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 18,
                          top: 25,
                          bottom: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 210,
                                child: Text(
                                  'Descubra novos sabores',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              FilledButton(
                                onPressed: onExplore,
                                child: const Text('Explorar receitas'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 27),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Receitas em destaque',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(onPressed: onExplore, child: const Text('Ver todas')),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (snapshot.connectionState == ConnectionState.waiting)
                    const Padding(
                      padding: EdgeInsets.all(28),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (snapshot.hasError)
                    StateMessage(
                      icon: Icons.wifi_off,
                      title: 'Não foi possível carregar as receitas',
                      message: 'Verifique sua conexão e tente novamente pela listagem.',
                      buttonText: 'Abrir listagem',
                      onButtonPressed: onExplore,
                    )
                  else if (recipes.isEmpty)
                      const StateMessage(
                        icon: Icons.restaurant_menu,
                        title: 'Nenhuma receita disponível',
                        message: 'Tente carregar as receitas novamente.',
                      )
                    else
                      SizedBox(
                        height: 225,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: recipes.length > 8 ? 8 : recipes.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final recipe = recipes[index];
                            return SizedBox(
                              width: 175,
                              child: AnimatedBuilder(
                                animation: favoritesManager,
                                builder: (context, _) => RecipeCard(
                                  recipe: recipe,
                                  isFavorite: favoritesManager.isFavorite(recipe.id),
                                  onTap: () => onRecipeTap(recipe),
                                  onFavoriteTap: () => favoritesManager.toggleFavorite(recipe),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _bannerFallback() => Container(
    height: 180,
    width: double.infinity,
    color: const Color(0xFFE96B43),
    alignment: Alignment.center,
    child: const Icon(Icons.restaurant, color: Colors.white, size: 55),
  );
}
