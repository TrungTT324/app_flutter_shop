import 'package:flutter/material.dart';
import '../models/banner_item.dart';
import '../models/category.dart';
import '../models/product.dart';

final List<BannerItem> banners = const [
  BannerItem(
    title: 'Summer\nCollection',
    subtitle: 'Up to 50% off on selected items',
    cta: 'Shop Now',
    bgColorHex: 0xFFE8D5C4,
    accentColorHex: 0xFF8B4513,
  ),
  BannerItem(
    title: 'New\nArrivals',
    subtitle: 'Explore the latest trends',
    cta: 'Discover',
    bgColorHex: 0xFFD4E6D4,
    accentColorHex: 0xFF2D6A2D,
  ),
  BannerItem(
    title: 'Flash\nSale',
    subtitle: 'Limited time — hurry up!',
    cta: 'Grab Deal',
    bgColorHex: 0xFFE8D4E8,
    accentColorHex: 0xFF6A2D6A,
  ),
];

final List<Category> categories = const [
  Category(id: 'all', name: 'Tất cả', icon: Icons.apps_rounded),
  Category(id: 'men', name: 'Nam', icon: Icons.man_rounded),
  Category(id: 'women', name: 'Nữ', icon: Icons.woman_rounded),
  Category(id: 'kids', name: 'Trẻ em', icon: Icons.child_care_rounded),
  Category(id: 'accessories', name: 'Phụ kiện', icon: Icons.watch_rounded),
  Category(id: 'sale', name: 'Sale', icon: Icons.local_offer_rounded),
];

final List<Product> products = [
  Product(
    id: '1',
    name: 'Áo sơ mi Oxford',
    brand: 'ZARA',
    price: 459000,
    originalPrice: 699000,
    category: 'men',
    colorHex: 0xFF5B8DB8,
    rating: 4.5,
    reviewCount: 128,
    isNew: false,
  ),
  Product(
    id: '2',
    name: 'Váy maxi hoa',
    brand: 'H&M',
    price: 389000,
    category: 'women',
    colorHex: 0xFFE8A0BF,
    rating: 4.8,
    reviewCount: 96,
    isNew: true,
  ),
  Product(
    id: '3',
    name: 'Quần jeans slim',
    brand: 'Levi\'s',
    price: 699000,
    originalPrice: 899000,
    category: 'men',
    colorHex: 0xFF3D5A80,
    rating: 4.6,
    reviewCount: 214,
    isNew: false,
  ),
  Product(
    id: '4',
    name: 'Áo khoác bomber',
    brand: 'UNIQLO',
    price: 829000,
    category: 'women',
    colorHex: 0xFF8D6E63,
    rating: 4.7,
    reviewCount: 73,
    isNew: true,
  ),
  Product(
    id: '5',
    name: 'T-shirt basic',
    brand: 'CottonOn',
    price: 199000,
    originalPrice: 299000,
    category: 'men',
    colorHex: 0xFF6D8B74,
    rating: 4.3,
    reviewCount: 342,
    isNew: false,
  ),
  Product(
    id: '6',
    name: 'Đầm wrap floral',
    brand: 'Mango',
    price: 549000,
    category: 'women',
    colorHex: 0xFFD4A373,
    rating: 4.9,
    reviewCount: 57,
    isNew: true,
  ),
  Product(
    id: '7',
    name: 'Hoodie oversized',
    brand: 'Champion',
    price: 620000,
    originalPrice: 780000,
    category: 'men',
    colorHex: 0xFF9E9E9E,
    rating: 4.4,
    reviewCount: 189,
    isNew: false,
  ),
  Product(
    id: '8',
    name: 'Áo thun trẻ em',
    brand: 'Carter\'s',
    price: 149000,
    category: 'kids',
    colorHex: 0xFFFFB347,
    rating: 4.6,
    reviewCount: 88,
    isNew: true,
  ),
];

List<Product> getProductsByCategory(String categoryId) {
  if (categoryId == 'all') return products;
  if (categoryId == 'sale') return products.where((p) => p.originalPrice != null).toList();
  return products.where((p) => p.category == categoryId).toList();
}

List<Product> get flashSaleProducts =>
    products.where((p) => p.originalPrice != null).toList();

List<Product> get newArrivalProducts =>
    products.where((p) => p.isNew).toList();
