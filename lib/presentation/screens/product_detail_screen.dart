import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/constants.dart';
import '../../domain/models/product_model.dart';
import '../widgets/deal_timer.dart';

final Product dummyProduct = Product(
  name: 'Sony WH-1000XM5',
  description: 'Industry-leading noise cancellation meets unparalleled audio precision in Sony\'s flagship headphones. Engineered for audiophiles who demand acoustic excellence in every frequency range.',
  longDescription: '''
The WH-1000XM5 represents the culmination of Sony's 35-year audio engineering legacy. Featuring all-new Integrated Processor V1 and HD Noise Canceling Processor QN1, these headphones analyze ambient sound at over 700 times per second. The 30mm carbon fiber composite drivers reproduce frequencies from 4Hz-40kHz with <0.3% THD, while DSEE Extreme technology upscales compressed files in real-time.

Crafted for extended listening sessions, the ergonomic design distributes pressure evenly across the scalp. Our proprietary CoolTech™ ear pads maintain optimal temperature during 30+ hour listening sessions. The beamforming microphone array isolates speech even in 40km/h winds, making these ideal for conference calls or voice commands.''',
  price: 24999,
  originalPrice: 29999,
  imageUrls: [
    'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb',
    'https://images.unsplash.com/photo-1583394838336-acd977736f90',
    'https://images.unsplash.com/photo-1505740420928-5e560c06d30e'
  ],
  specifications: {
    'Noise Cancellation': 'Industry-leading (up to 98% ambient reduction)',
    'Battery Life': '40 hours (NC on), 50 hours (NC off)',
    'Charging Time': '3 min = 3 hours playback (USB-C)',
    'Driver Type': '30mm carbon fiber composite',
    'Frequency Response': '4Hz - 40,000Hz',
    'Bluetooth Version': '5.3 with LDAC support',
    'Weight': '250g (without carrying case)',
    'Voice Assistant': 'Google Assistant, Alexa, Siri',
    'Special Features': 'Speak-to-Chat, Adaptive Sound Control, 360 Reality Audio'
  },
  features: [
    'Integrated Processor V1 + HD Noise Canceling Processor QN1',
    'Precise Voice Pickup Technology (5 mics with beamforming)',
    'DSEE Extreme™ real-time audio upscaling',
    'Multi-point connection (2 devices simultaneously)',
    'Wearing detection with auto pause/play',
    'Personalized NC Optimizer with atmospheric pressure optimization'
  ],
  discountPercentage: 17,
  dealDuration: const Duration(hours: 1, minutes: 30, seconds: 0),
);

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;
  late Animation<double> _waveAnimation;
  int _currentImage = 0;
  final PageController _pageController = PageController();
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _waveAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _waveController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _waveController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _handleDealExpired() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Deal expired! Price updated'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Product product = dummyProduct;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 380,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // Animated Sound Wave Background
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: _waveController,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: SoundWavePainter(
                            amplitude: _waveAnimation.value,
                            color: AppColors.waveColor,
                          ),
                        );
                      },
                    ),
                  ),

                  // Enhanced Image Carousel
                  PageView.builder(
                    controller: _pageController,
                    itemCount: product.imageUrls.length,
                    onPageChanged: (index) {
                      setState(() => _currentImage = index);
                    },
                    itemBuilder: (context, index) {
                      return Hero(
                        tag: 'product-image-${product.name}',
                        child: Image.network(
                          product.imageUrls[index],
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[800]!,
                              highlightColor: Colors.grey[600]!,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: Colors.white,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/headphone_placeholder.png',
                              fit: BoxFit.contain,
                            );
                          },
                        ),
                      );
                    },
                  ),

                  // Indicators
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        product.imageUrls.length,
                            (index) => GestureDetector(
                          onTap: () => _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: _currentImage == index ? 24 : 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: _currentImage == index
                                  ? AppColors.primary
                                  : Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Discount Badge Only (Timer moved to details section)
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.red, Colors.orange],
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Text(
                        '🔥 ${product.discountPercentage}% OFF',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title and Deal Timer (moved from hero)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                            product.name,
                            style: AppTextStyles.title.copyWith(
                                color: Colors.white,
                                fontSize: 24
                            )
                        ),
                      ),
                      DealTimer(
                        duration: product.dealDuration,
                        onExpire: _handleDealExpired,
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Premium Feature Badges
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildFeatureChip('40H Battery Life', Icons.battery_charging_full),
                      _buildFeatureChip('Dual Noise Canceling', Icons.noise_control_off),
                      _buildFeatureChip('Hi-Res Certified', Icons.audio_file),
                      _buildFeatureChip('Multi-point Connect', Icons.bluetooth),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Pricing Row
                  Row(
                    children: [
                      Text('₹${product.price.toInt()}',
                          style: AppTextStyles.title.copyWith(
                              color: AppColors.accent,
                              fontSize: 28
                          )),
                      const SizedBox(width: 10),
                      Text(
                        '₹${product.originalPrice.toInt()}',
                        style: AppTextStyles.subtitle.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontSize: 18
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${product.discountPercentage}% OFF',
                        style: const TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Expandable Description
                  _buildExpandableSection(
                    title: 'Engineering Excellence',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.description,
                          style: AppTextStyles.subtitle.copyWith(
                              color: Colors.white70,
                              height: 1.6
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          product.longDescription,
                          style: AppTextStyles.subtitle.copyWith(
                              color: Colors.white70,
                              height: 1.6
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Key Features Section
                  _buildSectionTitle('Premium Technologies'),
                  const SizedBox(height: 12),
                  ...product.features.map((feature) =>
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.adjust, color: AppColors.accent, size: 16),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                feature,
                                style: AppTextStyles.subtitle.copyWith(
                                    color: Colors.white70
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                  ).toList(),

                  const SizedBox(height: 24),

                  // Specifications Table
                  _buildSectionTitle('Technical Specifications'),
                  const SizedBox(height: 12),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1.5),
                      1: FlexColumnWidth(2),
                    },
                    children: product.specifications.entries.map((entry) {
                      return TableRow(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey[800]!,
                                    width: 1
                                )
                            )
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              entry.key,
                              style: AppTextStyles.subtitle.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              entry.value,
                              style: AppTextStyles.subtitle.copyWith(
                                  color: Colors.white70
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 28),

                  // CTA Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Added to cart")),
                        );
                      },
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // What's Included
                  _buildSectionTitle('Included in Package'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildIncludedItem('Carrying Case'),
                      _buildIncludedItem('3.5mm Audio Cable'),
                      _buildIncludedItem('USB-C Charging Cable'),
                      _buildIncludedItem('Airplane Adapter'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String text, IconData icon) {
    return Chip(
      backgroundColor: Colors.blue[900]!.withOpacity(0.3),
      avatar: Icon(icon, size: 16, color: AppColors.accent),
      label: Text(
        text,
        style: AppTextStyles.subtitle.copyWith(
            color: Colors.white70,
            fontSize: 12
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.title.copyWith(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600
      ),
    );
  }

  Widget _buildIncludedItem(String text) {
    return Chip(
      label: Text(
        text,
        style: AppTextStyles.subtitle.copyWith(
            color: Colors.white70,
            fontSize: 12
        ),
      ),
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildExpandableSection({required String title, required Widget content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Row(
            children: [
              Text(
                title,
                style: AppTextStyles.title.copyWith(
                    color: Colors.white,
                    fontSize: 20
                ),
              ),
              const Spacer(),
              Icon(
                _expanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: _expanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstChild: Text(
            'Experience the next evolution in acoustic engineering...',
            style: AppTextStyles.subtitle.copyWith(color: Colors.white70),
          ),
          secondChild: content,
        ),
      ],
    );
  }
}

class SoundWavePainter extends CustomPainter {
  final double amplitude;
  final Color color;

  SoundWavePainter({required this.amplitude, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final waveHeight = size.height * 0.15 * amplitude;
    final baseHeight = size.height * 0.7;

    path.moveTo(0, baseHeight);

    for (double i = 0; i < size.width; i++) {
      final y = baseHeight + sin(i * 0.05) * waveHeight;
      path.lineTo(i, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant SoundWavePainter oldDelegate) {
    return oldDelegate.amplitude != amplitude;
  }
}