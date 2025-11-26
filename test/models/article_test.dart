import 'package:flutter_test/flutter_test.dart';
import 'package:projet_evann_hedi/UI/liste.dart';

void main() {
  group('Article Model Tests', () {
    final Map<String, dynamic> jsonMock = {
      "id": 1,
      "title": "Test Article",
      "images": ["https://example.com/image.png"],
      "price": 100,
      "description": "Description de test",
    };

    test('fromJson crée un objet Article valide', () {
      final article = Article.fromJson(jsonMock);

      expect(article.id, 1);
      expect(article.title, "Test Article");
      expect(article.image, "https://example.com/image.png");
      expect(article.price, 100.0);
      expect(article.description, "Description de test");
    });

    test('fromJson gère une liste d\'images vide', () {
      final Map<String, dynamic> jsonNoImage = {
        "id": 2,
        "title": "No Image",
        "images": [],
        "price": 50,
        "description": "Desc",
      };

      final article = Article.fromJson(jsonNoImage);
      expect(article.image, "https://via.placeholder.com/150");
    });

    test('toJson retourne une map correcte', () {
      final article = Article(
        id: 1,
        title: "Titre",
        image: "img.png",
        price: 10.0,
        description: "Desc",
      );

      final json = article.toJson();

      expect(json['id'], 1);
      expect(json['images'], isA<List>());
      expect(json['images'][0], "img.png");
    });
  });
}
