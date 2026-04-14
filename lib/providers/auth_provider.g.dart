// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isLoggedInHash() => r'05973e871f74d5d3260a81bd9341eaf5381fd75b';

/// See also [isLoggedIn].
@ProviderFor(isLoggedIn)
final isLoggedInProvider = AutoDisposeProvider<bool>.internal(
  isLoggedIn,
  name: r'isLoggedInProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isLoggedInHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsLoggedInRef = AutoDisposeProviderRef<bool>;
String _$isStaffHash() => r'd153edace2f96fbbfc59fb0f5643bd528d1b9d77';

/// See also [isStaff].
@ProviderFor(isStaff)
final isStaffProvider = AutoDisposeProvider<bool>.internal(
  isStaff,
  name: r'isStaffProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isStaffHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsStaffRef = AutoDisposeProviderRef<bool>;
String _$authStateHash() => r'10a4b2c93500f62c765843e537c8edd95fedf919';

/// See also [AuthState].
@ProviderFor(AuthState)
final authStateProvider =
    AutoDisposeStreamNotifierProvider<AuthState, User?>.internal(
  AuthState.new,
  name: r'authStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthState = AutoDisposeStreamNotifier<User?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
