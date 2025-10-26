import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC),
      appBar: AppBar(
        title: Text(
          'تفاصيل المنتج',
          style: GoogleFonts.reemKufi(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF8B4513),
      ),
      body: Center(
        child: Text(
          'تفاصيل المنتج: $productId',
          style: GoogleFonts.notoKufiArabic(
            fontSize: 18,
            color: const Color(0xFF8B4513),
          ),
        ),
      ),
    );
  }
}

