import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UI/liste.dart';
import 'UI/favoris.dart';
import 'UI/panier.dart';
import 'UI/welcome_page.dart';
import 'UI/article_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ArticleProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? skipWelcome;

  @override
  void initState() {
    super.initState();
    loadPreference();
  }

  Future<void> loadPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool("skipWelcome") ?? false;

    setState(() {
      skipWelcome = value;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    if (skipWelcome == null) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp(
      title: 'Articles Store',
      routes: {
        "/favoris": (_) => const FavorisPage(),
        "/panier": (_) => const PanierPage(),
      },

      
      home: skipWelcome! ? const ListeArticles() : const WelcomePage(),
    );
  }
}