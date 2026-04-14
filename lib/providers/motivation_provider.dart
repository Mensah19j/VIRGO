import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:virgo/core/database/app_database.dart';
import 'package:virgo/providers/auth_provider.dart';
import 'package:virgo/providers/drift_database_provider.dart';
import 'package:virgo/repositories/motivation_repository.dart';

part 'motivation_provider.g.dart';

/// Provides a stream of the student's motivation history
@riverpod
class MotivationHistory extends _$MotivationHistory {
  @override
  Stream<List<MotivationEntry>> build() async* {
    final db = await ref.watch(appDatabaseProvider.future);
    final repo = MotivationRepository(db);

    final user = await ref.watch(authStateProvider.future);
    if (user == null) {
      yield [];
      return;
    }

    yield* repo.watchHistory(user.id);
  }

  Future<void> logMotivation(int level, {String? note}) async {
    final db = ref.read(appDatabaseProvider).valueOrNull;
    if (db == null) return;

    final user = ref.read(authStateProvider).valueOrNull;
    if (user == null) return;

    final repo = MotivationRepository(db);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await repo.logMotivation(user.id, level, note: note);
      return await repo.getHistory(user.id);
    });
  }
}

/// Stream of whether the current user has logged motivation today
@riverpod
Stream<bool> hasLoggedToday(HasLoggedTodayRef ref) async* {
  final db = await ref.watch(appDatabaseProvider.future);
  final repo = MotivationRepository(db);

  final user = await ref.watch(authStateProvider.future);
  if (user == null) {
    yield false;
    return;
  }

  yield* repo.watchHasLoggedToday(user.id);
}
