import 'package:flutter/material.dart';

import '../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    const orange = Color(0xFFE96B43);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 125,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (recipe.image != null)
                    Image.network(
                      recipe.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _imageFallback(),
                    )
                  else
                    _imageFallback(),
                  Positioned(
                    top: 7,
                    right: 7,
                    child: Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      child: IconButton(
                        visualDensity: VisualDensity.compact,
                        tooltip: isFavorite
                            ? 'Remover dos favoritos'
                            : 'Adicionar aos favoritos',
                        onPressed: onFavoriteTap,
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: orange,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 9, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF292524),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Color(0xFFF4A261), size: 16),
                        const SizedBox(width: 3),
                        Text(
                          recipe.rating?.toStringAsFixed(1) ?? 'Sem nota',
                          style: const TextStyle(fontSize: 11),
                        ),
                        const Spacer(),
                        const Icon(Icons.access_time, size: 14, color: Colors.grey),
                        const SizedBox(width: 3),
                        Text(
                          recipe.totalTimeMinutes == null
                              ? 'Tempo indisponível'
                              : '${recipe.totalTimeMinutes} min',
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageFallback() {
    return Container(
      color: const Color(0xFFE7DED4),
      alignment: Alignment.center,
      child: const Icon(Icons.restaurant, size: 42, color: Colors.white),
    );
  }
}
