import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virgo/core/constants/app_constants.dart';
import 'package:virgo/models/enums.dart';
import 'package:virgo/providers/school_update_provider.dart';
import 'package:virgo/widgets/empty_state.dart';
import 'package:virgo/widgets/loading_indicator.dart';
import 'package:virgo/widgets/theme_switcher.dart';
import 'package:virgo/widgets/update_card.dart';

class StudentFeedScreen extends ConsumerStatefulWidget {
  const StudentFeedScreen({super.key});

  @override
  ConsumerState<StudentFeedScreen> createState() => _StudentFeedScreenState();
}

class _StudentFeedScreenState extends ConsumerState<StudentFeedScreen> {
  UpdateCategory? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    // Watch updates with the current category filter
    final updatesAsync = ref.watch(schoolUpdatesProvider(category: _selectedCategory));

    return Scaffold(
      appBar: AppBar(
        title: const Text('School News'),
        actions: const [ThemeSwitcher()],
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
                        setState(() {
                          _selectedCategory = selected ? category : null;
                        });
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
                        ? 'There is currently no school news available.'
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
                            return UpdateCard(
                              update: updates[index],
                              isStaff: false,
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

