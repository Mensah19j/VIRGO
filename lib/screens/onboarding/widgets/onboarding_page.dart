import 'package:flutter/material.dart';
import 'package:virgo/core/utils/theme_extensions.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData? icon;
  final String? imagePath;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    this.icon,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(imagePath != null ? 0 : 32),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colorScheme.onPrimary.withValues(alpha: 0.1),
              border: Border.all(
                color: context.appColors.gold.withValues(alpha: 0.5),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: context.appColors.wineDeep.withValues(alpha: 0.5),
                  blurRadius: 30,
                  spreadRadius: 10,
                )
              ],
            ),
            child: imagePath != null
                ? ClipOval(
                    child: Image.asset(
                      imagePath!,
                      width: 164,
                      height: 164,
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(
                    icon,
                    size: 100,
                    color: context.appColors.gold,
                  ),
          ),
          const SizedBox(height: 64),
          Text(
            title,
            style: context.textTheme.displaySmall?.copyWith(
              color: context.colorScheme.onPrimary,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            description,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onPrimary.withValues(alpha: 0.8),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

