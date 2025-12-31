import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:latlong2/latlong.dart';

import '../model/route_models.dart';
import '../service/route_calculation_service.dart';

part 'route_provider.g.dart';

/// Provider for route calculation service
@riverpod
RouteCalculationService routeCalculationService(RouteCalculationServiceRef ref) {
  return RouteCalculationService();
}

/// State for managing route planning
@riverpod
class RouteManager extends _$RouteManager {
  @override
  RouteWithWaypoints? build() {
    return null;
  }

  /// Set start and destination
  void setRoute(LatLng start, LatLng destination) {
    state = RouteWithWaypoints(
      start: start,
      destination: destination,
      waypoints: state?.waypoints ?? [],
      preferences: state?.preferences ?? const RoutePreferences(),
    );
  }

  /// Add a waypoint
  void addWaypoint(Waypoint waypoint) {
    if (state == null) return;
    
    final waypoints = List<Waypoint>.from(state!.waypoints)..add(waypoint);
    state = state!.copyWith(waypoints: waypoints);
  }

  /// Update waypoints list
  void updateWaypoints(List<Waypoint> waypoints) {
    if (state == null) return;
    state = state!.copyWith(waypoints: waypoints);
  }

  /// Remove a waypoint
  void removeWaypoint(String id) {
    if (state == null) return;
    
    final waypoints = state!.waypoints.where((w) => w.id != id).toList();
    state = state!.copyWith(waypoints: waypoints);
  }

  /// Update route preferences
  void updatePreferences(RoutePreferences preferences) {
    if (state == null) return;
    state = state!.copyWith(preferences: preferences);
  }

  /// Calculate routes
  Future<void> calculateRoutes() async {
    if (state == null) return;

    final service = ref.read(routeCalculationServiceProvider);
    
    try {
      final routes = await service.calculateRoutes(
        start: state!.start,
        end: state!.destination,
        waypoints: state!.waypoints,
        preferences: state!.preferences,
      );

      if (routes.isNotEmpty) {
        state = state!.copyWith(
          alternativeRoutes: routes,
          activeRoute: routes.first,
        );
      }
    } catch (e) {
      // Handle error
      rethrow;
    }
  }

  /// Select a specific route
  void selectRoute(RouteResult route) {
    if (state == null) return;
    state = state!.copyWith(activeRoute: route);
  }

  /// Clear all route data
  void clear() {
    state = null;
  }
}
