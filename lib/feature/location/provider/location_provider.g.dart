// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$locationControllerHash() =>
    r'a3466347380cbc15ec52ef50d4a48d8ff60c43bc';

/// See also [LocationController].
@ProviderFor(LocationController)
final locationControllerProvider = AutoDisposeAsyncNotifierProvider<
    LocationController, LocationData?>.internal(
  LocationController.new,
  name: r'locationControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$locationControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LocationController = AutoDisposeAsyncNotifier<LocationData?>;
String _$locationPermissionControllerHash() =>
    r'a848f9a583373b9cdcc34c04996388be08b87b8d';

/// See also [LocationPermissionController].
@ProviderFor(LocationPermissionController)
final locationPermissionControllerProvider = AutoDisposeAsyncNotifierProvider<
    LocationPermissionController, LocationPermission>.internal(
  LocationPermissionController.new,
  name: r'locationPermissionControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$locationPermissionControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LocationPermissionController
    = AutoDisposeAsyncNotifier<LocationPermission>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
