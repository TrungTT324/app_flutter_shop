class Product {
  final String id;
  final String name;
  final String brand;
  final double price;
  final double? originalPrice;
  final String category;
  final int colorHex;
  final double rating;
  final int reviewCount;
  final bool isNew;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    this.originalPrice,
    required this.category,
    required this.colorHex,
    required this.rating,
    required this.reviewCount,
    this.isNew = false,
    this.isFavorite = false,
  });

  double get discountPercent {
    if (originalPrice == null || originalPrice! <= price) return 0;
    return ((originalPrice! - price) / originalPrice! * 100).roundToDouble();
  }
}
