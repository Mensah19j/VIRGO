import 'package:flutter/material.dart';
import 'package:virgo/core/constants/app_constants.dart';
import 'package:virgo/core/database/app_database.dart';
import 'package:virgo/core/utils/date_utils.dart';
import 'package:virgo/core/utils/theme_extensions.dart';
import 'package:virgo/models/enums.dart';
import 'package:virgo/widgets/animated_avatar.dart';
import 'package:virgo/widgets/glossy_card.dart';

class UpdateCard extends StatelessWidget {
  final SchoolUpdate update;
  final bool isStaff;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onPinToggle;

  const UpdateCard({
    super.key,
    required this.update,
    this.isStaff = false,
    this.onEdit,
    this.onDelete,
    this.onPinToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GlossyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedAvatar(
                name: update.authorName,
                radius: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            update.authorName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        if (update.isPinned)
                          Icon(
                            Icons.push_pin,
                            color: context.colorScheme.secondary,
                            size: 16,
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      AppDateUtils.formatRelative(update.createdAt),
                      style: TextStyle(
                        color: context.textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Category Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: context.isDark
                  ? context.appColors.gold.withValues(alpha: 0.15)
                  : context.appColors.goldLight.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.appColors.gold.withValues(alpha: 0.5),
                width: 0.5,
              ),
            ),
            child: Text(
              AppConstants.getCategoryLabel(UpdateCategory.values.firstWhere((c) => c.name == update.category))
                  .toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: context.appColors.goldDeep,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            update.title,
            style: context.textTheme.titleLarge?.copyWith(
              color: context.isDark ? context.colorScheme.onSurface : context.appColors.wineDeep,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            update.content,
            style: context.textTheme.bodyMedium?.copyWith(
              height: 1.5,
            ),
          ),
          if (isStaff) ...[
            const SizedBox(height: 16),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: onPinToggle,
                  icon: Icon(
                    update.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                    color: update.isPinned ? context.colorScheme.secondary : null,
                  ),
                  tooltip: update.isPinned ? 'Unpin Post' : 'Pin Post',
                ),
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined),
                  tooltip: 'Edit Post',
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(
                    Icons.delete_outline,
                    color: context.colorScheme.error,
                  ),
                  tooltip: 'Delete Post',
                ),
              ],
            ),
          ]
        ],
      ),
    );
  }
}

