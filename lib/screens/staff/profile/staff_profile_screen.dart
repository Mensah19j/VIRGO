import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virgo/core/utils/theme_extensions.dart';
import 'package:virgo/providers/auth_provider.dart';
import 'package:virgo/widgets/animated_avatar.dart';
import 'package:virgo/widgets/glossy_card.dart';
import 'package:virgo/widgets/gradient_button.dart';
import 'package:virgo/widgets/theme_switcher.dart';

class StaffProfileScreen extends ConsumerWidget {
  const StaffProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).valueOrNull;

    if (user == null) return const SizedBox.shrink();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Profile'),
        actions: const [ThemeSwitcher()],
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
              style: context.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Staff Member',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: context.appColors.goldDeep,
              ),
            ),
            const SizedBox(height: 48),
            GlossyCard(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.email_outlined, color: context.appColors.wine),
                    title: const Text('Email Address'),
                    subtitle: Text(user.email),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.security_outlined, color: context.appColors.wine),
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

