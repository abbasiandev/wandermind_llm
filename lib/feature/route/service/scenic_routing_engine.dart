import 'dart:math' as math;
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import '../model/offline_road_network.dart';
import '../model/route_models.dart';
import '../model/scenic_route_preferences.dart';
class ScenicRoutingEngine {
  static final Logger _logger = Logger();
  final Distance _distance = const Distance();
  RoadNetwork? _loadedNetwork;
  void loadNetwork(RoadNetwork network) {
    _loadedNetwork = network;
  }
  bool get hasNetwork => _loadedNetwork != null;
  Future<RouteResult?> calculateScenicRoute({
    required LatLng start,
    required LatLng end,
    required ScenicRoutePreferences preferences,
  }) async {
    if (_loadedNetwork == null) {
      _logger.w('No road network loaded');
      return null;
    }
    _logger.i('Calculating scenic route: ${preferences.mode.displayName}');
    final startNode = _findNearestNode(start);
    final endNode = _findNearestNode(end);
    if (startNode == null || endNode == null) {
      return null;
    }
    final directDistance = _distance(start, end);
    final maxDistance = directDistance * preferences.maxDetourMultiplier;
    List<String>? path;
    switch (preferences.mode) {
      case ScenicMode.direct:
        path = await _findDirectPath(startNode, endNode);
        break;
      case ScenicMode.balanced:
        path = await _findBalancedPath(startNode, endNode, maxDistance);
        break;
      case ScenicMode.scenic:
        path = await _findScenicPath(startNode, endNode, maxDistance);
        break;
      case ScenicMode.exploration:
        path = await _findExplorationPath(startNode, endNode, maxDistance);
        break;
      case ScenicMode.spiral:
        path = await _findSpiralPath(startNode, endNode, maxDistance);
        break;
    }
    if (path == null || path.isEmpty) {
      _logger.w('No scenic path found');
      return null;
    }
    return _convertToRouteResult(path, start, end, preferences);
  }
  Future<List<String>?> _findDirectPath(RoadNode start, RoadNode end) async {
    return _findPathAStar(start, end, _directHeuristic);
  }
  Future<List<String>?> _findBalancedPath(
    RoadNode start,
    RoadNode end,
    double maxDistance,
  ) async {
    return _findPathAStar(start, end, (from, to) {
      final directDist = _directHeuristic(from, to);
      final roadScore = _getRoadQualityScore(from, to);
      return directDist * 0.7 + roadScore * 0.3;
    });
  }
  Future<List<String>?> _findScenicPath(
    RoadNode start,
    RoadNode end,
    double maxDistance,
  ) async {
    final allPaths = await _findMultiplePaths(start, end, 5);
    if (allPaths.isEmpty) return null;
    var bestPath = allPaths.first;
    double bestScore = _scoreScenicRoute(allPaths.first);
    for (final path in allPaths) {
      final pathDistance = _calculatePathDistance(path);
      if (pathDistance > maxDistance) continue;
      final score = _scoreScenicRoute(path);
      if (score > bestScore) {
        bestScore = score;
        bestPath = path;
      }
    }
    return bestPath;
  }
  Future<List<String>?> _findExplorationPath(
    RoadNode start,
    RoadNode end,
    double maxDistance,
  ) async {
    return _findPathAStar(start, end, (from, to) {
      final directDist = _directHeuristic(from, to);
      final diversityScore = _getDiversityScore(from, to);
      return directDist * 0.4 + diversityScore * 0.6;
    });
  }
  Future<List<String>?> _findSpiralPath(
    RoadNode start,
    RoadNode end,
    double maxDistance,
  ) async {
    _logger.i('Generating spiral path...');
    final centerLat = (start.latitude + end.latitude) / 2;
    final centerLon = (start.longitude + end.longitude) / 2;
    final center = LatLng(centerLat, centerLon);
    final radius = _distance(
      LatLng(start.latitude, start.longitude),
      LatLng(end.latitude, end.longitude),
    ) / 2;
    final spiralPoints = _generateSpiralWaypoints(
      center: center,
      startRadius: radius * 0.3,
      endRadius: radius * 1.2,
      rotations: 2.5,
      numPoints: 8,
    );
    final pathSegments = <String>[];
    var currentNode = start;
    pathSegments.add(currentNode.id);
    for (final waypoint in spiralPoints) {
      final targetNode = _findNearestNode(waypoint);
      if (targetNode == null) continue;
      final segment = await _findPathAStar(currentNode, targetNode, _directHeuristic);
      if (segment != null && segment.length > 1) {
        pathSegments.addAll(segment.sublist(1));
        currentNode = targetNode;
      }
    }
    final finalSegment = await _findPathAStar(currentNode, end, _directHeuristic);
    if (finalSegment != null && finalSegment.length > 1) {
      pathSegments.addAll(finalSegment.sublist(1));
    }
    return pathSegments;
  }
  List<LatLng> _generateSpiralWaypoints({
    required LatLng center,
    required double startRadius,
    required double endRadius,
    required double rotations,
    required int numPoints,
  }) {
    final points = <LatLng>[];
    final totalRotations = rotations * 2 * math.pi;
    for (int i = 0; i < numPoints; i++) {
      final t = i / (numPoints - 1);
      final angle = totalRotations * t;
      final radius = startRadius + (endRadius - startRadius) * t;
      final lat = center.latitude + (radius / 111320) * math.cos(angle);
      final lon = center.longitude + (radius / (111320 * math.cos(center.latitude * math.pi / 180))) * math.sin(angle);
      points.add(LatLng(lat, lon));
    }
    return points;
  }
  Future<List<List<String>>> _findMultiplePaths(
    RoadNode start,
    RoadNode end,
    int numPaths,
  ) async {
    final paths = <List<String>>[];
    final usedEdges = <String>{};
    for (int i = 0; i < numPaths; i++) {
      final path = await _findPathAStar(
        start,
        end,
        _directHeuristic,
        excludedEdges: usedEdges,
      );
      if (path != null && path.length > 1) {
        paths.add(path);
        for (int j = 0; j < path.length - 1; j++) {
          final edgeId = '${path[j]}_${path[j + 1]}';
          usedEdges.add(edgeId);
        }
      } else {
        break;
      }
    }
    return paths;
  }
  Future<List<String>?> _findPathAStar(
    RoadNode start,
    RoadNode end,
    double Function(RoadNode, RoadNode) heuristic, {
    Set<String>? excludedEdges,
  }) async {
    final openSet = <_PathNode>[];
    final closedSet = <String>{};
    final cameFrom = <String, String>{};
    final gScore = <String, double>{start.id: 0.0};
    final fScore = <String, double>{start.id: heuristic(start, end)};
    openSet.add(_PathNode(start.id, fScore[start.id]!));
    while (openSet.isNotEmpty) {
      openSet.sort((a, b) => a.fScore.compareTo(b.fScore));
      final current = openSet.removeAt(0);
      if (current.nodeId == end.id) {
        return _reconstructPath(cameFrom, current.nodeId);
      }
      closedSet.add(current.nodeId);
      final currentNode = _loadedNetwork!.nodes[current.nodeId];
      if (currentNode == null) continue;
      for (final neighborId in currentNode.connectedNodeIds) {
        if (closedSet.contains(neighborId)) continue;
        if (excludedEdges != null) {
          final edgeId = '${current.nodeId}_$neighborId';
          if (excludedEdges.contains(edgeId)) continue;
        }
        final neighbor = _loadedNetwork!.nodes[neighborId];
        if (neighbor == null) continue;
        final edge = _findEdgeBetween(current.nodeId, neighborId);
        if (edge == null) continue;
        final tentativeGScore = gScore[current.nodeId]! + edge.distanceMeters;
        if (!gScore.containsKey(neighborId) || tentativeGScore < gScore[neighborId]!) {
          cameFrom[neighborId] = current.nodeId;
          gScore[neighborId] = tentativeGScore;
          fScore[neighborId] = tentativeGScore + heuristic(neighbor, end);
          if (!openSet.any((n) => n.nodeId == neighborId)) {
            openSet.add(_PathNode(neighborId, fScore[neighborId]!));
          }
        }
      }
    }
    return null;
  }
  double _directHeuristic(RoadNode from, RoadNode to) {
    return _distance(
      LatLng(from.latitude, from.longitude),
      LatLng(to.latitude, to.longitude),
    );
  }
  double _getRoadQualityScore(RoadNode from, RoadNode to) {
    final edge = _findEdgeBetween(from.id, to.id);
    if (edge == null) return 1000.0;
    switch (edge.roadType) {
      case RoadType.motorway:
      case RoadType.trunk:
        return 500.0;
      case RoadType.primary:
        return 300.0;
      case RoadType.secondary:
        return 200.0;
      case RoadType.tertiary:
        return 100.0;
      case RoadType.residential:
        return 50.0;
      case RoadType.service:
        return 30.0;
      case RoadType.unclassified:
        return 70.0;
    }
  }
  double _getDiversityScore(RoadNode from, RoadNode to) {
    final edge = _findEdgeBetween(from.id, to.id);
    if (edge == null) return 1000.0;
    double score = edge.distanceMeters;
    if (edge.roadType == RoadType.residential ||
        edge.roadType == RoadType.service) {
      score *= 0.7;
    }
    return score;
  }
  double _scoreScenicRoute(List<String> path) {
    double score = 0.0;
    final roadTypes = <RoadType>{};
    for (int i = 0; i < path.length - 1; i++) {
      final edge = _findEdgeBetween(path[i], path[i + 1]);
      if (edge != null) {
        roadTypes.add(edge.roadType);
        switch (edge.roadType) {
          case RoadType.residential:
          case RoadType.tertiary:
          case RoadType.service:
            score += 10;
            break;
          case RoadType.secondary:
            score += 5;
            break;
          case RoadType.motorway:
          case RoadType.trunk:
            score -= 10;
            break;
          default:
            break;
        }
      }
    }
    score += roadTypes.length * 5;
    return score;
  }
  double _calculatePathDistance(List<String> path) {
    double distance = 0.0;
    for (int i = 0; i < path.length - 1; i++) {
      final edge = _findEdgeBetween(path[i], path[i + 1]);
      if (edge != null) {
        distance += edge.distanceMeters;
      }
    }
    return distance;
  }
  RoadNode? _findNearestNode(LatLng location) {
    if (_loadedNetwork == null) return null;
    RoadNode? nearest;
    double minDistance = double.infinity;
    for (final node in _loadedNetwork!.nodes.values) {
      final nodeLocation = LatLng(node.latitude, node.longitude);
      final distance = _distance(location, nodeLocation);
      if (distance < minDistance) {
        minDistance = distance;
        nearest = node;
      }
    }
    return nearest;
  }
  RoadEdge? _findEdgeBetween(String fromId, String toId) {
    for (final edge in _loadedNetwork!.edges.values) {
      if (edge.fromNodeId == fromId && edge.toNodeId == toId) {
        return edge;
      }
      if (!edge.isOneWay && edge.toNodeId == fromId && edge.fromNodeId == toId) {
        return edge;
      }
    }
    return null;
  }
  List<String> _reconstructPath(Map<String, String> cameFrom, String current) {
    final path = <String>[current];
    while (cameFrom.containsKey(current)) {
      current = cameFrom[current]!;
      path.insert(0, current);
    }
    return path;
  }
  RouteResult _convertToRouteResult(
    List<String> nodePath,
    LatLng start,
    LatLng end,
    ScenicRoutePreferences preferences,
  ) {
    final points = <LatLng>[start];
    double totalDistance = 0;
    for (int i = 0; i < nodePath.length - 1; i++) {
      final fromId = nodePath[i];
      final toId = nodePath[i + 1];
      final edge = _findEdgeBetween(fromId, toId);
      if (edge != null) {
        totalDistance += edge.distanceMeters;
        if (edge.geometry.isNotEmpty) {
          points.addAll(edge.geometry);
        } else {
          final fromNode = _loadedNetwork!.nodes[fromId];
          final toNode = _loadedNetwork!.nodes[toId];
          if (fromNode != null && toNode != null) {
            points.add(LatLng(fromNode.latitude, fromNode.longitude));
          }
        }
      }
    }
    points.add(end);
    final duration = totalDistance / (40 * 1000 / 3600);
    final steps = [
      NavigationStep(
        index: 0,
        location: start,
        distanceMeters: totalDistance,
        durationSeconds: duration,
        instruction: 'Begin ${preferences.mode.displayName.toLowerCase()}',
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
    _logger.i('Scenic route: ${points.length} points, ${(totalDistance / 1000).toStringAsFixed(2)} km, mode: ${preferences.mode.displayName}');
    return RouteResult(
      points: points,
      distanceMeters: totalDistance,
      durationSeconds: duration,
      type: RouteType.balanced,
      name: preferences.mode.displayName,
      steps: steps,
    );
  }
}
class _PathNode {
  final String nodeId;
  final double fScore;
  _PathNode(this.nodeId, this.fScore);
}