import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:virgo/core/database/app_database.dart';
import 'package:virgo/models/enums.dart';
import 'package:virgo/providers/auth_provider.dart';
import 'package:virgo/providers/drift_database_provider.dart';
import 'package:virgo/repositories/school_update_repository.dart';

part 'school_update_provider.g.dart';

@riverpod
class SchoolUpdates extends _$SchoolUpdates {
  @override
  Stream<List<SchoolUpdate>> build({UpdateCategory? category}) async* {
    final db = await ref.watch(appDatabaseProvider.future);
    final repo = SchoolUpdateRepository(db);
    yield* repo.watchAllUpdates(category: category?.name);
  }

  Future<void> createUpdate({
    required String title,
    required String content,
    required UpdateCategory category,
    bool isPinned = false,
  }) async {
    final author = ref.read(authStateProvider).valueOrNull;
    if (author == null) return;

    final db = ref.read(appDatabaseProvider).valueOrNull;
    if (db == null) return;

    final repo = SchoolUpdateRepository(db);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await repo.createUpdate(
        title: title,
        content: content,
        category: category.name,
        authorId: author.id,
        authorName: author.name,
        isPinned: isPinned,
      );
      return await repo.getAllUpdates(category: category.name);
    });
  }

  Future<void> deleteUpdate(int id) async {
    final db = ref.read(appDatabaseProvider).valueOrNull;
    if (db == null) return;

    final repo = SchoolUpdateRepository(db);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await repo.deletePost(id);
      final category = this.category;
      return await repo.getAllUpdates(category: category?.name);
    });
  }

  Future<void> togglePin(int id) async {
    final db = ref.read(appDatabaseProvider).valueOrNull;
    if (db == null) return;

    final repo = SchoolUpdateRepository(db);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await repo.togglePin(id);
      final category = this.category;
      return await repo.getAllUpdates(category: category?.name);
    });
  }
}
