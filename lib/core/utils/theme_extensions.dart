import 'package:flutter/material.dart';
import 'package:virgo/core/theme/app_colors_extension.dart';

extension ThemeExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  
  AppColorsExtension get appColors => 
      theme.extension<AppColorsExtension>() ?? AppColorsExtension.light;

  bool get isDark => theme.brightness == Brightness.dark;
}
