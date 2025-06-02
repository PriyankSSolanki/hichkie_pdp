class Product {
  final String name;
  final String description;
  final String longDescription;
  final double price;
  final double originalPrice;
  final int discountPercentage;
  final Duration dealDuration;
  final List<String> imageUrls;
  final Map<String, String> specifications;
  final List<String> features;

  Product({
    required this.name,
    required this.description,
    required this.longDescription,
    required this.price,
    required this.originalPrice,
    required this.discountPercentage,
    required this.dealDuration,
    required this.imageUrls,
    required this.specifications,
    required this.features,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final deal = json['dealDuration'];
    return Product(
      name: json['name'],
      description: json['description'],
      longDescription: json['longDescription'],
      price: (json['price'] as num).toDouble(),
      originalPrice: (json['originalPrice'] as num).toDouble(),
      discountPercentage: json['discountPercentage'],
      dealDuration: Duration(
        hours: deal['hours'],
        minutes: deal['minutes'],
        seconds: deal['seconds'],
      ),
      imageUrls: List<String>.from(json['imageUrls']),
      specifications: Map<String, String>.from(json['specifications']),
      features: List<String>.from(json['features']),
    );
  }
}
