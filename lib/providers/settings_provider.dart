import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:virgo/core/database/app_database.dart';
import 'package:virgo/providers/drift_database_provider.dart';
import 'package:virgo/repositories/auth_repository.dart';

part 'settings_provider.g.dart';

@riverpod
class SettingsState extends _$SettingsState {
  @override
  Stream<AppSetting> build() async* {
    final db = await ref.watch(appDatabaseProvider.future);
    final repo = AuthRepository(db);
    
    await for (final settings in repo.watchSettings()) {
      if (settings != null) {
        print('[Virgo] Settings Loaded: hasOnboarding=${settings.hasCompletedOnboarding}');
        yield settings;
      } else {
        // Fallback to a default object rather than yielding nothing (which causes hangs)
        print('[Virgo] Settings Null - yielding defaults');
        yield AppSetting(
          id: 0,
          hasCompletedOnboarding: false,
          currentUserId: null,
          isDarkMode: false,
        );
      }
    }
  }

  Future<void> setOnboardingComplete() async {
    final db = ref.read(appDatabaseProvider).valueOrNull;
    if (db == null) return;

    final repo = AuthRepository(db);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await repo.completeOnboarding();
      return await repo.getSettings();
    });
  }
}
