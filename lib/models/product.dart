class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final List<String> images;
  final Map<String, dynamic> category;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      // Nettoyage basique car l'API Platzi a parfois des formats d'image étranges
      images: List<String>.from(json['images'] ?? []),
      category: json['category'] ?? {},
    );
  }
}