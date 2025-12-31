import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'route_models.freezed.dart';
part 'route_models.g.dart';

/// Route calculation result
@freezed
class RouteResult with _$RouteResult {
  const factory RouteResult({
    required List<LatLng> points,
    required double distanceMeters,
    required double durationSeconds,
    required RouteType type,
    String? name,
  }) = _RouteResult;

  factory RouteResult.fromJson(Map<String, dynamic> json) =>
      _$RouteResultFromJson(json);
}

/// Type of route
enum RouteType {
  fastest,
  shortest,
  balanced,
}

/// Route preferences
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

/// Waypoint in a route
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

/// Complete route with waypoints
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
