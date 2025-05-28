// lib/domain/models/product_model.dart
class Product {
  final String name;
  final String description;
  final String longDescription; // Added
  final double price;
  final double originalPrice;
  final List<String> imageUrls;
  final int discountPercentage;
  final Duration dealDuration;
  final Map<String, String> specifications; // Added
  final List<String> features; // Added

  Product({
    required this.name,
    required this.description,
    required this.longDescription, // Added
    required this.price,
    required this.originalPrice,
    required this.imageUrls,
    required this.discountPercentage,
    required this.dealDuration,
    required this.specifications, // Added
    required this.features, // Added
  });
}