
import 'package:flutter/material.dart';
import '../data/recipes_mock.dart';
import '../widgets/recipe_card.dart';
import '../models/recipe.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onExplore;
  final VoidCallback onSearch;
  final ValueChanged<Recipe> onRecipeTap;

  const HomeScreen({
    super.key,
    required this.onExplore,
    required this.onSearch,
    required this.onRecipeTap,
  });

  @override
  Widget build(BuildContext context) {
    const orange = Color(0xFFE96B43);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: orange,
                    child: Icon(
                      Icons.restaurant_menu,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'RecipeFinder',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.restaurant,
                    color: orange,
                    size: 28,
                  ),
                ],
              ),

              const SizedBox(height: 35),

              const Text(
                'Olá!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF292524),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'O que gostaria de cozinhar hoje?',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 22),

              GestureDetector(
                onTap: onSearch,
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
                      Text(
                        'Buscar receitas...',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Image.network(
                      recipesMock[0].image,
                      height: 190,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 190,
                        color: orange,
                      ),
                    ),
                    Container(
                      height: 190,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 18,
                      top: 30,
                      bottom: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Descubra...',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: onExplore,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: orange,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Explorar Receitas'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Recipes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: onExplore,
                    child: const Text(
                      'See all',
                      style: TextStyle(color: orange),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 235,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: recipesMock.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 175,
                      child: RecipeCard(
                        recipe: recipesMock[index],
                        onTap: () => onRecipeTap(
                          recipesMock[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
