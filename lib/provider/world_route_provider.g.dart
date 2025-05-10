// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_route_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$worldRouteHash() => r'740d007cddd2a4d8c3e5c1fb8d92cd3e9155dbc6';

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

/// See also [worldRoute].
@ProviderFor(worldRoute)
const worldRouteProvider = WorldRouteFamily();

/// See also [worldRoute].
class WorldRouteFamily extends Family<AsyncValue<List<RouteModel>>> {
  /// See also [worldRoute].
  const WorldRouteFamily();

  /// See also [worldRoute].
  WorldRouteProvider call(
    LatLngBounds bounds,
  ) {
    return WorldRouteProvider(
      bounds,
    );
  }

  @override
  WorldRouteProvider getProviderOverride(
    covariant WorldRouteProvider provider,
  ) {
    return call(
      provider.bounds,
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
  String? get name => r'worldRouteProvider';
}

/// See also [worldRoute].
class WorldRouteProvider extends AutoDisposeFutureProvider<List<RouteModel>> {
  /// See also [worldRoute].
  WorldRouteProvider(
    LatLngBounds bounds,
  ) : this._internal(
          (ref) => worldRoute(
            ref as WorldRouteRef,
            bounds,
          ),
          from: worldRouteProvider,
          name: r'worldRouteProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$worldRouteHash,
          dependencies: WorldRouteFamily._dependencies,
          allTransitiveDependencies:
              WorldRouteFamily._allTransitiveDependencies,
          bounds: bounds,
        );

  WorldRouteProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.bounds,
  }) : super.internal();

  final LatLngBounds bounds;

  @override
  Override overrideWith(
    FutureOr<List<RouteModel>> Function(WorldRouteRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WorldRouteProvider._internal(
        (ref) => create(ref as WorldRouteRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        bounds: bounds,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<RouteModel>> createElement() {
    return _WorldRouteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WorldRouteProvider && other.bounds == bounds;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bounds.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WorldRouteRef on AutoDisposeFutureProviderRef<List<RouteModel>> {
  /// The parameter `bounds` of this provider.
  LatLngBounds get bounds;
}

class _WorldRouteProviderElement
    extends AutoDisposeFutureProviderElement<List<RouteModel>>
    with WorldRouteRef {
  _WorldRouteProviderElement(super.provider);

  @override
  LatLngBounds get bounds => (origin as WorldRouteProvider).bounds;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
