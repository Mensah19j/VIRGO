import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get email => text().unique()();
  TextColumn get name => text()();
  TextColumn get passwordHash => text()();
  TextColumn get salt => text()();
  TextColumn get role => text()();
  TextColumn get yearGroup => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get avatarColor => text().nullable()();
}

class MotivationEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer()();
  DateTimeColumn get date => dateTime()();
  IntColumn get level => integer()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

class SchoolUpdates extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get authorId => integer()();
  TextColumn get authorName => text()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  TextColumn get category => text()();
  BoolColumn get isPinned => boolean()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class AppSettings extends Table {
  IntColumn get id => integer()();
  BoolColumn get hasCompletedOnboarding => boolean()();
  IntColumn get currentUserId => integer().nullable()();
  BoolColumn get isDarkMode => boolean()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [Users, MotivationEntries, SchoolUpdates, AppSettings])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  static Future<AppDatabase> open() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'virgo.sqlite'));
    return AppDatabase(NativeDatabase.createInBackground(file));
  }

  @override
  int get schemaVersion => 1;
}
