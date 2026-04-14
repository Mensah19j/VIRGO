import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virgo/core/router/app_router.dart';
import 'package:virgo/core/theme/app_theme.dart';
import 'package:virgo/main.dart';
import 'package:virgo/providers/theme_provider.dart';

class VirgoApp extends ConsumerWidget {
  const VirgoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bootstrapAsync = ref.watch(appBootstrapProvider);
    final themeModeAsync = ref.watch(themeModeProvider);
    final router = themeModeAsync.hasValue ? ref.watch(routerProvider) : null;

    // Handle Bootstrap Errors
    if (bootstrapAsync.hasError) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline_rounded, color: Colors.red, size: 64),
                  const SizedBox(height: 16),
                  const Text(
                    'Initialization Error',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please restart the app. If the issue persists, contact support.\n\n${bootstrapAsync.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // While bootstrapping (DB & Theme loading), show a minimal branded background
    if (bootstrapAsync.isLoading || !themeModeAsync.hasValue || router == null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        // Fallback to system while loading, but we'll show a splash color
        home: Scaffold(
          backgroundColor: const Color(0xFF722F37), // Brand wine color
          body: const SizedBox.shrink(),
        ),
      );
    }

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

