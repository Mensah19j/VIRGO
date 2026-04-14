import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:virgo/core/database/app_database.dart';
import 'package:virgo/providers/drift_database_provider.dart';
import 'package:virgo/repositories/auth_repository.dart';
import 'package:virgo/models/enums.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthState extends _$AuthState {
  @override
  Stream<User?> build() async* {
    final db = await ref.watch(appDatabaseProvider.future);
    final repo = AuthRepository(db);
    yield* repo.watchCurrentUser();
  }

  AuthRepository _getRepo() {
    final db = ref.read(appDatabaseProvider).valueOrNull;
    if (db == null) throw Exception('Database not initialized');
    return AuthRepository(db);
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _getRepo().login(email, password);
    });
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    String? yearGroup,
    String? staffCode,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _getRepo().register(
        name: name,
        email: email,
        password: password,
        yearGroup: yearGroup,
        staffCode: staffCode,
      );
    });
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    await _getRepo().logout();
    state = const AsyncValue.data(null);
  }
}

@riverpod
bool isLoggedIn(IsLoggedInRef ref) {
  final userAsync = ref.watch(authStateProvider);
  return userAsync.valueOrNull != null;
}

@riverpod
bool isStaff(IsStaffRef ref) {
  final userAsync = ref.watch(authStateProvider);
  final user = userAsync.valueOrNull;
  return user?.role == UserRole.staff.name;
}
