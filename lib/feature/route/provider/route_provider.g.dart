// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routeCalculationServiceHash() =>
    r'96c765848096198a9494388e8bbf50c98b828f1c';

/// Provider for route calculation service
///
/// Copied from [routeCalculationService].
@ProviderFor(routeCalculationService)
final routeCalculationServiceProvider =
    AutoDisposeProvider<RouteCalculationService>.internal(
  routeCalculationService,
  name: r'routeCalculationServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$routeCalculationServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RouteCalculationServiceRef
    = AutoDisposeProviderRef<RouteCalculationService>;
String _$routeManagerHash() => r'6d4caa0e269a605d991082c7cbb156701ecaf5ca';

/// State for managing route planning
///
/// Copied from [RouteManager].
@ProviderFor(RouteManager)
final routeManagerProvider =
    AutoDisposeNotifierProvider<RouteManager, RouteWithWaypoints?>.internal(
  RouteManager.new,
  name: r'routeManagerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$routeManagerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RouteManager = AutoDisposeNotifier<RouteWithWaypoints?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
