import 'package:flutter/material.dart';

import '../data/favorites_manager.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';
import '../widgets/recipe_card.dart';
import '../widgets/state_message.dart';

class RecipesScreen extends StatefulWidget {
  final RecipeService recipeService;
  final ValueChanged<Recipe> onRecipeTap;
  final FavoritesManager favoritesManager;

  const RecipesScreen({
    super.key,
    required this.recipeService,
    required this.onRecipeTap,
    required this.favoritesManager,
  });

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  late Future<List<Recipe>> _recipesFuture;

  @override
  void initState() {
    super.initState();
    _recipesFuture = widget.recipeService.getRecipes();
  }

  void _retry() {
    setState(() {
      _recipesFuture = widget.recipeService.getRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todas as receitas')),
      body: FutureBuilder<List<Recipe>>(
        future: _recipesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const StateMessage(
              icon: Icons.restaurant,
              title: 'Carregando receitas',
              message: 'Aguarde enquanto buscamos as receitas.',
              loading: true,
            );
          }

          if (snapshot.hasError) {
            return StateMessage(
              icon: Icons.wifi_off,
              title: 'Não foi possível carregar',
              message: snapshot.error.toString(),
              buttonText: 'Tentar novamente',
              onButtonPressed: _retry,
            );
          }

          final recipes = snapshot.data ?? [];
          if (recipes.isEmpty) {
            return StateMessage(
              icon: Icons.restaurant_menu,
              title: 'Nenhuma receita encontrada',
              message: 'A lista retornou vazia. Tente novamente.',
              buttonText: 'Recarregar',
              onButtonPressed: _retry,
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: recipes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              mainAxisExtent: 218,
            ),
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return AnimatedBuilder(
                animation: widget.favoritesManager,
                builder: (context, _) => RecipeCard(
                  recipe: recipe,
                  isFavorite: widget.favoritesManager.isFavorite(recipe.id),
                  onTap: () => widget.onRecipeTap(recipe),
                  onFavoriteTap: () => widget.favoritesManager.toggleFavorite(recipe),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
