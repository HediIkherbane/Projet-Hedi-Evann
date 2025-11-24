import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'article_provider.dart';   

class PanierPage extends StatelessWidget {
  const PanierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mon Panier")),
      body: Consumer<ArticleProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: provider.panier.length,
                  itemBuilder: (context, index) {
                    final a = provider.panier[index];
                    return ListTile(
                      leading: Image.network(a.image),
                      title: Text(a.title),
                      subtitle: Text("${a.price} €"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => provider.toggleCart(a),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  provider.validateCart();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Achat validé !")),
                  );
                },
                child: const Text("Valider l’achat"),
              ),
            ],
          );
        },
      ),
    );
  }
}