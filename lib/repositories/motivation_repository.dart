import 'package:drift/drift.dart';
import 'package:virgo/core/database/app_database.dart';
import 'package:virgo/core/utils/date_utils.dart';

class MotivationRepository {
  final AppDatabase _db;

  MotivationRepository(this._db);

  /// Log a motivation entry for a user
  Future<MotivationEntry> logMotivation(int userId, int level, {String? note}) async {
    final today = AppDateUtils.dateOnly(DateTime.now());

    // Check if already logged today
    final existing = await getTodayEntry(userId);
    if (existing != null) {
      throw Exception('Already logged motivation today.');
    }

    final entry = await _db.into(_db.motivationEntries).insertReturning(
      MotivationEntriesCompanion(
        userId: Value(userId),
        date: Value(today),
        level: Value(level),
        note: Value(note),
        createdAt: Value(DateTime.now()),
      ),
    );

    return entry;
  }

  /// Get today's entry for a user
  Future<MotivationEntry?> getTodayEntry(int userId) async {
    final today = AppDateUtils.dateOnly(DateTime.now());
    return await (_db.select(_db.motivationEntries)
      ..where((e) => e.userId.equals(userId) & e.date.equals(today)))
      .getSingleOrNull();
  }

  /// Watch today's entry for a user
  Stream<MotivationEntry?> watchTodayEntry(int userId) {
    final today = AppDateUtils.dateOnly(DateTime.now());
    return (_db.select(_db.motivationEntries)
      ..where((e) => e.userId.equals(userId) & e.date.equals(today)))
      .watchSingleOrNull();
  }

  /// Watch if user has logged today
  Stream<bool> watchHasLoggedToday(int userId) {
    return watchTodayEntry(userId).map((entry) => entry != null);
  }

  /// Get history for a user
  Future<List<MotivationEntry>> getHistory(int userId, {int? days}) async {
    var query = _db.select(_db.motivationEntries)
      ..where((e) => e.userId.equals(userId))
      ..orderBy([(e) => OrderingTerm.desc(e.date)]);

    if (days != null) {
      final startDate = AppDateUtils.dateOnly(DateTime.now().subtract(Duration(days: days)));
      query = _db.select(_db.motivationEntries)
        ..where((e) => e.userId.equals(userId) & e.date.isBiggerOrEqualValue(startDate))
        ..orderBy([(e) => OrderingTerm.desc(e.date)]);
    }

    return await query.get();
  }

  /// Watch history for a user
  Stream<List<MotivationEntry>> watchHistory(int userId, {int? days}) {
    if (days != null) {
      final startDate = AppDateUtils.dateOnly(DateTime.now().subtract(Duration(days: days)));
      return (_db.select(_db.motivationEntries)
        ..where((e) => e.userId.equals(userId) & e.date.isBiggerOrEqualValue(startDate))
        ..orderBy([(e) => OrderingTerm.desc(e.date)]))
        .watch();
    }

    return (_db.select(_db.motivationEntries)
      ..where((e) => e.userId.equals(userId))
      ..orderBy([(e) => OrderingTerm.desc(e.date)]))
      .watch();
  }

  /// Get average motivation level for a date range
  Future<double> getAverageByDateRange(DateTime startDate, DateTime endDate) async {
    final entries = await (_db.select(_db.motivationEntries)
      ..where((e) => e.date.isBetweenValues(startDate, endDate)))
      .get();

    if (entries.isEmpty) return 0.0;

    final sum = entries.fold<int>(0, (prev, entry) => prev + entry.level);
    return sum / entries.length;
  }

  /// Get distribution of motivation levels for a date range
  Future<Map<int, int>> getDistribution(DateTime startDate, DateTime endDate) async {
    final entries = await (_db.select(_db.motivationEntries)
      ..where((e) => e.date.isBetweenValues(startDate, endDate)))
      .get();

    final distribution = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};

    for (var entry in entries) {
      if (distribution.containsKey(entry.level)) {
        distribution[entry.level] = distribution[entry.level]! + 1;
      }
    }

    return distribution;
  }

  /// Get total entries logged today
  Future<int> getTotalLoggedToday() async {
    final today = AppDateUtils.dateOnly(DateTime.now());
    final countExp = countAll();
    final query = _db.selectOnly(_db.motivationEntries)
      ..addColumns([countExp])
      ..where(_db.motivationEntries.date.equals(today));
    final result = await query.getSingle();
    return result.read(countExp) ?? 0;
  }

  /// Watch total entries logged today
  Stream<int> watchTotalLoggedToday() {
    final today = AppDateUtils.dateOnly(DateTime.now());
    final countExp = countAll();
    final query = _db.selectOnly(_db.motivationEntries)
      ..addColumns([countExp])
      ..where(_db.motivationEntries.date.equals(today));
    return query.watchSingle().map((row) => row.read(countExp) ?? 0);
  }
}
