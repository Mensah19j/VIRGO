import 'package:drift/drift.dart';
import 'package:virgo/core/constants/app_constants.dart';
import 'package:virgo/core/database/app_database.dart';
import 'package:virgo/core/utils/crypto_utils.dart';
import 'package:virgo/models/enums.dart';

class AuthRepository {
  final AppDatabase _db;

  AuthRepository(this._db);

  /// Stream of the current user based on stored settings
  Stream<User?> watchCurrentUser() {
    return _db.select(_db.appSettings).watchSingleOrNull().asyncMap((settings) async {
      if (settings == null || settings.currentUserId == null) {
        return null;
      }
      final user = await (_db.select(_db.users)
        ..where((u) => u.id.equals(settings.currentUserId!)))
        .getSingleOrNull();
      return user;
    });
  }

  /// Get current user as Future (for one-time fetch)
  Future<User?> getCurrentUser() async {
    final settings = await _db.select(_db.appSettings).getSingleOrNull();
    if (settings == null || settings.currentUserId == null) {
      return null;
    }
    return await (_db.select(_db.users)
      ..where((u) => u.id.equals(settings.currentUserId!)))
      .getSingleOrNull();
  }

  /// Register a new user
  Future<User> register({
    required String name,
    required String email,
    required String password,
    String? yearGroup,
    String? staffCode,
  }) async {
    // Check if email already exists
    final existing = await (_db.select(_db.users)
      ..where((u) => u.email.equals(email)))
      .getSingleOrNull();

    if (existing != null) {
      throw Exception('Email already in use.');
    }

    final isStaff = staffCode == AppConstants.staffRegistrationCode;
    final role = isStaff ? UserRole.staff.name : UserRole.student.name;

    final salt = CryptoUtils.generateSalt();
    final passwordHash = CryptoUtils.hashPassword(password, salt);

    final user = await _db.into(_db.users).insertReturning(
      UsersCompanion(
        email: Value(email),
        name: Value(name),
        passwordHash: Value(passwordHash),
        salt: Value(salt),
        role: Value(role),
        yearGroup: Value(yearGroup),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
        avatarColor: const Value(null),
      ),
    );

    // Auto-login after registration
    await _setCurrentUser(user.id);
    return user;
  }

  /// Login a user
  Future<User> login(String email, String password) async {
    final user = await (_db.select(_db.users)
      ..where((u) => u.email.equals(email)))
      .getSingleOrNull();

    if (user == null) {
      throw Exception('Invalid email or password.');
    }

    final isValid = CryptoUtils.verifyPassword(password, user.passwordHash, user.salt);
    if (!isValid) {
      throw Exception('Invalid email or password.');
    }

    await _setCurrentUser(user.id);
    return user;
  }

  /// Logout current user
  Future<void> logout() async {
    await _db.update(_db.appSettings).write(
      const AppSettingsCompanion(currentUserId: Value(null)),
    );
  }

  /// Get a user by ID
  Future<User?> getUserById(int id) async {
    return await (_db.select(_db.users)
      ..where((u) => u.id.equals(id)))
      .getSingleOrNull();
  }

  /// Get all students
  Stream<List<User>> watchAllStudents() {
    return (_db.select(_db.users)
      ..where((u) => u.role.equals(UserRole.student.name)))
      .watch();
  }

  Future<List<User>> getAllStudents() async {
    return await (_db.select(_db.users)
      ..where((u) => u.role.equals('student')))
      .get();
  }

  /// Get students by year group
  Future<List<User>> getStudentsByYearGroup(String yearGroup) async {
    return await (_db.select(_db.users)
      ..where((u) => u.role.equals('student') & u.yearGroup.equals(yearGroup)))
      .get();
  }

  /// Update user
  Future<void> updateUser(User user) async {
    await _db.update(_db.users).replace(
      user.copyWith(updatedAt: DateTime.now()),
    );
  }

  /// Seed default staff account if not exists
  Future<void> seedDefaultStaff() async {
    final existing = await (_db.select(_db.users)
      ..where((u) => u.email.equals(AppConstants.defaultStaffEmail)))
      .getSingleOrNull();

    if (existing == null) {
      final salt = CryptoUtils.generateSalt();
      final passwordHash = CryptoUtils.hashPassword(
        AppConstants.defaultStaffPassword,
        salt,
      );

      await _db.into(_db.users).insert(
        UsersCompanion(
          name: const Value(AppConstants.defaultStaffName),
          email: const Value(AppConstants.defaultStaffEmail),
          passwordHash: Value(passwordHash),
          salt: Value(salt),
          role: Value(UserRole.staff.name), // Can't be const due to extension method
          yearGroup: const Value(null),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
          avatarColor: const Value(null),
        ),
      );
    }
  }

  /// Initialize app settings if not exists
  Future<void> ensureSettingsInitialized() async {
    final settings = await _db.select(_db.appSettings).getSingleOrNull();
    if (settings == null) {
      await _db.into(_db.appSettings).insert(
        const AppSettingsCompanion(
          id: Value(0),
          hasCompletedOnboarding: Value(false),
          currentUserId: Value(null),
          isDarkMode: Value(false),
        ),
      );
    }
  }

  Future<void> _setCurrentUser(int userId) async {
    await _db.update(_db.appSettings).write(
      AppSettingsCompanion(currentUserId: Value(userId)),
    );
  }

  /// Complete onboarding
  Future<void> completeOnboarding() async {
    await _db.update(_db.appSettings).write(
      const AppSettingsCompanion(hasCompletedOnboarding: Value(true)),
    );
  }

  /// Get settings
  Future<AppSetting> getSettings() async {
    final settings = await _db.select(_db.appSettings).getSingleOrNull();
    if (settings == null) {
      await ensureSettingsInitialized();
      // Use getSingleOrNull and fallback to a default if still null
      final retry = await _db.select(_db.appSettings).getSingleOrNull();
      if (retry == null) {
        throw Exception('Failed to initialize application settings.');
      }
      return retry;
    }
    return settings;
  }

  Stream<AppSetting?> watchSettings() {
    return _db.select(_db.appSettings).watchSingleOrNull();
  }

  /// Toggle dark mode
  Future<void> toggleTheme() async {
    final settings = await getSettings();
    await (_db.update(_db.appSettings)..where((t) => t.id.equals(0))).write(
      AppSettingsCompanion(isDarkMode: Value(!settings.isDarkMode)),
    );
  }
}

