class Recipe {
  final int id;
  final String name;
  final String? image;
  final List<String> ingredients;
  final List<String> instructions;
  final int? prepTimeMinutes;
  final int? cookTimeMinutes;
  final int? servings;
  final double? rating;
  final List<String> mealType;
  final String? cuisine;
  final String? difficulty;

  const Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.ingredients,
    required this.instructions,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.rating,
    required this.mealType,
    required this.cuisine,
    required this.difficulty,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    final rawId = json['id'];
    if (rawId is! num) {
      throw const FormatException('Uma receita recebida não possui um ID válido.');
    }

    return Recipe(
      id: rawId.toInt(),
      name: json['name'] is String && (json['name'] as String).trim().isNotEmpty
          ? (json['name'] as String).trim()
          : 'Receita sem nome',
      image: json['image'] is String && (json['image'] as String).trim().isNotEmpty
          ? (json['image'] as String).trim()
          : null,
      ingredients: _stringList(json['ingredients']),
      instructions: _stringList(json['instructions']),
      prepTimeMinutes: _optionalInt(json['prepTimeMinutes']),
      cookTimeMinutes: _optionalInt(json['cookTimeMinutes']),
      servings: _optionalInt(json['servings']),
      rating: _optionalDouble(json['rating']),
      mealType: _stringList(json['mealType']),
      cuisine: json['cuisine'] is String ? json['cuisine'] as String : null,
      difficulty: json['difficulty'] is String ? json['difficulty'] as String : null,
    );
  }

  static List<String> _stringList(dynamic value) {
    if (value is! List) return [];
    return value.whereType<String>().toList();
  }

  static int? _optionalInt(dynamic value) {
    if (value is num) return value.toInt();
    return null;
  }

  static double? _optionalDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return null;
  }

  int? get totalTimeMinutes {
    if (prepTimeMinutes == null || cookTimeMinutes == null) return null;
    return prepTimeMinutes! + cookTimeMinutes!;
  }
}
