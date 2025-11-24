import 'package:flutter/material.dart';
import 'liste.dart';
import 'article_provider.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  final Article article;

  const DetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        actions: [
          Consumer<ArticleProvider>(
            builder: (context, provider, _) {
              final isFav = provider.isFavorite(article);

              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () => provider.toggleFavori(article),
              );
            },
          ),

          Consumer<ArticleProvider>(
            builder: (context, provider, _) {
              final inCart = provider.inCart(article);

              return IconButton(
                icon: Icon(
                  inCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
                ),
                onPressed: () => provider.toggleCart(article),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Consumer<ArticleProvider>(
          builder: (context, provider, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    article.image,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  article.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "${article.price} €",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  article.description,
                  style: const TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(
                        provider.isFavorite(article)
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      label: Text(provider.isFavorite(article)
                          ? "Retirer des favoris"
                          : "Ajouter aux favoris"),
                      onPressed: () => provider.toggleFavori(article),
                    ),

                    ElevatedButton.icon(
                      icon: Icon(
                        provider.inCart(article)
                            ? Icons.shopping_cart
                            : Icons.shopping_cart_outlined,
                      ),
                      label: Text(provider.inCart(article)
                          ? "Retirer du panier"
                          : "Ajouter au panier"),
                      onPressed: () => provider.toggleCart(article),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}