import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette
  static const Color wine = Color(0xFF722F37);
  static const Color wineDeep = Color(0xFF5B1A2A);
  static const Color wineLight = Color(0xFF9B4D56);
  
  static const Color gold = Color(0xFFC5A54E);
  static const Color goldLight = Color(0xFFE8D5A3);
  static const Color goldDeep = Color(0xFFA68B3C);

  // Neutral Palette - Light
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceElevatedLight = Color(0xFFFFF9F5);
  static const Color backgroundLight = Color(0xFFFBF7F4);
  static const Color textPrimaryLight = Color(0xFF2A1F24);
  static const Color textSecondaryLight = Color(0xFF7A6B70);
  static const Color borderLight = Color(0xFFE8DDD5);

  // Neutral Palette - Dark
  static const Color surfaceDark = Color(0xFF1C1520);
  static const Color surfaceElevatedDark = Color(0xFF261D2A);
  static const Color backgroundDark = Color(0xFF130E16);
  static const Color textPrimaryDark = Color(0xFFF5F0EC);
  static const Color textSecondaryDark = Color(0xFFA89B9F);
  static const Color borderDark = Color(0xFF3A2E3E);

  // Semantic Palette
  static const Color errorLight = Color(0xFFC62828);
  static const Color errorDark = Color(0xFFEF5350);
  static const Color successLight = Color(0xFF558B2F);
  static const Color successDark = Color(0xFF8BC34A);
  static const Color warningLight = Color(0xFFD4A017);
  static const Color warningDark = Color(0xFFFFD54F);

  // Motivation Level Colors
  static Color getMotivationColor(int level) {
    switch (level) {
      case 1:
        return const Color(0xFFC62828); // Deep Red
      case 2:
        return const Color(0xFFD4763A); // Burnt Sienna
      case 3:
        return const Color(0xFFD4A017); // Amber Gold
      case 4:
        return const Color(0xFF8B9A46); // Olive Gold
      case 5:
        return const Color(0xFF558B2F); // Forest Green
      default:
        return const Color(0xFF7A6B70);
    }
  }
}
