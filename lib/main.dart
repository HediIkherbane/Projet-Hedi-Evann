import 'package:flutter/material.dart';
import 'UI/liste.dart';
import 'UI/favoris.dart';
import 'UI/panier.dart'; 
import 'package:provider/provider.dart';
import 'UI/article_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ArticleProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Articles Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        "/favoris": (context) => const FavorisPage(),
        "/panier" : (context) => const PanierPage(),
      },

      home: const ListeArticles(),
    );
  }
}