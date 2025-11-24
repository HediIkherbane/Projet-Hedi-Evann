import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail.dart';
import 'article_provider.dart';
import 'package:provider/provider.dart';

class Article {
  final int id;
  final String title;
  final String image;
  final double price;
  final String description;

  Article({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.description,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: (json['images'] != null && json['images'].length > 0)
          ? json['images'][0]
          : "https://via.placeholder.com/150",
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "images": [image],
      "price": price,
      "description": description,
    };
  }
}

class ListeArticles extends StatelessWidget {
  const ListeArticles({super.key});

  Future<List<Article>> fetchArticles() async {
    try {
      final response = await http
          .get(Uri.parse("https://api.escuelajs.co/api/v1/products"))
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((e) => Article.fromJson(e)).toList();
      }

      return [];
    } catch (e) {
      debugPrint("Erreur API : $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des articles"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.pushNamed(context, "/favoris"),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, "/panier"),
          ),
        ],
      ),

      body: FutureBuilder<List<Article>>(
        future: fetchArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Aucun article trouvé"));
          }

          final articles = snapshot.data!;

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];

              return Consumer<ArticleProvider>(
                builder: (context, provider, _) {
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.all(10),

                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(article.image),
                      ),

                      title: Text(article.title),
                      subtitle: Text("${article.price} €"),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              provider.isFavorite(article)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              provider.toggleFavori(article);
                            },
                          ),

                          IconButton(
                            icon: Icon(
                              provider.inCart(article)
                                  ? Icons.shopping_cart
                                  : Icons.shopping_cart_outlined,
                            ),
                            onPressed: () {
                              provider.toggleCart(article);
                            },
                          ),
                        ],
                      ),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPage(article: article),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
