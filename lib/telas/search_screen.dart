import 'package:flutter/material.dart';

import '../data/favorites_manager.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';
import '../widgets/recipe_card.dart';
import '../widgets/state_message.dart';

class SearchScreen extends StatefulWidget {
  final RecipeService recipeService;
  final ValueChanged<Recipe> onRecipeTap;
  final FavoritesManager favoritesManager;

  const SearchScreen({
    super.key,
    required this.recipeService,
    required this.onRecipeTap,
    required this.favoritesManager,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  List<Recipe> _results = [];
  bool _isLoading = false;
  bool _hasSearched = false;
  String? _errorMessage;
  String? _validationMessage;

  Future<void> _search() async {
    final query = _controller.text.trim();

    if (_isLoading) return;
    if (query.isEmpty) {
      setState(() {
        _validationMessage = 'Digite um nome antes de pesquisar.';
        _errorMessage = null;
        _hasSearched = false;
        _results = [];
      });
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
      _hasSearched = true;
      _errorMessage = null;
      _validationMessage = null;
      _results = [];
    });

    try {
      final results = await widget.recipeService.searchRecipes(query);
      if (!mounted) return;
      setState(() => _results = results);
    } catch (error) {
      if (!mounted) return;
      setState(() => _errorMessage = error.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _clearSearch() {
    _controller.clear();
    setState(() {
      _results = [];
      _hasSearched = false;
      _errorMessage = null;
      _validationMessage = null;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const orange = Color(0xFFE96B43);

    return Scaffold(
      appBar: AppBar(title: const Text('Pesquisar receitas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _search(),
                    decoration: InputDecoration(
                      hintText: 'Digite o nome de uma receita...',
                      prefixIcon: const Icon(Icons.search, color: orange),
                      suffixIcon: IconButton(
                        tooltip: 'Limpar pesquisa',
                        onPressed: _clearSearch,
                        icon: const Icon(Icons.close),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _isLoading ? null : _search,
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const StateMessage(
        icon: Icons.search,
        title: 'Pesquisando receitas',
        message: 'Aguarde enquanto buscamos resultados.',
        loading: true,
      );
    }

    if (_validationMessage != null) {
      return StateMessage(
        icon: Icons.info_outline,
        title: 'Pesquisa não realizada',
        message: _validationMessage!,
      );
    }

    if (_errorMessage != null) {
      return StateMessage(
        icon: Icons.wifi_off,
        title: 'Erro na pesquisa',
        message: _errorMessage!,
        buttonText: 'Tentar novamente',
        onButtonPressed: _search,
      );
    }

    if (!_hasSearched) {
      return const StateMessage(
        icon: Icons.manage_search,
        title: 'Encontre sua próxima receita',
        message: 'Digite o nome de uma receita e toque na lupa para pesquisar.',
      );
    }

    if (_results.isEmpty) {
      return const StateMessage(
        icon: Icons.search_off,
        title: 'Nenhuma receita encontrada',
        message: 'Não encontramos resultados para essa pesquisa. Experimente outro nome.',
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _results.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        mainAxisExtent: 218,
      ),
      itemBuilder: (context, index) {
        final recipe = _results[index];
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
  }
}
