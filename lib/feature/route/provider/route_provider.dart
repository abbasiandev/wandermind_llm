import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:latlong2/latlong.dart';
import '../model/route_models.dart';
import '../service/route_calculation_service.dart';
import '../service/navigation_service.dart';
part 'route_provider.g.dart';
@riverpod
RouteCalculationService routeCalculationService(RouteCalculationServiceRef ref) {
  final service = RouteCalculationService();
  ref.onDispose(() => service.dispose());
  return service;
}
@riverpod
NavigationService navigationService(NavigationServiceRef ref) {
  final service = NavigationService();
  ref.onDispose(() => service.dispose());
  return service;
}
@riverpod
class NavigationStateNotifier extends _$NavigationStateNotifier {
  @override
  NavigationState build() {
    ref.listen(navigationServiceProvider, (previous, next) {
      next.navigationStateStream.listen((state) {
        this.state = state;
      });
    });
    return const NavigationState(isNavigating: false);
  }
  void startNavigation(RouteResult route) {
    final service = ref.read(navigationServiceProvider);
    service.startNavigation(route);
  }
  void stopNavigation() {
    final service = ref.read(navigationServiceProvider);
    service.stopNavigation();
  }
  Future<void> updateLocation(LatLng location) async {
    final service = ref.read(navigationServiceProvider);
    await service.updateLocation(location);
  }
  String getVoiceInstruction() {
    final service = ref.read(navigationServiceProvider);
    return service.getVoiceInstruction();
  }
  bool shouldAnnounce(double previousDistance, double currentDistance) {
    final service = ref.read(navigationServiceProvider);
    return service.shouldAnnounceInstruction(previousDistance, currentDistance);
  }
}
@riverpod
class RouteManager extends _$RouteManager {
  @override
  RouteWithWaypoints? build() {
    return null;
  }
  void setRoute(LatLng start, LatLng destination) {
    state = RouteWithWaypoints(
      start: start,
      destination: destination,
      waypoints: state?.waypoints ?? [],
      preferences: state?.preferences ?? const RoutePreferences(),
    );
  }
  void addWaypoint(Waypoint waypoint) {
    if (state == null) return;
    final waypoints = List<Waypoint>.from(state!.waypoints)..add(waypoint);
    state = state!.copyWith(waypoints: waypoints);
  }
  void updateWaypoints(List<Waypoint> waypoints) {
    if (state == null) return;
    state = state!.copyWith(waypoints: waypoints);
  }
  void removeWaypoint(String id) {
    if (state == null) return;
    final waypoints = state!.waypoints.where((w) => w.id != id).toList();
    state = state!.copyWith(waypoints: waypoints);
  }
  void updatePreferences(RoutePreferences preferences) {
    if (state == null) return;
    state = state!.copyWith(preferences: preferences);
  }
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
      rethrow;
    }
  }
  void selectRoute(RouteResult route) {
    if (state == null) return;
    state = state!.copyWith(activeRoute: route);
  }
  void clear() {
    state = null;
  }
}