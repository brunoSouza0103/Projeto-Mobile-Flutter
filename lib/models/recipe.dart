
class Recipe {
  final int id;
  final String name;
  final String image;
  final double rating;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final int servings;
  final List<String> ingredients;
  final List<String> instructions;

  const Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.ingredients,
    required this.instructions,
  });
}
