// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'motivation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hasLoggedTodayHash() => r'8fd714c39245aa9a6be972f8085717324fe96440';

/// Stream of whether the current user has logged motivation today
///
/// Copied from [hasLoggedToday].
@ProviderFor(hasLoggedToday)
final hasLoggedTodayProvider = AutoDisposeStreamProvider<bool>.internal(
  hasLoggedToday,
  name: r'hasLoggedTodayProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasLoggedTodayHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HasLoggedTodayRef = AutoDisposeStreamProviderRef<bool>;
String _$motivationHistoryHash() => r'49d5b6df556bba47abcdda89f7ec046215fa7bfd';

/// Provides a stream of the student's motivation history
///
/// Copied from [MotivationHistory].
@ProviderFor(MotivationHistory)
final motivationHistoryProvider = AutoDisposeStreamNotifierProvider<
    MotivationHistory, List<MotivationEntry>>.internal(
  MotivationHistory.new,
  name: r'motivationHistoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$motivationHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MotivationHistory = AutoDisposeStreamNotifier<List<MotivationEntry>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
