import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virgo/core/utils/theme_extensions.dart';
import 'package:virgo/providers/theme_provider.dart';

class ThemeSwitcher extends ConsumerWidget {
  final Color? color;
  
  const ThemeSwitcher({super.key, this.color});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider).valueOrNull ?? ThemeMode.system;
    
    // Determine effective brightness to show correct icon
    final bool isDark = themeMode == ThemeMode.dark || 
        (themeMode == ThemeMode.system && 
         View.of(context).platformDispatcher.platformBrightness == Brightness.dark);

    return IconButton(
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return RotationTransition(
            turns: animation,
            child: ScaleTransition(scale: animation, child: child),
          );
        },
        child: Icon(
          isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          key: ValueKey(isDark),
          color: color ?? (isDark ? context.colorScheme.secondary : context.colorScheme.primary),
        ),
      ),
      onPressed: () {
        ref.read(themeModeProvider.notifier).toggleTheme();
      },
      tooltip: 'Toggle Theme',
    );
  }
}
