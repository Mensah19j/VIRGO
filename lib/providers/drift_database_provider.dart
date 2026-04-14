import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:virgo/core/database/app_database.dart';
import 'package:virgo/repositories/auth_repository.dart';

part 'drift_database_provider.g.dart';

@riverpod
Future<AppDatabase> appDatabase(AppDatabaseRef ref) async {
  print('[Virgo] Initializing Database...');
  final db = await AppDatabase.open();
  print('[Virgo] Database Opened Successfully');
  
  // Initialize repository to seed default data
  final authRepo = AuthRepository(db);
  print('[Virgo] Ensuring Settings Initialized...');
  await authRepo.ensureSettingsInitialized();
  print('[Virgo] Seeding Default Staff...');
  await authRepo.seedDefaultStaff();
  print('[Virgo] Database Initialization Complete');
  
  ref.onDispose(() {
    print('[Virgo] Closing Database');
    db.close();
  });
  return db;
}
