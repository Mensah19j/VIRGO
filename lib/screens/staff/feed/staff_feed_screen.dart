import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:virgo/core/constants/app_constants.dart';
import 'package:virgo/core/utils/theme_extensions.dart';
import 'package:virgo/models/enums.dart';
import 'package:virgo/providers/school_update_provider.dart';
import 'package:virgo/widgets/empty_state.dart';
import 'package:virgo/widgets/loading_indicator.dart';
import 'package:virgo/widgets/theme_switcher.dart';
import 'package:virgo/widgets/update_card.dart';

class StaffFeedScreen extends ConsumerStatefulWidget {
  const StaffFeedScreen({super.key});

  @override
  ConsumerState<StaffFeedScreen> createState() => _StaffFeedScreenState();
}

class _StaffFeedScreenState extends ConsumerState<StaffFeedScreen> {
  UpdateCategory? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final updatesAsync = ref.watch(schoolUpdatesProvider(category: _selectedCategory));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage News'),
        actions: const [ThemeSwitcher()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/staff/feed/create'),
        backgroundColor: context.colorScheme.secondary,
        foregroundColor: context.colorScheme.onSecondary,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: const Text('All'),
                    selected: _selectedCategory == null,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedCategory = null);
                      }
                    },
                  ),
                ),
                ...UpdateCategory.values.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(AppConstants.getCategoryLabel(category)),
                      selected: _selectedCategory == category,
                      onSelected: (selected) {
                        setState(() => _selectedCategory = selected ? category : null);
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
          
          const Divider(),
          
          Expanded(
            child: updatesAsync.when(
              loading: () => const LoadingIndicator(message: 'Loading updates...'),
              error: (err, stack) => Center(child: Text('Error: $err')),
              data: (updates) {
                if (updates.isEmpty) {
                  return EmptyState(
                    title: 'No Updates',
                    message: _selectedCategory == null 
                        ? 'There are no updates. Click + to create.'
                        : 'No updates found in this category.',
                    icon: Icons.newspaper_rounded,
                  );
                }
                
                return CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(16.0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final update = updates[index];
                            return UpdateCard(
                              update: update,
                              isStaff: true,
                              onPinToggle: () {
                                ref.read(schoolUpdatesProvider().notifier).togglePin(update.id);
                              },
                              onDelete: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Delete Post?'),
                                    content: const Text('This action cannot be undone.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          ref.read(schoolUpdatesProvider().notifier).deleteUpdate(update.id);
                                          Navigator.pop(context);
                                        },
                                        style: TextButton.styleFrom(foregroundColor: context.colorScheme.error),
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          childCount: updates.length,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

