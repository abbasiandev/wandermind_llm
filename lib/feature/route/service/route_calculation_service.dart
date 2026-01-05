import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import '../model/route_models.dart';
import 'smart_routing_service.dart';
class RouteCalculationService {
  static final Logger _logger = Logger();
  final Distance _distance = const Distance();
  final SmartRoutingService _routingService;
  bool _initialized = false;
  RouteCalculationService({SmartRoutingService? routingService})
      : _routingService = routingService ?? SmartRoutingService();
  Future<void> initialize() async {
    if (_initialized) return;
    await _routingService.initialize();
    _initialized = true;
  }
  Future<List<RouteResult>> calculateRoutes({
    required LatLng start,
    required LatLng end,
    List<Waypoint> waypoints = const [],
    RoutePreferences? preferences,
  }) async {
    await initialize();
    _logger.i('Calculating routes from $start to $end');
    final prefs = preferences ?? const RoutePreferences();
    try {
      final waypointLocations = waypoints.map((w) => w.location).toList();
      final routes = await _routingService.getAlternativeRoutes(
        start: start,
        end: end,
        waypoints: waypointLocations,
        alternatives: 2,
      );
      if (routes.isNotEmpty) {
        _logger.i('Calculated ${routes.length} route options');
        return routes;
      }
      throw Exception('No routes returned');
    } catch (e) {
      _logger.e('Error calculating routes: $e');
      _logger.w('Falling back to simple route calculation');
      return [await _calculateFallbackRoute(start, end, waypoints, prefs)];
    }
  }
  Future<RouteResult> _calculateFallbackRoute(
    LatLng start,
    LatLng end,
    List<Waypoint> waypoints,
    RoutePreferences prefs,
  ) async {
    _logger.i('Using fallback route calculation');
    try {
      final route = await _routingService.getRoute(
        start: start,
        end: end,
        waypoints: waypoints.map((w) => w.location).toList(),
        type: prefs.preferredType,
      );
      return route;
    } catch (e) {
      _logger.e('Fallback route also failed: $e');
      return _createStraightLineRoute(start, end, waypoints);
    }
  }
  RouteResult _createStraightLineRoute(
    LatLng start,
    LatLng end,
    List<Waypoint> waypoints,
  ) {
    _logger.w('Creating straight-line fallback route');
    final points = <LatLng>[start];
    for (final waypoint in waypoints) {
      points.add(waypoint.location);
    }
    points.add(end);
    final distance = _calculateTotalDistance(points);
    final duration = _estimateDuration(distance, averageSpeedKmh: 40);
    final steps = [
      NavigationStep(
        index: 0,
        location: start,
        distanceMeters: distance,
        durationSeconds: duration,
        instruction: 'Head towards destination',
        maneuver: ManeuverType.depart,
      ),
      NavigationStep(
        index: 1,
        location: end,
        distanceMeters: 0,
        durationSeconds: 0,
        instruction: 'You have arrived at your destination',
        maneuver: ManeuverType.arrive,
      ),
    ];
    return RouteResult(
      points: points,
      distanceMeters: distance,
      durationSeconds: duration,
      type: RouteType.fastest,
      name: 'Direct Route (Offline)',
      steps: steps,
    );
  }
  double _calculateTotalDistance(List<LatLng> points) {
    double total = 0;
    for (int i = 0; i < points.length - 1; i++) {
      total += _distance(points[i], points[i + 1]);
    }
    return total;
  }
  double _estimateDuration(double distanceMeters, {required double averageSpeedKmh}) {
    final distanceKm = distanceMeters / 1000;
    final hours = distanceKm / averageSpeedKmh;
    return hours * 3600;
  }
  void dispose() {
    _routingService.dispose();
  }
}