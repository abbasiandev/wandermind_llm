// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routeCalculationServiceHash() =>
    r'0ebb482528e9e6a43d5a42fdf630055cf23aef39';

/// See also [routeCalculationService].
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
String _$navigationServiceHash() => r'38f3344b41e92a0dec03807e92ac7387b498354b';

/// See also [navigationService].
@ProviderFor(navigationService)
final navigationServiceProvider =
    AutoDisposeProvider<NavigationService>.internal(
  navigationService,
  name: r'navigationServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$navigationServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NavigationServiceRef = AutoDisposeProviderRef<NavigationService>;
String _$navigationStateNotifierHash() =>
    r'cb3b5f311ea74b031eeed549cbad7624683edc6c';

/// See also [NavigationStateNotifier].
@ProviderFor(NavigationStateNotifier)
final navigationStateNotifierProvider = AutoDisposeNotifierProvider<
    NavigationStateNotifier, NavigationState>.internal(
  NavigationStateNotifier.new,
  name: r'navigationStateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$navigationStateNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NavigationStateNotifier = AutoDisposeNotifier<NavigationState>;
String _$routeManagerHash() => r'6d4caa0e269a605d991082c7cbb156701ecaf5ca';

/// See also [RouteManager].
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
