import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import '../model/route_models.dart';
class OSRMRoutingService {
  static final Logger _logger = Logger();
  static const String _baseUrl = 'https://router.project-osrm.org';
  final http.Client _client;
  OSRMRoutingService({http.Client? client}) : _client = client ?? http.Client();
  Future<RouteResult> getRoute({
    required LatLng start,
    required LatLng end,
    List<LatLng> waypoints = const [],
    RouteType type = RouteType.fastest,
  }) async {
    try {
      final coordinates = [start, ...waypoints, end];
      final coordString = coordinates
          .map((c) => '${c.longitude},${c.latitude}')
          .join(';');
      final url = Uri.parse(
        '$_baseUrl/route/v1/driving/$coordString?steps=true&geometries=geojson&overview=full&annotations=true',
      );
      _logger.i('Requesting OSRM route: $url');
      final response = await _client.get(url).timeout(
        const Duration(seconds: 15),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['code'] == 'Ok' && data['routes'] != null && (data['routes'] as List).isNotEmpty) {
          return _parseOSRMRoute(data['routes'][0], type);
        } else {
          throw Exception('No route found: ${data['code']}');
        }
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      _logger.e('Error getting OSRM route: $e');
      rethrow;
    }
  }
  Future<List<RouteResult>> getAlternativeRoutes({
    required LatLng start,
    required LatLng end,
    List<LatLng> waypoints = const [],
    int alternatives = 2,
  }) async {
    try {
      final coordinates = [start, ...waypoints, end];
      final coordString = coordinates
          .map((c) => '${c.longitude},${c.latitude}')
          .join(';');
      final url = Uri.parse(
        '$_baseUrl/route/v1/driving/$coordString?steps=true&geometries=geojson&overview=full&annotations=true&alternatives=$alternatives',
      );
      final response = await _client.get(url).timeout(
        const Duration(seconds: 15),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['code'] == 'Ok' && data['routes'] != null) {
          final routes = <RouteResult>[];
          final osrmRoutes = data['routes'] as List;
          for (int i = 0; i < osrmRoutes.length; i++) {
            final routeType = i == 0 ? RouteType.fastest :
                            i == 1 ? RouteType.balanced : RouteType.shortest;
            routes.add(_parseOSRMRoute(osrmRoutes[i], routeType));
          }
          return routes;
        }
      }
      throw Exception('Failed to get alternative routes');
    } catch (e) {
      _logger.e('Error getting alternative routes: $e');
      rethrow;
    }
  }
  RouteResult _parseOSRMRoute(Map<String, dynamic> route, RouteType type) {
    final geometry = route['geometry'];
    final legs = route['legs'] as List;
    final points = <LatLng>[];
    if (geometry['coordinates'] != null) {
      for (final coord in geometry['coordinates']) {
        points.add(LatLng(coord[1], coord[0]));
      }
    }
    final distance = (route['distance'] as num).toDouble();
    final duration = (route['duration'] as num).toDouble();
    final steps = <NavigationStep>[];
    int stepIndex = 0;
    for (final leg in legs) {
      if (leg['steps'] != null) {
        for (final step in leg['steps']) {
          steps.add(_parseNavigationStep(step, stepIndex++));
        }
      }
    }
    return RouteResult(
      points: points,
      distanceMeters: distance,
      durationSeconds: duration,
      type: type,
      name: _getRouteName(type),
      steps: steps,
    );
  }
  NavigationStep _parseNavigationStep(Map<String, dynamic> step, int index) {
    final maneuver = step['maneuver'];
    final location = maneuver['location'];
    final distance = (step['distance'] as num).toDouble();
    final duration = (step['duration'] as num).toDouble();
    final instruction = step['name'] ?? 'Continue';
    final maneuverType = _parseManeuverType(maneuver['type'], maneuver['modifier']);
    return NavigationStep(
      index: index,
      location: LatLng(location[1], location[0]),
      distanceMeters: distance,
      durationSeconds: duration,
      instruction: _generateInstruction(maneuverType, instruction, distance),
      maneuver: maneuverType,
      streetName: step['name'],
      bearing: (maneuver['bearing_after'] ?? 0.0).toDouble(),
    );
  }
  ManeuverType _parseManeuverType(String type, String? modifier) {
    switch (type) {
      case 'depart':
        return ManeuverType.depart;
      case 'arrive':
        return ManeuverType.arrive;
      case 'turn':
        return _parseTurnModifier(modifier);
      case 'new name':
        return ManeuverType.newName;
      case 'continue':
        return ManeuverType.continueRoute;
      case 'merge':
        return ManeuverType.merge;
      case 'on ramp':
        return ManeuverType.onRamp;
      case 'off ramp':
        return ManeuverType.offRamp;
      case 'fork':
        return ManeuverType.fork;
      case 'end of road':
        return ManeuverType.endOfRoad;
      case 'roundabout':
        return ManeuverType.roundabout;
      case 'rotary':
        return ManeuverType.rotary;
      default:
        return ManeuverType.continueRoute;
    }
  }
  ManeuverType _parseTurnModifier(String? modifier) {
    if (modifier == null) return ManeuverType.turn;
    switch (modifier) {
      case 'left':
        return ManeuverType.turnLeft;
      case 'right':
        return ManeuverType.turnRight;
      case 'slight left':
        return ManeuverType.turnSlightLeft;
      case 'slight right':
        return ManeuverType.turnSlightRight;
      case 'sharp left':
        return ManeuverType.turnSharpLeft;
      case 'sharp right':
        return ManeuverType.turnSharpRight;
      case 'uturn':
        return ManeuverType.uTurn;
      default:
        return ManeuverType.turn;
    }
  }
  String _generateInstruction(ManeuverType type, String streetName, double distance) {
    final distanceStr = distance < 1000
        ? '${distance.toStringAsFixed(0)} meters'
        : '${(distance / 1000).toStringAsFixed(1)} km';
    switch (type) {
      case ManeuverType.depart:
        return 'Head ${streetName.isNotEmpty ? "on $streetName" : "straight"}';
      case ManeuverType.arrive:
        return 'You have arrived at your destination';
      case ManeuverType.turnLeft:
        return 'Turn left${streetName.isNotEmpty ? " onto $streetName" : ""}';
      case ManeuverType.turnRight:
        return 'Turn right${streetName.isNotEmpty ? " onto $streetName" : ""}';
      case ManeuverType.turnSlightLeft:
        return 'Keep left${streetName.isNotEmpty ? " onto $streetName" : ""}';
      case ManeuverType.turnSlightRight:
        return 'Keep right${streetName.isNotEmpty ? " onto $streetName" : ""}';
      case ManeuverType.turnSharpLeft:
        return 'Make a sharp left${streetName.isNotEmpty ? " onto $streetName" : ""}';
      case ManeuverType.turnSharpRight:
        return 'Make a sharp right${streetName.isNotEmpty ? " onto $streetName" : ""}';
      case ManeuverType.uTurn:
        return 'Make a U-turn${streetName.isNotEmpty ? " onto $streetName" : ""}';
      case ManeuverType.merge:
        return 'Merge${streetName.isNotEmpty ? " onto $streetName" : ""}';
      case ManeuverType.onRamp:
        return 'Take the ramp${streetName.isNotEmpty ? " onto $streetName" : ""}';
      case ManeuverType.offRamp:
        return 'Take the exit${streetName.isNotEmpty ? " onto $streetName" : ""}';
      case ManeuverType.fork:
        return 'At the fork, keep ${streetName.isNotEmpty ? streetName : "straight"}';
      case ManeuverType.roundabout:
        return 'Enter the roundabout';
      case ManeuverType.continueRoute:
      case ManeuverType.newName:
        return 'Continue${streetName.isNotEmpty ? " on $streetName" : " straight"} for $distanceStr';
      default:
        return 'Continue${streetName.isNotEmpty ? " on $streetName" : ""}';
    }
  }
  String _getRouteName(RouteType type) {
    switch (type) {
      case RouteType.fastest:
        return 'Fastest Route';
      case RouteType.shortest:
        return 'Shortest Route';
      case RouteType.balanced:
        return 'Balanced Route';
    }
  }
  void dispose() {
    _client.close();
  }
}