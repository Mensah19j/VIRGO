import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:virgo/core/constants/app_constants.dart';
import 'package:virgo/core/utils/theme_extensions.dart';
import 'package:virgo/models/enums.dart';
import 'package:virgo/providers/school_update_provider.dart';
import 'package:virgo/widgets/app_text_field.dart';
import 'package:virgo/widgets/gradient_button.dart';
import 'package:virgo/widgets/theme_switcher.dart';

class CreateUpdateScreen extends ConsumerStatefulWidget {
  const CreateUpdateScreen({super.key});

  @override
  ConsumerState<CreateUpdateScreen> createState() => _CreateUpdateScreenState();
}

class _CreateUpdateScreenState extends ConsumerState<CreateUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  
  UpdateCategory _selectedCategory = UpdateCategory.general;
  bool _isPinned = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(schoolUpdatesProvider().notifier).createUpdate(
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        category: _selectedCategory,
        isPinned: _isPinned,
      );
      
      if (mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Update'),
        actions: const [ThemeSwitcher()],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            AppTextField(
              label: 'Title',
              hint: 'Enter a clear, descriptive title',
              controller: _titleController,
              validator: (val) {
                if (val == null || val.trim().isEmpty) return 'Title is required';
                return null;
              },
            ),
            const SizedBox(height: 24),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
                  child: Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.primary.withValues(alpha: 0.85),
                    ),
                  ),
                ),
                DropdownButtonFormField<UpdateCategory>(
                  initialValue: _selectedCategory,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: context.colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: context.colorScheme.outline,
                      ),
                    ),
                  ),
                  items: UpdateCategory.values.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(AppConstants.getCategoryLabel(category)),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedCategory = val);
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            AppTextField(
              label: 'Content',
              hint: 'Write the full announcement here...',
              controller: _contentController,
              maxLines: 8,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              validator: (val) {
                if (val == null || val.trim().isEmpty) return 'Content is required';
                return null;
              },
            ),
            const SizedBox(height: 24),
            
            SwitchListTile(
              title: const Text('Pin to top of feed'),
              subtitle: const Text('Pinned updates are always visible first.'),
              value: _isPinned,
              activeThumbColor: context.appColors.gold,
              contentPadding: EdgeInsets.zero,
              onChanged: (val) => setState(() => _isPinned = val),
            ),
            
            const SizedBox(height: 48),
            GradientButton(
              text: 'Publish',
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

