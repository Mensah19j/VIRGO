import 'package:flutter/material.dart';
import 'package:virgo/core/constants/app_constants.dart';
import 'package:virgo/core/database/app_database.dart';
import 'package:virgo/core/theme/app_colors.dart';
import 'package:virgo/core/utils/date_utils.dart';

class MotivationHistoryTile extends StatelessWidget {
  final MotivationEntry entry;

  const MotivationHistoryTile({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final color = AppColors.getMotivationColor(entry.level);
    final emoji = AppConstants.motivationEmojis[entry.level]!;
    final label = AppConstants.motivationLabels[entry.level]!;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withValues(alpha:isDark ? 0.2 : 0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppDateUtils.formatDate(entry.date),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
        subtitle: entry.note != null && entry.note!.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  entry.note!,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
