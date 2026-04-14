import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virgo/core/theme/app_colors.dart';
import 'package:virgo/providers/auth_provider.dart';
import 'package:virgo/providers/theme_provider.dart';
import 'package:virgo/widgets/animated_avatar.dart';
import 'package:virgo/widgets/glossy_card.dart';
import 'package:virgo/widgets/gradient_button.dart';

class StaffProfileScreen extends ConsumerWidget {
  const StaffProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).valueOrNull;
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    if (user == null) return const SizedBox.shrink();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Profile'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              ref.read(themeModeProvider.notifier).toggleTheme();
            },
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Center(
              child: AnimatedAvatar(
                name: user.name,
                radius: 60,
                animate: true,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              user.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            const Text(
              'Staff Member',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.goldDeep,
              ),
            ),
            const SizedBox(height: 48),
            GlossyCard(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.email_outlined, color: AppColors.wine),
                    title: const Text('Email Address'),
                    subtitle: Text(user.email),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.security_outlined, color: AppColors.wine),
                    title: const Text('Access Level'),
                    subtitle: const Text('Full Administrative Access'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            GradientButton(
              text: 'Log Out',
              isSecondary: true,
              onPressed: () {
                ref.read(authStateProvider.notifier).logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
