import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'article_provider.dart';   

class FavorisPage extends StatelessWidget {
  const FavorisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mes Favoris")),
      body: Consumer<ArticleProvider>(
        builder: (context, provider, _) {
          return ListView.builder(
            itemCount: provider.favoris.length,
            itemBuilder: (context, index) {
              final a = provider.favoris[index];
              return ListTile(
                leading: Image.network(a.image),
                title: Text(a.title),
                subtitle: Text("${a.price} €"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => provider.toggleFavori(a),
                ),
              );
            },
          );
        },
      ),
    );
  }
}