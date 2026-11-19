
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_novo/main.dart';

void main() {
  testWidgets('RecipeFinder inicia corretamente',
          (WidgetTester tester) async {

        await tester.pumpWidget(const RecipeFinderApp());

        expect(find.text('RecipeFinder'), findsOneWidget);
        expect(find.text('Olá, Chef!'), findsOneWidget);
        expect(find.text('Explorar receitas'), findsOneWidget);
      });

  testWidgets('Navegação entre as telas principais',
          (WidgetTester tester) async {

        await tester.pumpWidget(const RecipeFinderApp());

        // Acessa a pesquisa
        await tester.tap(find.text('Pesquisar'));
        await tester.pump();

        expect(find.text('Pesquisar receitas'), findsOneWidget);

        // Acessa os favoritos
        await tester.tap(find.text('Favoritos'));
        await tester.pump();

        expect(find.text('Meus favoritos'), findsOneWidget);

        // Retorna para Home
        await tester.tap(find.text('Início'));
        await tester.pump();

        expect(find.text('Olá, Chef!'), findsOneWidget);
      });

  testWidgets('Abre a listagem de receitas',
          (WidgetTester tester) async {

        await tester.pumpWidget(const RecipeFinderApp());

        await tester.tap(find.text('Explorar receitas'));
        await tester.pumpAndSettle();

        expect(find.text('Pizza Margherita'), findsOneWidget);
      });
}
