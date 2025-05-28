class Product {
  final String name;
  final String description;
  final double price;
  final double originalPrice;
  final String imageUrl;
  final int discountPercentage;
  final Duration dealDuration;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
    required this.discountPercentage,
    required this.dealDuration,
  });
}
