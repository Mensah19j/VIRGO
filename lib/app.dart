import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virgo/core/router/app_router.dart';
import 'package:virgo/core/theme/app_theme.dart';
import 'package:virgo/providers/theme_provider.dart';

class VirgoApp extends ConsumerWidget {
  const VirgoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themeModeProvider);
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Virgo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeModeAsync.valueOrNull ?? ThemeMode.system,
      routerConfig: router,
    );
  }
}
