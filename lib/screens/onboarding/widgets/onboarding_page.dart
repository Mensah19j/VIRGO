import 'package:flutter/material.dart';
import 'package:virgo/core/theme/app_colors.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfaceLight.withValues(alpha:0.1),
              border: Border.all(
                color: AppColors.gold.withValues(alpha:0.5),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.wineDeep.withValues(alpha:0.5),
                  blurRadius: 30,
                  spreadRadius: 10,
                )
              ],
            ),
            child: Icon(
              icon,
              size: 100,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(height: 64),
          Text(
            title,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppColors.surfaceLight,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.surfaceLight.withValues(alpha:0.8),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
