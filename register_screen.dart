import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC),
      appBar: AppBar(
        title: Text(
          'إنشاء حساب جديد',
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
          'شاشة إنشاء حساب جديد',
          style: GoogleFonts.notoKufiArabic(
            fontSize: 18,
            color: const Color(0xFF8B4513),
          ),
        ),
      ),
    );
  }
}

