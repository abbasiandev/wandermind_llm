import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'route_models.freezed.dart';
part 'route_models.g.dart';

@freezed
class RouteResult with _$RouteResult {
  const factory RouteResult({
    required List<LatLng> points,
    required double distanceMeters,
    required double durationSeconds,
    required RouteType type,
    String? name,
    @Default([]) List<NavigationStep> steps,
  }) = _RouteResult;

  factory RouteResult.fromJson(Map<String, dynamic> json) =>
      _$RouteResultFromJson(json);
}

enum RouteType {
  fastest,
  shortest,
  balanced,
}

@freezed
class NavigationStep with _$NavigationStep {
  const factory NavigationStep({
    required int index,
    required LatLng location,
    required double distanceMeters,
    required double durationSeconds,
    required String instruction,
    required ManeuverType maneuver,
    String? streetName,
    String? destination,
    int? exitNumber,
    @Default(0.0) double bearing,
  }) = _NavigationStep;

  factory NavigationStep.fromJson(Map<String, dynamic> json) =>
      _$NavigationStepFromJson(json);
}

enum ManeuverType {
  depart,
  turn,
  newName,
  continueRoute,
  merge,
  onRamp,
  offRamp,
  fork,
  endOfRoad,
  useLane,
  continueUturn,
  continueLeft,
  continueRight,
  keepLeft,
  keepRight,
  turnLeft,
  turnRight,
  turnSlightLeft,
  turnSlightRight,
  turnSharpLeft,
  turnSharpRight,
  uTurn,
  arrive,
  roundabout,
  rotary,
}

@freezed
class NavigationState with _$NavigationState {
  const factory NavigationState({
    required bool isNavigating,
    NavigationStep? currentStep,
    NavigationStep? nextStep,
    @Default(0) int currentStepIndex,
    @Default(0.0) double distanceToNextStep,
    @Default(0.0) double totalDistanceRemaining,
    @Default(0.0) double totalDurationRemaining,
    @Default(false) bool isOffRoute,
    @Default(false) bool isRerouting,
    DateTime? lastUpdateTime,
  }) = _NavigationState;

  factory NavigationState.fromJson(Map<String, dynamic> json) =>
      _$NavigationStateFromJson(json);
}

@freezed
class RoutePreferences with _$RoutePreferences {
  const factory RoutePreferences({
    @Default(RouteType.fastest) RouteType preferredType,
    @Default(false) bool avoidHighways,
    @Default(false) bool avoidTolls,
    @Default(false) bool avoidFerries,
    @Default(false) bool avoidUnpaved,
  }) = _RoutePreferences;

  factory RoutePreferences.fromJson(Map<String, dynamic> json) =>
      _$RoutePreferencesFromJson(json);
}

@freezed
class Waypoint with _$Waypoint {
  const factory Waypoint({
    required String id,
    required LatLng location,
    String? name,
    String? address,
    @Default(false) bool isCompleted,
    int? order,
  }) = _Waypoint;

  factory Waypoint.fromJson(Map<String, dynamic> json) =>
      _$WaypointFromJson(json);
}

@freezed
class RouteWithWaypoints with _$RouteWithWaypoints {
  const factory RouteWithWaypoints({
    required LatLng start,
    required LatLng destination,
    @Default([]) List<Waypoint> waypoints,
    RouteResult? activeRoute,
    @Default([]) List<RouteResult> alternativeRoutes,
    @Default(RoutePreferences()) RoutePreferences preferences,
  }) = _RouteWithWaypoints;

  factory RouteWithWaypoints.fromJson(Map<String, dynamic> json) =>
      _$RouteWithWaypointsFromJson(json);
}
