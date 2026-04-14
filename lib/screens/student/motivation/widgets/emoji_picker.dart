import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:virgo/core/constants/app_constants.dart';
import 'package:virgo/core/theme/app_colors.dart';

class EmojiPicker extends StatelessWidget {
  final int? selectedLevel;
  final ValueChanged<int> onSelected;
  final bool disabled;

  const EmojiPicker({
    super.key,
    required this.selectedLevel,
    required this.onSelected,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (index) {
        final level = index + 1;
        final isSelected = selectedLevel == level;
        final color = AppColors.getMotivationColor(level);
        final emoji = AppConstants.motivationEmojis[level]!;
        final label = AppConstants.motivationLabels[level]!;

        return GestureDetector(
          onTap: disabled ? null : () => onSelected(level),
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? color.withValues(alpha:0.2) : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? color : Colors.transparent,
                    width: 3,
                  ),
                ),
                transform: Matrix4.diagonal3Values(isSelected ? 1.15 : 1.0, isSelected ? 1.15 : 1.0, 1.0),
                child: Text(
                  emoji,
                  style: TextStyle(
                    fontSize: 32,
                    // Grayscale if disabled and not selected
                    color: disabled && !isSelected ? Colors.grey : null,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              if (isSelected)
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 12,
                  ),
                ).animate().fadeIn().slideY(begin: 0.2),
            ],
          ),
        );
      }),
    );
  }
}
