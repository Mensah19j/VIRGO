import 'package:drift/drift.dart';
import 'package:virgo/core/database/app_database.dart';

class SchoolUpdateRepository {
  final AppDatabase _db;

  SchoolUpdateRepository(this._db);

  /// Create a new school update
  Future<SchoolUpdate> createUpdate({
    required String title,
    required String content,
    required String category,
    required int authorId,
    required String authorName,
    bool isPinned = false,
  }) async {
    final update = await _db.into(_db.schoolUpdates).insertReturning(
      SchoolUpdatesCompanion(
        title: Value(title),
        content: Value(content),
        category: Value(category),
        authorId: Value(authorId),
        authorName: Value(authorName),
        isPinned: Value(isPinned),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );

    return update;
  }

  /// Get all updates, optionally filtered by category
  Future<List<SchoolUpdate>> getAllUpdates({String? category}) async {
    var query = _db.select(_db.schoolUpdates)
      ..orderBy([
        (u) => OrderingTerm.desc(u.isPinned),
        (u) => OrderingTerm.desc(u.createdAt),
      ]);

    if (category != null) {
      query = _db.select(_db.schoolUpdates)
        ..where((u) => u.category.equals(category))
        ..orderBy([
          (u) => OrderingTerm.desc(u.isPinned),
          (u) => OrderingTerm.desc(u.createdAt),
        ]);
    }

    return await query.get();
  }

  /// Watch all updates with reactive updates
  Stream<List<SchoolUpdate>> watchAllUpdates({String? category}) {
    var query = _db.select(_db.schoolUpdates)
      ..orderBy([
        (u) => OrderingTerm.desc(u.isPinned),
        (u) => OrderingTerm.desc(u.createdAt),
      ]);

    if (category != null) {
      query = _db.select(_db.schoolUpdates)
        ..where((u) => u.category.equals(category))
        ..orderBy([
          (u) => OrderingTerm.desc(u.isPinned),
          (u) => OrderingTerm.desc(u.createdAt),
        ]);
    }

    return query.watch();
  }

  /// Get a single update by ID
  Future<SchoolUpdate?> getUpdateById(int id) async {
    return await (_db.select(_db.schoolUpdates)
      ..where((u) => u.id.equals(id)))
      .getSingleOrNull();
  }

  /// Update an existing post
  Future<void> updatePost(SchoolUpdate update) async {
    await _db.update(_db.schoolUpdates).replace(
      update.copyWith(updatedAt: DateTime.now()),
    );
  }

  /// Delete a post
  Future<void> deletePost(int id) async {
    await (_db.delete(_db.schoolUpdates)
      ..where((u) => u.id.equals(id)))
      .go();
  }

  /// Toggle pin status
  Future<SchoolUpdate?> togglePin(int id) async {
    final update = await getUpdateById(id);
    if (update != null) {
      final toggled = await _db.update(_db.schoolUpdates).replace(
        update.copyWith(
          isPinned: !update.isPinned,
          updatedAt: DateTime.now(),
        ),
      );
      if (toggled) {
        return await getUpdateById(id);
      }
    }
    return null;
  }
}
