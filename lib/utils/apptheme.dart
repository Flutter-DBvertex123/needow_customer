
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  //static const Color primary = Color(0xFF00C853);
  static const Color primary = Color(0xFF0A9962);
  static const Color secondary = Color(0xFFEBEBEB);
  static const Color background = Color(0xFFF5F5F5);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color cardBackground = Colors.white;
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE91E63);
  static const Color warning = Color(0xFFFFC107);
}


class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(

      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primary,           // Cursor color
        selectionColor: AppColors.primary,  // Text selection background color
        selectionHandleColor: AppColors.primary,  // Handle (drag point) color
      ),
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: "Gilroy",
      textTheme: TextTheme(
        bodyLarge: TextStyle(fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(fontWeight: FontWeight.w400),
        bodySmall: TextStyle(fontWeight: FontWeight.w400),
        titleMedium: TextStyle(fontWeight: FontWeight.w400),
        titleLarge: TextStyle(fontWeight: FontWeight.w400),
      ),
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }
}