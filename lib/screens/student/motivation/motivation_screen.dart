import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virgo/providers/motivation_provider.dart';
import 'package:virgo/screens/student/motivation/widgets/emoji_picker.dart';
import 'package:virgo/screens/student/motivation/widgets/motivation_history_tile.dart';
import 'package:virgo/widgets/app_text_field.dart';
import 'package:virgo/widgets/empty_state.dart';
import 'package:virgo/widgets/glossy_card.dart';
import 'package:virgo/widgets/gradient_button.dart';
import 'package:virgo/widgets/loading_indicator.dart';
import 'package:virgo/widgets/section_header.dart';
import 'package:virgo/widgets/theme_switcher.dart';

class MotivationScreen extends ConsumerStatefulWidget {
  const MotivationScreen({super.key});

  @override
  ConsumerState<MotivationScreen> createState() => _MotivationScreenState();
}

class _MotivationScreenState extends ConsumerState<MotivationScreen> {
  final _noteController = TextEditingController();
  int? _selectedLevel;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _submitMotivation() {
    if (_selectedLevel != null) {
      ref.read(motivationHistoryProvider.notifier).logMotivation(
        _selectedLevel!,
        note: _noteController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(motivationHistoryProvider);
    final hasLoggedAsync = ref.watch(hasLoggedTodayProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Motivation'),
        actions: const [ThemeSwitcher()],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: hasLoggedAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(32.0),
                child: LoadingIndicator(),
              ),
              error: (err, stack) => Text('Error: $err'),
              data: (hasLogged) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GlossyCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          hasLogged 
                               ? 'You have already logged your motivation today.'
                               : 'How are you feeling today?',
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        EmojiPicker(
                          selectedLevel: _selectedLevel,
                          disabled: hasLogged,
                          onSelected: (level) {
                            setState(() {
                              _selectedLevel = level;
                            });
                          },
                        ),
                        if (!hasLogged) ...[
                          const SizedBox(height: 32),
                          AppTextField(
                            label: 'Add a note (optional)',
                            hint: 'Why are you feeling this way?',
                            controller: _noteController,
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                          ),
                          const SizedBox(height: 24),
                          GradientButton(
                            text: 'Submit Check-in',
                            isLoading: historyAsync.isLoading,
                            onPressed: _selectedLevel != null ? _submitMotivation : null,
                          ),
                        ]
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          const SliverToBoxAdapter(
            child: SectionHeader(title: 'History'),
          ),

          historyAsync.when(
            loading: () => const SliverToBoxAdapter(child: LoadingIndicator()),
            error: (err, stack) => SliverToBoxAdapter(child: Text('Error: $err')),
            data: (history) {
              if (history.isEmpty) {
                return const SliverToBoxAdapter(
                  child: EmptyState(
                    title: 'No check-ins yet',
                    message: 'Start logging your daily motivation to build your history.',
                    icon: Icons.history_rounded,
                  ),
                );
              }
              
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return MotivationHistoryTile(entry: history[index]);
                    },
                    childCount: history.length,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

