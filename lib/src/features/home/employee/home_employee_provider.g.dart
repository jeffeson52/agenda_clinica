// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_employee_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getTotalScheduleTodayHash() =>
    r'772e1482c2e1c9e9b867ed834891b0f2aacc90af';

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

/// See also [getTotalScheduleToday].
@ProviderFor(getTotalScheduleToday)
const getTotalScheduleTodayProvider = GetTotalScheduleTodayFamily();

/// See also [getTotalScheduleToday].
class GetTotalScheduleTodayFamily extends Family<AsyncValue<int>> {
  /// See also [getTotalScheduleToday].
  const GetTotalScheduleTodayFamily();

  /// See also [getTotalScheduleToday].
  GetTotalScheduleTodayProvider call(
    int userId,
  ) {
    return GetTotalScheduleTodayProvider(
      userId,
    );
  }

  @override
  GetTotalScheduleTodayProvider getProviderOverride(
    covariant GetTotalScheduleTodayProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'getTotalScheduleTodayProvider';
}

/// See also [getTotalScheduleToday].
class GetTotalScheduleTodayProvider extends AutoDisposeFutureProvider<int> {
  /// See also [getTotalScheduleToday].
  GetTotalScheduleTodayProvider(
    int userId,
  ) : this._internal(
          (ref) => getTotalScheduleToday(
            ref as GetTotalScheduleTodayRef,
            userId,
          ),
          from: getTotalScheduleTodayProvider,
          name: r'getTotalScheduleTodayProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTotalScheduleTodayHash,
          dependencies: GetTotalScheduleTodayFamily._dependencies,
          allTransitiveDependencies:
              GetTotalScheduleTodayFamily._allTransitiveDependencies,
          userId: userId,
        );

  GetTotalScheduleTodayProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final int userId;

  @override
  Override overrideWith(
    FutureOr<int> Function(GetTotalScheduleTodayRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetTotalScheduleTodayProvider._internal(
        (ref) => create(ref as GetTotalScheduleTodayRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _GetTotalScheduleTodayProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetTotalScheduleTodayProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetTotalScheduleTodayRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `userId` of this provider.
  int get userId;
}

class _GetTotalScheduleTodayProviderElement
    extends AutoDisposeFutureProviderElement<int>
    with GetTotalScheduleTodayRef {
  _GetTotalScheduleTodayProviderElement(super.provider);

  @override
  int get userId => (origin as GetTotalScheduleTodayProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
