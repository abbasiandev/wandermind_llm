import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';

import '../../../core/config/map_config.dart';
import '../model/route_models.dart';
import '../model/scenic_route_preferences.dart';
import 'offline_routing_engine.dart';
import 'offline_map_data_service.dart';
import 'scenic_routing_engine.dart';

class SmartRoutingService {
  static final Logger _logger = Logger();

  final http.Client _client;
  final OfflineRoutingEngine _offlineEngine;
  final OfflineMapDataService _offlineDataService;
  final ScenicRoutingEngine _scenicEngine;

  SmartRoutingService({
    http.Client? client,
    OfflineRoutingEngine? offlineEngine,
    OfflineMapDataService? offlineDataService,
    ScenicRoutingEngine? scenicEngine,
  })  : _client = client ?? http.Client(),
        _offlineEngine = offlineEngine ?? OfflineRoutingEngine(),
        _offlineDataService = offlineDataService ?? OfflineMapDataService(),
        _scenicEngine = scenicEngine ?? ScenicRoutingEngine();

  Future<void> initialize() async {
    await _loadOfflineNetwork();
  }

  Future<RouteResult?> getScenicRoute({
    required LatLng start,
    required LatLng end,
    required ScenicRoutePreferences preferences,
  }) async {
    _logger.i('Calculating scenic route: ${preferences.mode.displayName}');

    if (preferences.mode == ScenicMode.direct) {
      return await getRoute(start: start, end: end);
    }

    if (_scenicEngine.hasNetwork) {
      try {
        final route = await _scenicEngine.calculateScenicRoute(
          start: start,
          end: end,
          preferences: preferences,
        );
        if (route != null) {
          return route;
        }
      } catch (e) {
        _logger.w('Scenic routing failed, falling back: $e');
      }
    }

    return await getRoute(start: start, end: end);
  }

  Future<RouteResult> getRoute({
    required LatLng start,
    required LatLng end,
    List<LatLng> waypoints = const [],
    RouteType type = RouteType.fastest,
  }) async {
    if (MapConfig.isMapboxAvailable) {
      try {
        _logger.i('Using Mapbox Directions API');
        return await _getMapboxRoute(start, end, waypoints, type);
      } catch (e) {
        _logger.w('Mapbox routing failed, trying OSRM: $e');
      }
    }

    try {
      _logger.i('Using OSRM (free routing)');
      return await _getOSRMRoute(start, end, waypoints, type);
    } catch (e) {
      _logger.w('OSRM routing failed, trying offline routing: $e');
    }

    if (_offlineEngine.hasNetwork) {
      try {
        _logger.i('Using offline routing engine');
        final route = await _offlineEngine.calculateRoute(start: start, end: end);
        if (route != null) {
          return route;
        }
      } catch (e) {
        _logger.e('Offline routing failed: $e');
      }
    }

    throw Exception('All routing services failed');
  }

  Future<List<RouteResult>> getAlternativeRoutes({
    required LatLng start,
    required LatLng end,
    List<LatLng> waypoints = const [],
    int alternatives = 2,
  }) async {
    if (MapConfig.isMapboxAvailable) {
      try {
        return await _getMapboxAlternatives(start, end, waypoints, alternatives);
      } catch (e) {
        _logger.w('Mapbox alternatives failed, falling back to OSRM: $e');
      }
    }

    try {
      return await _getOSRMAlternatives(start, end, waypoints, alternatives);
    } catch (e) {
      _logger.e('OSRM alternatives failed: $e');
      throw Exception('Failed to get alternative routes');
    }
  }

  Future<RouteResult> _getMapboxRoute(
    LatLng start,
    LatLng end,
    List<LatLng> waypoints,
    RouteType type,
  ) async {
    final coordinates = [start, ...waypoints, end];
    final coordString = coordinates
        .map((c) => '${c.longitude},${c.latitude}')
        .join(';');

    final profile = _getMapboxProfile(type);
    final token = MapConfig.mapboxToken;

    final url = Uri.parse(
      'https://api.mapbox.com/directions/v5/mapbox/$profile/$coordString'
      '?steps=true&geometries=geojson&overview=full&access_token=$token',
    );

    _logger.i('Requesting Mapbox route: $profile');

    final response = await _client.get(url).timeout(
      const Duration(seconds: 15),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['code'] == 'Ok' && data['routes'] != null && (data['routes'] as List).isNotEmpty) {
        return _parseMapboxRoute(data['routes'][0], type);
      } else {
        throw Exception('No route found: ${data['code']}');
      }
    } else {
      throw Exception('HTTP ${response.statusCode}: ${response.body}');
    }
  }

  Future<List<RouteResult>> _getMapboxAlternatives(
    LatLng start,
    LatLng end,
    List<LatLng> waypoints,
    int alternatives,
  ) async {
    final coordinates = [start, ...waypoints, end];
    final coordString = coordinates
        .map((c) => '${c.longitude},${c.latitude}')
        .join(';');

    final token = MapConfig.mapboxToken;

    final url = Uri.parse(
      'https://api.mapbox.com/directions/v5/mapbox/driving/$coordString'
      '?steps=true&geometries=geojson&overview=full&alternatives=$alternatives&access_token=$token',
    );

    final response = await _client.get(url).timeout(
      const Duration(seconds: 15),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['code'] == 'Ok' && data['routes'] != null) {
        final routes = <RouteResult>[];
        final mapboxRoutes = data['routes'] as List;

        for (int i = 0; i < mapboxRoutes.length; i++) {
          final routeType = i == 0 ? RouteType.fastest :
                          i == 1 ? RouteType.balanced : RouteType.shortest;
          routes.add(_parseMapboxRoute(mapboxRoutes[i], routeType));
        }

        return routes;
      }
    }

    throw Exception('Failed to get Mapbox alternatives');
  }

  RouteResult _parseMapboxRoute(Map<String, dynamic> route, RouteType type) {
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
          steps.add(_parseMapboxStep(step, stepIndex++));
        }
      }
    }

    _logger.i('Mapbox route parsed: ${points.length} points, ${steps.length} steps, ${(distance/1000).toStringAsFixed(2)} km');

    return RouteResult(
      points: points,
      distanceMeters: distance,
      durationSeconds: duration,
      type: type,
      name: '${_getRouteName(type)} (Mapbox)',
      steps: steps,
    );
  }

  NavigationStep _parseMapboxStep(Map<String, dynamic> step, int index) {
    final maneuver = step['maneuver'];
    final location = maneuver['location'];

    final distance = (step['distance'] as num).toDouble();
    final duration = (step['duration'] as num).toDouble();
    final instruction = maneuver['instruction'] ?? step['name'] ?? 'Continue';
    final maneuverType = _parseMapboxManeuver(maneuver['type'], maneuver['modifier']);

    return NavigationStep(
      index: index,
      location: LatLng(location[1], location[0]),
      distanceMeters: distance,
      durationSeconds: duration,
      instruction: instruction,
      maneuver: maneuverType,
      streetName: step['name'],
      bearing: (maneuver['bearing_after'] ?? 0.0).toDouble(),
    );
  }

  Future<RouteResult> _getOSRMRoute(
    LatLng start,
    LatLng end,
    List<LatLng> waypoints,
    RouteType type,
  ) async {
    final coordinates = [start, ...waypoints, end];
    final coordString = coordinates
        .map((c) => '${c.longitude},${c.latitude}')
        .join(';');

    final url = Uri.parse(
      'https://router.project-osrm.org/route/v1/driving/$coordString'
      '?steps=true&geometries=geojson&overview=full&annotations=true',
    );

    final response = await _client.get(url).timeout(
      const Duration(seconds: 15),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['code'] == 'Ok' && data['routes'] != null && (data['routes'] as List).isNotEmpty) {
        return _parseOSRMRoute(data['routes'][0], type);
      }
    }

    throw Exception('OSRM routing failed');
  }

  Future<List<RouteResult>> _getOSRMAlternatives(
    LatLng start,
    LatLng end,
    List<LatLng> waypoints,
    int alternatives,
  ) async {
    final coordinates = [start, ...waypoints, end];
    final coordString = coordinates
        .map((c) => '${c.longitude},${c.latitude}')
        .join(';');

    final url = Uri.parse(
      'https://router.project-osrm.org/route/v1/driving/$coordString'
      '?steps=true&geometries=geojson&overview=full&alternatives=$alternatives',
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

    throw Exception('OSRM alternatives failed');
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
          steps.add(_parseOSRMStep(step, stepIndex++));
        }
      }
    }

    _logger.i('OSRM route parsed: ${points.length} points, ${steps.length} steps, ${(distance/1000).toStringAsFixed(2)} km');

    return RouteResult(
      points: points,
      distanceMeters: distance,
      durationSeconds: duration,
      type: type,
      name: '${_getRouteName(type)} (OSRM)',
      steps: steps,
    );
  }

  NavigationStep _parseOSRMStep(Map<String, dynamic> step, int index) {
    final maneuver = step['maneuver'];
    final location = maneuver['location'];

    final distance = (step['distance'] as num).toDouble();
    final duration = (step['duration'] as num).toDouble();
    final instruction = step['name'] ?? 'Continue';
    final maneuverType = _parseOSRMManeuver(maneuver['type'], maneuver['modifier']);

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

  String _getMapboxProfile(RouteType type) {
    switch (type) {
      case RouteType.fastest:
        return 'driving-traffic';
      case RouteType.shortest:
        return 'driving';
      case RouteType.balanced:
        return 'driving';
    }
  }

  ManeuverType _parseMapboxManeuver(String type, String? modifier) {
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

  ManeuverType _parseOSRMManeuver(String type, String? modifier) {
    return _parseMapboxManeuver(type, modifier);
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

  Future<void> _loadOfflineNetwork() async {
    try {
      final regions = await _offlineDataService.listAvailableRegions();

      if (regions.isEmpty) {
        _logger.i('No offline networks available, creating sample network...');
        final sampleNetwork = await _offlineDataService.createSampleNetwork();
        _offlineEngine.loadNetwork(sampleNetwork);
        return;
      }

      final firstRegion = regions.first;
      final network = await _offlineDataService.loadNetworkFromFile(firstRegion);

      if (network != null) {
        _offlineEngine.loadNetwork(network);
        _scenicEngine.loadNetwork(network);
        _logger.i('Loaded offline network: ${network.regionName}');
      }
    } catch (e) {
      _logger.e('Error loading offline network: $e');
    }
  }

  Future<void> downloadRegion({
    required String regionName,
    required double minLat,
    required double maxLat,
    required double minLon,
    required double maxLon,
  }) async {
    final network = await _offlineDataService.downloadRegionData(
      regionName: regionName,
      minLat: minLat,
      maxLat: maxLat,
      minLon: minLon,
      maxLon: maxLon,
    );

    _offlineEngine.loadNetwork(network);
    _scenicEngine.loadNetwork(network);
  }

  Future<List<String>> getAvailableOfflineRegions() {
    return _offlineDataService.listAvailableRegions();
  }

  Future<void> deleteOfflineRegion(String regionId) {
    return _offlineDataService.deleteRegion(regionId);
  }

  bool get hasOfflineNetwork => _offlineEngine.hasNetwork;

  void dispose() {
    _client.close();
    _offlineDataService.dispose();
  }
}
