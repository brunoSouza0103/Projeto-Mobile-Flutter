
import '../models/recipe.dart';

final List<Recipe> recipesMock = [
  Recipe(
    id: 1,
    name: 'Pizza Margherita',
    image: 'https://images.unsplash.com/photo-1579751626657-72bc17010498?w=600',
    rating: 4.8,
    prepTimeMinutes: 20,
    cookTimeMinutes: 15,
    servings: 4,
    ingredients: [
      'Massa de pizza',
      'Molho de tomate',
      'Mussarela fresca',
      'Manjericão fresco',
      'Azeite de oliva',
    ],
    instructions: [
      'Preaqueça o forno a 220°C.',
      'Abra a massa de pizza.',
      'Espalhe o molho de tomate sobre a massa.',
      'Adicione a mussarela e o manjericão.',
      'Asse por 15 minutos até dourar.',
    ],
  ),

  Recipe(
    id: 2,
    name: 'Macarrão Cremoso',
    image: 'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?w=600',
    rating: 4.7,
    prepTimeMinutes: 15,
    cookTimeMinutes: 20,
    servings: 2,
    ingredients: [
      'Macarrão',
      'Creme de leite',
      'Queijo parmesão',
      'Alho',
      'Manteiga',
    ],
    instructions: [
      'Cozinhe o macarrão em água fervente.',
      'Derreta a manteiga em uma panela.',
      'Adicione o alho e o creme de leite.',
      'Misture o macarrão ao molho.',
      'Finalize com queijo parmesão.',
    ],
  ),

  Recipe(
    id: 3,
    name: 'Salada de Legumes',
    image: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=600',
    rating: 4.5,
    prepTimeMinutes: 10,
    cookTimeMinutes: 0,
    servings: 2,
    ingredients: [
      'Alface',
      'Tomates',
      'Pepino',
      'Cenouras',
      'Azeite de oliva',
    ],
    instructions: [
      'Lave todos os legumes.',
      'Pique os ingredientes.',
      'Misture tudo em uma tigela.',
      'Tempere com azeite de oliva.',
    ],
  ),

  Recipe(
    id: 4,
    name: 'Panquecas Deliciosas',
    image: 'https://images.unsplash.com/photo-1528207776546-365bb710ee93?w=600',
    rating: 4.9,
    prepTimeMinutes: 10,
    cookTimeMinutes: 15,
    servings: 3,
    ingredients: [
      'Farinha de trigo',
      'Leite',
      'Ovos',
      'Açúcar',
      'Fermento em pó',
    ],
    instructions: [
      'Misture todos os ingredientes secos.',
      'Adicione o leite e os ovos.',
      'Bata até obter uma massa homogênea.',
      'Coloque porções da massa em uma frigideira quente.',
      'Sirva com sua cobertura favorita.',
    ],
  ),
];
