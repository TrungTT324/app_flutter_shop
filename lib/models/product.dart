class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final String emoji;
  final double rating;
  final int reviewCount;
  final bool isFavorite;
  final String category;
  final bool isNew;
  final bool isFlashSale;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.emoji,
    this.rating = 4.5,
    this.reviewCount = 0,
    this.isFavorite = false,
    required this.category,
    this.isNew = false,
    this.isFlashSale = false,
  });

  double? get discountPercent {
    if (originalPrice == null || originalPrice! <= price) return null;
    return ((originalPrice! - price) / originalPrice! * 100).roundToDouble();
  }
}
