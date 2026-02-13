import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF137FEC); // Màu xanh chính
  static const Color backgroundLight = Color(0xFFF6F7F8); // Nền sáng
  static const Color backgroundDark = Color(0xFF101922); // Nền tối
  static const Color textGray = Color(0xFF617589); // Chữ xám
  static const Color success = Color(0xFF4CAF50); // Màu xanh lá khi đã uống
  static const Color warning = Color(0xFFFF9800); // Màu cam khi sắp hết thuốc
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      scaffoldBackgroundColor: AppColors.backgroundLight,
      textTheme:
          GoogleFonts.lexendTextTheme(), // Áp dụng font Lexend cho toàn app
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
