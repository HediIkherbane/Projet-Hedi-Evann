import 'package:flutter/material.dart';
import 'liste.dart';
import 'storage_service.dart';

class ArticleProvider extends ChangeNotifier {
  List<Article> favoris = [];
  List<Article> panier = [];

  ArticleProvider() {
    loadData();
  }

  loadData() async {
    favoris = await StorageService.loadList(StorageService.favKey);
    panier = await StorageService.loadList(StorageService.cartKey);
    notifyListeners();
  }

  bool isFavorite(Article a) => favoris.any((e) => e.id == a.id);

  toggleFavori(Article a) {
    if (isFavorite(a)) {
      favoris.removeWhere((e) => e.id == a.id);
    } else {
      favoris.add(a);
    }
    StorageService.saveList(StorageService.favKey, favoris);
    notifyListeners();
  }

  bool inCart(Article a) => panier.any((e) => e.id == a.id);

  toggleCart(Article a) {
    if (inCart(a)) {
      panier.removeWhere((e) => e.id == a.id);
    } else {
      panier.add(a);
    }
    StorageService.saveList(StorageService.cartKey, panier);
    notifyListeners();
  }

  validateCart() {
    panier.clear();
    StorageService.saveList(StorageService.cartKey, panier);
    notifyListeners();
  }
}