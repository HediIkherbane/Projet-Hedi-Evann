import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'liste.dart';

class StorageService {
  static const String favKey = "favorites";
  static const String cartKey = "cart";

  static Future<List<Article>> loadList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(key) ?? [];
    return saved.map((e) => Article.fromJson(json.decode(e))).toList();
  }

  static Future saveList(String key, List<Article> list) async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = list.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList(key, stringList);
  }
}