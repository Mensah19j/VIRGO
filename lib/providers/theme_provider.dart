import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:virgo/providers/drift_database_provider.dart';
import 'package:virgo/repositories/auth_repository.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  Stream<ThemeMode> build() async* {
    final db = await ref.watch(appDatabaseProvider.future);
    final repo = AuthRepository(db);

    await for (final settings in repo.watchSettings()) {
      yield settings.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    }
  }

  Future<void> toggleTheme() async {
    final db = ref.read(appDatabaseProvider).valueOrNull;
    if (db == null) return;

    final repo = AuthRepository(db);
    await repo.toggleTheme();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    // For now, just toggle - in a full implementation, you'd set explicitly
    final db = ref.read(appDatabaseProvider).valueOrNull;
    if (db == null) return;

    final repo = AuthRepository(db);
    final settings = await repo.getSettings();
    final isDark = mode == ThemeMode.dark;
    if (settings.isDarkMode != isDark) {
      await repo.toggleTheme();
    }
  }
}

// Keeping a simple alias to conform to standard naming expectations
final themeModeProvider = themeModeNotifierProvider;
