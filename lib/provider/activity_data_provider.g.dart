// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activityDataHash() => r'e7d31d2b6032eedf8af68435e09e61e11337aa76';

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

/// See also [activityData].
@ProviderFor(activityData)
const activityDataProvider = ActivityDataFamily();

/// See also [activityData].
class ActivityDataFamily extends Family<AsyncValue<ActivityResponse>> {
  /// See also [activityData].
  const ActivityDataFamily();

  /// See also [activityData].
  ActivityDataProvider call(
    Range range,
    DateTime startDate,
    DateTime endDate,
  ) {
    return ActivityDataProvider(
      range,
      startDate,
      endDate,
    );
  }

  @override
  ActivityDataProvider getProviderOverride(
    covariant ActivityDataProvider provider,
  ) {
    return call(
      provider.range,
      provider.startDate,
      provider.endDate,
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
  String? get name => r'activityDataProvider';
}

/// See also [activityData].
class ActivityDataProvider extends AutoDisposeFutureProvider<ActivityResponse> {
  /// See also [activityData].
  ActivityDataProvider(
    Range range,
    DateTime startDate,
    DateTime endDate,
  ) : this._internal(
          (ref) => activityData(
            ref as ActivityDataRef,
            range,
            startDate,
            endDate,
          ),
          from: activityDataProvider,
          name: r'activityDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$activityDataHash,
          dependencies: ActivityDataFamily._dependencies,
          allTransitiveDependencies:
              ActivityDataFamily._allTransitiveDependencies,
          range: range,
          startDate: startDate,
          endDate: endDate,
        );

  ActivityDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.range,
    required this.startDate,
    required this.endDate,
  }) : super.internal();

  final Range range;
  final DateTime startDate;
  final DateTime endDate;

  @override
  Override overrideWith(
    FutureOr<ActivityResponse> Function(ActivityDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ActivityDataProvider._internal(
        (ref) => create(ref as ActivityDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        range: range,
        startDate: startDate,
        endDate: endDate,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ActivityResponse> createElement() {
    return _ActivityDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ActivityDataProvider &&
        other.range == range &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, range.hashCode);
    hash = _SystemHash.combine(hash, startDate.hashCode);
    hash = _SystemHash.combine(hash, endDate.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ActivityDataRef on AutoDisposeFutureProviderRef<ActivityResponse> {
  /// The parameter `range` of this provider.
  Range get range;

  /// The parameter `startDate` of this provider.
  DateTime get startDate;

  /// The parameter `endDate` of this provider.
  DateTime get endDate;
}

class _ActivityDataProviderElement
    extends AutoDisposeFutureProviderElement<ActivityResponse>
    with ActivityDataRef {
  _ActivityDataProviderElement(super.provider);

  @override
  Range get range => (origin as ActivityDataProvider).range;
  @override
  DateTime get startDate => (origin as ActivityDataProvider).startDate;
  @override
  DateTime get endDate => (origin as ActivityDataProvider).endDate;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
