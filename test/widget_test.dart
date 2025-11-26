import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:projet_evann_hedi/main.dart';
import 'package:projet_evann_hedi/UI/article_provider.dart';

void main() {
  testWidgets('Affiche la WelcomePage si skipWelcome est false', (
    WidgetTester tester,
  ) async {
    // Simuler que c'est la première ouverture (pas de skipWelcome enregistré)
    SharedPreferences.setMockInitialValues({});

    // Construire l'application
    // Note: On doit injecter le Provider car MyApp l'attend ou l'utilise via main()
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ArticleProvider(),
        child: const MyApp(),
      ),
    );

    // Forcer le rendu initial (initState async)
    await tester.pumpAndSettle();

    // Vérifier qu'on est sur la page de bienvenue
    expect(
      find.text("Bienvenue dans l'application Articles Store !"),
      findsOneWidget,
    );
    expect(find.text("Continuer"), findsOneWidget);
  });
}
