import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color wine;
  final Color wineDeep;
  final Color wineLight;
  final Color gold;
  final Color goldDeep;
  final Color goldLight;

  const AppColorsExtension({
    required this.wine,
    required this.wineDeep,
    required this.wineLight,
    required this.gold,
    required this.goldDeep,
    required this.goldLight,
  });

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? wine,
    Color? wineDeep,
    Color? wineLight,
    Color? gold,
    Color? goldDeep,
    Color? goldLight,
  }) {
    return AppColorsExtension(
      wine: wine ?? this.wine,
      wineDeep: wineDeep ?? this.wineDeep,
      wineLight: wineLight ?? this.wineLight,
      gold: gold ?? this.gold,
      goldDeep: goldDeep ?? this.goldDeep,
      goldLight: goldLight ?? this.goldLight,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      wine: Color.lerp(wine, other.wine, t)!,
      wineDeep: Color.lerp(wineDeep, other.wineDeep, t)!,
      wineLight: Color.lerp(wineLight, other.wineLight, t)!,
      gold: Color.lerp(gold, other.gold, t)!,
      goldDeep: Color.lerp(goldDeep, other.goldDeep, t)!,
      goldLight: Color.lerp(goldLight, other.goldLight, t)!,
    );
  }

  static const light = AppColorsExtension(
    wine: AppColors.wine,
    wineDeep: AppColors.wineDeep,
    wineLight: AppColors.wineLight,
    gold: AppColors.gold,
    goldDeep: AppColors.goldDeep,
    goldLight: AppColors.goldLight,
  );

  static const dark = AppColorsExtension(
    wine: AppColors.wineLight,
    wineDeep: AppColors.wine,
    wineLight: AppColors.wineLight,
    gold: AppColors.gold,
    goldDeep: AppColors.goldDeep,
    goldLight: AppColors.goldLight,
  );
}
