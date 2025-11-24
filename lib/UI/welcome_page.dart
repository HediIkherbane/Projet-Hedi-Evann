import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'liste.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool dontShowAgain = false;

  Future<void> savePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("skipWelcome", dontShowAgain);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Bienvenue dans l'application Articles Store !",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            const Text(
              "Parcourez une large sélection d’articles, "
              "ajoutez des favoris, et gérez votre panier.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: dontShowAgain,
                  onChanged: (v) {
                    setState(() {
                      dontShowAgain = v ?? false;
                    });
                  },
                ),
                const Text("Ne plus afficher cet écran"),
              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                await savePreference();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const ListeArticles()),
                );
              },
              child: const Text("Continuer"),
            )
          ],
        ),
      ),
    );
  }
}