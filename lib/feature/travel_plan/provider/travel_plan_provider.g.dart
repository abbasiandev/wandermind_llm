// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travel_plan_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$travelPlansControllerHash() =>
    r'88699d09c81094e45e445ddd46be36b7f2150b52';

/// See also [TravelPlansController].
@ProviderFor(TravelPlansController)
final travelPlansControllerProvider = AutoDisposeAsyncNotifierProvider<
    TravelPlansController, List<TravelPlan>>.internal(
  TravelPlansController.new,
  name: r'travelPlansControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$travelPlansControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TravelPlansController = AutoDisposeAsyncNotifier<List<TravelPlan>>;
String _$currentTravelPlanControllerHash() =>
    r'62058cc9f6629d45dd65c74fef56d082b4bc04ab';

/// See also [CurrentTravelPlanController].
@ProviderFor(CurrentTravelPlanController)
final currentTravelPlanControllerProvider = AutoDisposeNotifierProvider<
    CurrentTravelPlanController, TravelPlan?>.internal(
  CurrentTravelPlanController.new,
  name: r'currentTravelPlanControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentTravelPlanControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentTravelPlanController = AutoDisposeNotifier<TravelPlan?>;
String _$travelPlanCreationControllerHash() =>
    r'e637bb7e3d54c8937f748af24e00caa09b581c02';

/// See also [TravelPlanCreationController].
@ProviderFor(TravelPlanCreationController)
final travelPlanCreationControllerProvider = AutoDisposeNotifierProvider<
    TravelPlanCreationController, TravelPlanCreationState>.internal(
  TravelPlanCreationController.new,
  name: r'travelPlanCreationControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$travelPlanCreationControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TravelPlanCreationController
    = AutoDisposeNotifier<TravelPlanCreationState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
