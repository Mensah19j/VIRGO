import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:virgo/core/database/app_database.dart';

part 'drift_database_provider.g.dart';

@riverpod
Future<AppDatabase> appDatabase(AppDatabaseRef ref) async {
  final db = await AppDatabase.open();
  ref.onDispose(() => db.close());
  return db;
}
