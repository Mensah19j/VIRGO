// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_update_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$schoolUpdatesHash() => r'c3a70cee39727f7653594b8b7d9097253a234023';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$SchoolUpdates
    extends BuildlessAutoDisposeStreamNotifier<List<SchoolUpdate>> {
  late final UpdateCategory? category;

  Stream<List<SchoolUpdate>> build({
    UpdateCategory? category,
  });
}

/// See also [SchoolUpdates].
@ProviderFor(SchoolUpdates)
const schoolUpdatesProvider = SchoolUpdatesFamily();

/// See also [SchoolUpdates].
class SchoolUpdatesFamily extends Family<AsyncValue<List<SchoolUpdate>>> {
  /// See also [SchoolUpdates].
  const SchoolUpdatesFamily();

  /// See also [SchoolUpdates].
  SchoolUpdatesProvider call({
    UpdateCategory? category,
  }) {
    return SchoolUpdatesProvider(
      category: category,
    );
  }

  @override
  SchoolUpdatesProvider getProviderOverride(
    covariant SchoolUpdatesProvider provider,
  ) {
    return call(
      category: provider.category,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'schoolUpdatesProvider';
}

/// See also [SchoolUpdates].
class SchoolUpdatesProvider extends AutoDisposeStreamNotifierProviderImpl<
    SchoolUpdates, List<SchoolUpdate>> {
  /// See also [SchoolUpdates].
  SchoolUpdatesProvider({
    UpdateCategory? category,
  }) : this._internal(
          () => SchoolUpdates()..category = category,
          from: schoolUpdatesProvider,
          name: r'schoolUpdatesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$schoolUpdatesHash,
          dependencies: SchoolUpdatesFamily._dependencies,
          allTransitiveDependencies:
              SchoolUpdatesFamily._allTransitiveDependencies,
          category: category,
        );

  SchoolUpdatesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
  }) : super.internal();

  final UpdateCategory? category;

  @override
  Stream<List<SchoolUpdate>> runNotifierBuild(
    covariant SchoolUpdates notifier,
  ) {
    return notifier.build(
      category: category,
    );
  }

  @override
  Override overrideWith(SchoolUpdates Function() create) {
    return ProviderOverride(
      origin: this,
      override: SchoolUpdatesProvider._internal(
        () => create()..category = category,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        category: category,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<SchoolUpdates, List<SchoolUpdate>>
      createElement() {
    return _SchoolUpdatesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SchoolUpdatesProvider && other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SchoolUpdatesRef
    on AutoDisposeStreamNotifierProviderRef<List<SchoolUpdate>> {
  /// The parameter `category` of this provider.
  UpdateCategory? get category;
}

class _SchoolUpdatesProviderElement
    extends AutoDisposeStreamNotifierProviderElement<SchoolUpdates,
        List<SchoolUpdate>> with SchoolUpdatesRef {
  _SchoolUpdatesProviderElement(super.provider);

  @override
  UpdateCategory? get category => (origin as SchoolUpdatesProvider).category;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
