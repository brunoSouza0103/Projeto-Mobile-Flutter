import 'package:flutter/material.dart';

import 'data/favorites_manager.dart';
import 'models/recipe.dart';
import 'services/recipe_service.dart';
import 'telas/favorites_screen.dart';
import 'telas/home_screen.dart';
import 'telas/recipe_details.dart';
import 'telas/recipes_screen.dart';
import 'telas/search_screen.dart';
import 'widgets/navegacao_inferior.dart';

void main() {
  runApp(const MenueApp());
}

class MenueApp extends StatelessWidget {
  const MenueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menue - Aplicativo de Receitas',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE96B43),
          primary: const Color(0xFFE96B43),
          surface: const Color(0xFFFFF8F0),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF8F0),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFF8F0),
          foregroundColor: Color(0xFF292524),
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final RecipeService _recipeService = RecipeService();
  final FavoritesManager _favoritesManager = FavoritesManager();

  late Future<List<Recipe>> _recipesFuture;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _recipesFuture = _recipeService.getRecipes();
  }

  void _openDetails(Recipe recipe) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RecipeDetailsScreen(
          recipe: recipe,
          favoritesManager: _favoritesManager,
        ),
      ),
    );
  }

  void _openAllRecipes() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RecipesScreen(
          recipeService: _recipeService,
          onRecipeTap: _openDetails,
          favoritesManager: _favoritesManager,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _favoritesManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        recipesFuture: _recipesFuture,
        onExplore: _openAllRecipes,
        onSearch: () => setState(() => _selectedIndex = 1),
        onRecipeTap: _openDetails,
        favoritesManager: _favoritesManager,
      ),
      SearchScreen(
        recipeService: _recipeService,
        onRecipeTap: _openDetails,
        favoritesManager: _favoritesManager,
      ),
      FavoritesScreen(
        favoritesManager: _favoritesManager,
        onRecipeTap: _openDetails,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: NavegacaoInferior(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }
}
