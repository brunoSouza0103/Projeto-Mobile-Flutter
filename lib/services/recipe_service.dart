import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/recipe.dart';

class RecipeApiException implements Exception {
  final String message;
  const RecipeApiException(this.message);

  @override
  String toString() => message;
}

class RecipeService {
  static const String _baseUrl = 'dummyjson.com';
  final http.Client _client;

  RecipeService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Recipe>> getRecipes() async {
    final uri = Uri.https(_baseUrl, '/recipes', {'limit': '30'});
    return _getRecipeList(uri);
  }

  Future<List<Recipe>> searchRecipes(String query) async {
    final cleanedQuery = query.trim();
    if (cleanedQuery.isEmpty) {
      throw const RecipeApiException('Digite um nome para pesquisar.');
    }

    final uri = Uri.https(
      _baseUrl,
      '/recipes/search',
      {'q': cleanedQuery, 'limit': '30'},
    );
    return _getRecipeList(uri);
  }

  Future<Recipe> getRecipeById(int id) async {
    final uri = Uri.https(_baseUrl, '/recipes/$id');
    final response = await _sendRequest(uri);

    final dynamic decoded = _decodeBody(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw const RecipeApiException('A resposta da receita está em formato inválido.');
    }
    return Recipe.fromJson(decoded);
  }

  Future<List<Recipe>> _getRecipeList(Uri uri) async {
    final response = await _sendRequest(uri);
    final dynamic decoded = _decodeBody(response.body);

    if (decoded is! Map<String, dynamic> || decoded['recipes'] is! List) {
      throw const RecipeApiException('A resposta da lista de receitas está em formato inválido.');
    }

    final rawRecipes = decoded['recipes'] as List;
    try {
      return rawRecipes.map((item) {
        if (item is! Map<String, dynamic>) {
          throw const FormatException('Item de receita inválido.');
        }
        return Recipe.fromJson(item);
      }).toList();
    } on FormatException catch (error) {
      throw RecipeApiException('Não foi possível interpretar as receitas: ${error.message}');
    }
  }

  Future<http.Response> _sendRequest(Uri uri) async {
    try {
      final response = await _client
          .get(uri, headers: {'Accept': 'application/json'})
          .timeout(const Duration(seconds: 15));

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw RecipeApiException(
          'O servidor respondeu com erro (${response.statusCode}). Tente novamente.',
        );
      }
      return response;
    } on RecipeApiException {
      rethrow;
    } catch (_) {
      throw const RecipeApiException(
        'Não foi possível conectar. Verifique sua internet e tente novamente.',
      );
    }
  }

  dynamic _decodeBody(String body) {
    try {
      return jsonDecode(body);
    } on FormatException {
      throw const RecipeApiException('O servidor retornou dados que não são um JSON válido.');
    }
  }

  void close() {
    _client.close();
  }
}
