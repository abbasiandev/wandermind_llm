import 'dart:math' as math;
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';

import '../model/route_models.dart';

class RouteCalculationService {
  static final Logger _logger = Logger();
  final Distance _distance = const Distance();

  Future<List<RouteResult>> calculateRoutes({
    required LatLng start,
    required LatLng end,
    List<Waypoint> waypoints = const [],
    RoutePreferences? preferences,
  }) async {
    _logger.i('Calculating routes from $start to $end');

    final prefs = preferences ?? const RoutePreferences();
    final routes = <RouteResult>[];

    try {

      if (!prefs.avoidHighways) {
        final fastest = await _calculateFastestRoute(start, end, waypoints, prefs);
        routes.add(fastest);
      }

      final shortest = await _calculateShortestRoute(start, end, waypoints, prefs);
      routes.add(shortest);

      if (prefs.avoidHighways || prefs.avoidTolls) {
        final balanced = await _calculateBalancedRoute(start, end, waypoints, prefs);
        routes.add(balanced);
      }

      _logger.i('Calculated ${routes.length} route options');
      return routes;
    } catch (e) {
      _logger.e('Error calculating routes: $e');

      return [_createStraightLineRoute(start, end, waypoints)];
    }
  }

  Future<RouteResult> _calculateFastestRoute(
    LatLng start,
    LatLng end,
    List<Waypoint> waypoints,
    RoutePreferences prefs,
  ) async {

    final points = <LatLng>[start];

    for (final waypoint in waypoints) {
      points.addAll(_generateIntermediatePoints(
        points.last,
        waypoint.location,
        speedFactor: 1.2,
      ));
    }

    points.addAll(_generateIntermediatePoints(
      points.last,
      end,
      speedFactor: 1.2,
    ));

    final distance = _calculateTotalDistance(points);
    final duration = _estimateDuration(distance, averageSpeedKmh: 50);

    return RouteResult(
      points: points,
      distanceMeters: distance,
      durationSeconds: duration,
      type: RouteType.fastest,
      name: 'Fastest Route',
    );
  }

  Future<RouteResult> _calculateShortestRoute(
    LatLng start,
    LatLng end,
    List<Waypoint> waypoints,
    RoutePreferences prefs,
  ) async {
    final points = <LatLng>[start];

    for (final waypoint in waypoints) {
      points.addAll(_generateIntermediatePoints(
        points.last,
        waypoint.location,
        speedFactor: 0.8,
      ));
    }

    points.addAll(_generateIntermediatePoints(
      points.last,
      end,
      speedFactor: 0.8,
    ));

    final distance = _calculateTotalDistance(points);
    final duration = _estimateDuration(distance, averageSpeedKmh: 35);

    return RouteResult(
      points: points,
      distanceMeters: distance,
      durationSeconds: duration,
      type: RouteType.shortest,
      name: 'Shortest Route',
    );
  }

  Future<RouteResult> _calculateBalancedRoute(
    LatLng start,
    LatLng end,
    List<Waypoint> waypoints,
    RoutePreferences prefs,
  ) async {
    final points = <LatLng>[start];

    for (final waypoint in waypoints) {
      points.addAll(_generateIntermediatePoints(
        points.last,
        waypoint.location,
        speedFactor: 1.0,
        avoidHighways: prefs.avoidHighways,
      ));
    }

    points.addAll(_generateIntermediatePoints(
      points.last,
      end,
      speedFactor: 1.0,
      avoidHighways: prefs.avoidHighways,
    ));

    final distance = _calculateTotalDistance(points);
    final duration = _estimateDuration(distance, averageSpeedKmh: 40);

    return RouteResult(
      points: points,
      distanceMeters: distance,
      durationSeconds: duration,
      type: RouteType.balanced,
      name: prefs.avoidHighways ? 'No Highways' : 'Balanced Route',
    );
  }

  List<LatLng> _generateIntermediatePoints(
    LatLng start,
    LatLng end, {
    double speedFactor = 1.0,
    bool avoidHighways = false,
  }) {
    final points = <LatLng>[];
    final distance = _distance(start, end);

    final numPoints = (distance / 500).ceil().clamp(2, 20);

    for (int i = 1; i <= numPoints; i++) {
      final t = i / numPoints;

      final curveFactor = avoidHighways ? 0.0002 : 0.0001;
      final curve = math.sin(t * math.pi) * curveFactor * speedFactor;

      final lat = start.latitude + (end.latitude - start.latitude) * t + curve;
      final lng = start.longitude + (end.longitude - start.longitude) * t + curve;

      points.add(LatLng(lat, lng));
    }

    return points;
  }

  RouteResult _createStraightLineRoute(
    LatLng start,
    LatLng end,
    List<Waypoint> waypoints,
  ) {
    final points = <LatLng>[start];

    for (final waypoint in waypoints) {
      points.add(waypoint.location);
    }

    points.add(end);

    final distance = _calculateTotalDistance(points);
    final duration = _estimateDuration(distance, averageSpeedKmh: 40);

    return RouteResult(
      points: points,
      distanceMeters: distance,
      durationSeconds: duration,
      type: RouteType.balanced,
      name: 'Direct Route',
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
}
