import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../domain/models/product_model.dart';
import '../widgets/deal_timer.dart';

final Product dummyProduct = Product(
  name: 'Wireless Noise Cancelling Headphones',
  description: 'High fidelity audio with long battery life and smart assistant support.',
  price: 4999,
  originalPrice: 9999,
  imageUrl: 'https://images.unsplash.com/photo-1585386959984-a41552249d5e',
  discountPercentage: 50,
  dealDuration: const Duration(hours: 2, minutes: 14, seconds: 38),
);

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product = dummyProduct;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 🔷 Product Image with Badge + Timer
            Stack(
              children: [
                // 🎯 Product Image with loading & error handling
                Image.network(
                  product.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) =>
                  loadingProgress == null
                      ? child
                      : const Center(child: CircularProgressIndicator()),
                  errorBuilder: (context, error, stackTrace) =>
                  const Center(child: Icon(Icons.error, size: 50)),
                ),

                // 🎖️ Discount Badge
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${product.discountPercentage}% OFF',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // ⏳ Deal Timer (Reusable)
                Positioned(
                  top: 16,
                  right: 16,
                  child: DealTimer(duration: product.dealDuration),
                ),
              ],
            ),

            // 🧾 Product Info
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name, style: AppTextStyles.title),
                    const SizedBox(height: 8),
                    Text(product.description, style: AppTextStyles.subtitle),
                    const SizedBox(height: 16),

                    // 💰 Price Section
                    Row(
                      children: [
                        Text('₹${product.price.toInt()}', style: AppTextStyles.title),
                        const SizedBox(width: 10),
                        Text(
                          '₹${product.originalPrice.toInt()}',
                          style: AppTextStyles.subtitle.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${product.discountPercentage}% OFF',
                          style: const TextStyle(
                            color: AppColors.accent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // 🛒 Call to Action Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Added to cart")),
                          );
                        },
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
