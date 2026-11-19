
import 'package:flutter/material.dart';

import 'telas/home_screen.dart';
import 'telas/recipes_screen.dart';
import 'telas/search_screen.dart';
import 'telas/favorites_screen.dart';
import 'telas/recipe_details.dart';

import 'widgets/navegacao_inferior.dart';
import 'models/recipe.dart';

void main() {
  runApp(const RecipeFinderApp());
}

class RecipeFinderApp extends StatelessWidget {
  const RecipeFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menuê',

      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFF8F0),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE96B43),
          primary: const Color(0xFFE96B43),
          surface: const Color(0xFFFFF8F0),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFF8F0),
          elevation: 0,
          centerTitle: false,
        ),
      ),

      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedIndex = 0;

  void changeTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void openDetails(Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetails(
          recipe: recipe,
        ),
      ),
    );
  }

  void openRecipes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipesScreen(
          onRecipeTap: openDetails,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          HomeScreen(
            onExplore: openRecipes,
            onSearch: () => changeTab(1),
            onRecipeTap: openDetails,
          ),

          SearchScreen(
            onRecipeTap: openDetails,
          ),

          FavoritesScreen(
            onRecipeTap: openDetails,
          ),
        ],
      ),

      bottomNavigationBar: NavegacaoInferior(
        selectedIndex: selectedIndex,
        onItemSelected: changeTab,
      ),
    );
  }
}
