// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routeRecommendationHash() =>
    r'0cf1ccfd65fd9176cbc82585f578c6b66c598184';

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

/// See also [routeRecommendation].
@ProviderFor(routeRecommendation)
const routeRecommendationProvider = RouteRecommendationFamily();

/// See also [routeRecommendation].
class RouteRecommendationFamily extends Family<AsyncValue<Recommendation?>> {
  /// See also [routeRecommendation].
  const RouteRecommendationFamily();

  /// See also [routeRecommendation].
  RouteRecommendationProvider call(
    LatLngBounds bounds,
  ) {
    return RouteRecommendationProvider(
      bounds,
    );
  }

  @override
  RouteRecommendationProvider getProviderOverride(
    covariant RouteRecommendationProvider provider,
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
  String? get name => r'routeRecommendationProvider';
}

/// See also [routeRecommendation].
class RouteRecommendationProvider
    extends AutoDisposeFutureProvider<Recommendation?> {
  /// See also [routeRecommendation].
  RouteRecommendationProvider(
    LatLngBounds bounds,
  ) : this._internal(
          (ref) => routeRecommendation(
            ref as RouteRecommendationRef,
            bounds,
          ),
          from: routeRecommendationProvider,
          name: r'routeRecommendationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$routeRecommendationHash,
          dependencies: RouteRecommendationFamily._dependencies,
          allTransitiveDependencies:
              RouteRecommendationFamily._allTransitiveDependencies,
          bounds: bounds,
        );

  RouteRecommendationProvider._internal(
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
    FutureOr<Recommendation?> Function(RouteRecommendationRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RouteRecommendationProvider._internal(
        (ref) => create(ref as RouteRecommendationRef),
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
  AutoDisposeFutureProviderElement<Recommendation?> createElement() {
    return _RouteRecommendationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RouteRecommendationProvider && other.bounds == bounds;
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
mixin RouteRecommendationRef on AutoDisposeFutureProviderRef<Recommendation?> {
  /// The parameter `bounds` of this provider.
  LatLngBounds get bounds;
}

class _RouteRecommendationProviderElement
    extends AutoDisposeFutureProviderElement<Recommendation?>
    with RouteRecommendationRef {
  _RouteRecommendationProviderElement(super.provider);

  @override
  LatLngBounds get bounds => (origin as RouteRecommendationProvider).bounds;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
