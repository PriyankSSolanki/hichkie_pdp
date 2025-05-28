import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'presentation/screens/product_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hichkie PDP',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const ProductDetailScreen(),
    );
  }
}
