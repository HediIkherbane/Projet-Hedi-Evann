import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

// Si tu veux tester les vraies classes plus tard, décommente ces imports
// import 'package:projet_evann_hedi/UI/article_provider.dart';
// import 'package:projet_evann_hedi/UI/favoris.dart';
// import 'package:projet_evann_hedi/UI/liste.dart';

// Mock de ArticleProvider
class TestArticleProvider extends ChangeNotifier {
  final List<String> favoris = [];
  final List<String> panier = [];

  void addFavorite(String article) {
    favoris.add(article);
    notifyListeners();
  }

  void removeFavorite(String article) {
    favoris.remove(article);
    notifyListeners();
  }

  bool isFavorite(String article) {
    return favoris.contains(article);
  }
}

// Mock de FavorisPage
class FavorisPageTest extends StatelessWidget {
  const FavorisPageTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TestArticleProvider>(context);

    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: provider.favoris
              .map(
                (article) => ListTile(
                  title: Text(article),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      provider.removeFavorite(article);
                    },
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

void main() {
  group('Tests Widget Favoris', () {
    testWidgets('Ajout manuel d\'un favori et affichage', (tester) async {
      final provider = TestArticleProvider();

      provider.addFavorite('Article Test');

      await tester.pumpWidget(
        ChangeNotifierProvider<TestArticleProvider>.value(
          value: provider,
          child: const FavorisPageTest(),
        ),
      );

      expect(find.text('Article Test'), findsOneWidget);
    });

    testWidgets('Suppression via l\'icone delete', (tester) async {
      final provider = TestArticleProvider();
      provider.addFavorite('Article Test');

      await tester.pumpWidget(
        ChangeNotifierProvider<TestArticleProvider>.value(
          value: provider,
          child: const FavorisPageTest(),
        ),
      );

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      expect(find.text('Article Test'), findsNothing);
    });
  });
}
