import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import '../model/offline_road_network.dart';
import '../model/route_models.dart';
class OfflineRoutingEngine {
  static final Logger _logger = Logger();
  final Distance _distance = const Distance();
  RoadNetwork? _loadedNetwork;
  void loadNetwork(RoadNetwork network) {
    _loadedNetwork = network;
    _logger.i('Loaded road network: ${network.regionName} with ${network.nodes.length} nodes, ${network.edges.length} edges');
  }
  bool get hasNetwork => _loadedNetwork != null;
  Future<RouteResult?> calculateRoute({
    required LatLng start,
    required LatLng end,
  }) async {
    if (_loadedNetwork == null) {
      _logger.w('No road network loaded for offline routing');
      return null;
    }
    _logger.i('Calculating offline route from $start to $end');
    final startNode = _findNearestNode(start);
    final endNode = _findNearestNode(end);
    if (startNode == null || endNode == null) {
      _logger.w('Could not find nearby nodes for routing');
      return null;
    }
    _logger.d('Start node: ${startNode.id}, End node: ${endNode.id}');
    final path = await _findPath(startNode, endNode);
    if (path == null || path.isEmpty) {
      _logger.w('No path found between nodes');
      return null;
    }
    return _convertToRouteResult(path, start, end);
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
    _logger.d('Nearest node to $location is ${nearest?.id} at ${minDistance.toStringAsFixed(1)}m');
    return nearest;
  }
  Future<List<String>?> _findPath(RoadNode start, RoadNode end) async {
    final openSet = PriorityQueue<_PathNode>();
    final closedSet = <String>{};
    final cameFrom = <String, String>{};
    final gScore = <String, double>{start.id: 0.0};
    final fScore = <String, double>{
      start.id: _heuristic(start, end),
    };
    openSet.add(_PathNode(start.id, fScore[start.id]!));
    while (openSet.isNotEmpty) {
      final current = openSet.removeFirst();
      if (current.nodeId == end.id) {
        return _reconstructPath(cameFrom, current.nodeId);
      }
      closedSet.add(current.nodeId);
      final currentNode = _loadedNetwork!.nodes[current.nodeId];
      if (currentNode == null) continue;
      for (final neighborId in currentNode.connectedNodeIds) {
        if (closedSet.contains(neighborId)) continue;
        final neighbor = _loadedNetwork!.nodes[neighborId];
        if (neighbor == null) continue;
        final edge = _findEdgeBetween(current.nodeId, neighborId);
        if (edge == null) continue;
        final tentativeGScore = gScore[current.nodeId]! + edge.distanceMeters;
        if (!gScore.containsKey(neighborId) || tentativeGScore < gScore[neighborId]!) {
          cameFrom[neighborId] = current.nodeId;
          gScore[neighborId] = tentativeGScore;
          fScore[neighborId] = tentativeGScore + _heuristic(neighbor, end);
          if (!openSet.contains(neighborId)) {
            openSet.add(_PathNode(neighborId, fScore[neighborId]!));
          }
        }
      }
    }
    return null;
  }
  double _heuristic(RoadNode from, RoadNode to) {
    final fromLatLng = LatLng(from.latitude, from.longitude);
    final toLatLng = LatLng(to.latitude, to.longitude);
    return _distance(fromLatLng, toLatLng);
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
  RouteResult _convertToRouteResult(List<String> nodePath, LatLng start, LatLng end) {
    final points = <LatLng>[];
    final edges = <RoadEdge>[];
    double totalDistance = 0;
    points.add(start);
    for (int i = 0; i < nodePath.length - 1; i++) {
      final fromId = nodePath[i];
      final toId = nodePath[i + 1];
      final edge = _findEdgeBetween(fromId, toId);
      if (edge != null) {
        edges.add(edge);
        totalDistance += edge.distanceMeters;
        if (edge.geometry.isNotEmpty) {
          points.addAll(edge.geometry);
        } else {
          final fromNode = _loadedNetwork!.nodes[fromId];
          final toNode = _loadedNetwork!.nodes[toId];
          if (fromNode != null && toNode != null) {
            points.add(LatLng(fromNode.latitude, fromNode.longitude));
            points.add(LatLng(toNode.latitude, toNode.longitude));
          }
        }
      }
    }
    points.add(end);
    final duration = _estimateDuration(totalDistance, edges);
    final steps = _generateNavigationSteps(edges, start, end);
    _logger.i('Offline route calculated: ${points.length} points, ${steps.length} steps, ${(totalDistance / 1000).toStringAsFixed(2)} km');
    return RouteResult(
      points: points,
      distanceMeters: totalDistance,
      durationSeconds: duration,
      type: RouteType.fastest,
      name: 'Offline Route',
      steps: steps,
    );
  }
  double _estimateDuration(double distanceMeters, List<RoadEdge> edges) {
    if (edges.isEmpty) {
      return distanceMeters / (40 * 1000 / 3600);
    }
    double totalTime = 0;
    for (final edge in edges) {
      final speedMps = edge.speedLimitKmh * 1000 / 3600;
      totalTime += edge.distanceMeters / speedMps;
    }
    return totalTime;
  }
  List<NavigationStep> _generateNavigationSteps(List<RoadEdge> edges, LatLng start, LatLng end) {
    final steps = <NavigationStep>[];
    if (edges.isEmpty) {
      steps.add(NavigationStep(
        index: 0,
        location: start,
        distanceMeters: _distance(start, end),
        durationSeconds: _distance(start, end) / (40 * 1000 / 3600),
        instruction: 'Head towards destination',
        maneuver: ManeuverType.depart,
      ));
      steps.add(NavigationStep(
        index: 1,
        location: end,
        distanceMeters: 0,
        durationSeconds: 0,
        instruction: 'You have arrived at your destination',
        maneuver: ManeuverType.arrive,
      ));
      return steps;
    }
    steps.add(NavigationStep(
      index: 0,
      location: start,
      distanceMeters: edges.first.distanceMeters,
      durationSeconds: edges.first.distanceMeters / (edges.first.speedLimitKmh * 1000 / 3600),
      instruction: 'Head ${edges.first.streetName != null ? "on ${edges.first.streetName}" : "straight"}',
      maneuver: ManeuverType.depart,
      streetName: edges.first.streetName,
    ));
    for (int i = 0; i < edges.length - 1; i++) {
      final current = edges[i];
      final next = edges[i + 1];
      final maneuver = _determineManeuver(current, next);
      final node = _loadedNetwork!.nodes[current.toNodeId];
      if (node != null) {
        steps.add(NavigationStep(
          index: steps.length,
          location: LatLng(node.latitude, node.longitude),
          distanceMeters: next.distanceMeters,
          durationSeconds: next.distanceMeters / (next.speedLimitKmh * 1000 / 3600),
          instruction: _generateInstruction(maneuver, next.streetName),
          maneuver: maneuver,
          streetName: next.streetName,
        ));
      }
    }
    steps.add(NavigationStep(
      index: steps.length,
      location: end,
      distanceMeters: 0,
      durationSeconds: 0,
      instruction: 'You have arrived at your destination',
      maneuver: ManeuverType.arrive,
    ));
    return steps;
  }
  ManeuverType _determineManeuver(RoadEdge current, RoadEdge next) {
    if (current.streetName != next.streetName && next.streetName != null) {
      return ManeuverType.turn;
    }
    return ManeuverType.continueRoute;
  }
  String _generateInstruction(ManeuverType maneuver, String? streetName) {
    switch (maneuver) {
      case ManeuverType.turn:
        return 'Turn ${streetName != null ? "onto $streetName" : ""}';
      case ManeuverType.continueRoute:
        return 'Continue ${streetName != null ? "on $streetName" : "straight"}';
      default:
        return 'Continue';
    }
  }
}
class _PathNode implements Comparable<_PathNode> {
  final String nodeId;
  final double fScore;
  _PathNode(this.nodeId, this.fScore);
  @override
  int compareTo(_PathNode other) => fScore.compareTo(other.fScore);
}
class PriorityQueue<T extends Comparable> {
  final List<T> _heap = [];
  void add(T item) {
    _heap.add(item);
    _bubbleUp(_heap.length - 1);
  }
  T removeFirst() {
    final result = _heap.first;
    final last = _heap.removeLast();
    if (_heap.isNotEmpty) {
      _heap[0] = last;
      _bubbleDown(0);
    }
    return result;
  }
  bool get isNotEmpty => _heap.isNotEmpty;
  bool get isEmpty => _heap.isEmpty;
  bool contains(String nodeId) {
    return _heap.any((node) => (node as _PathNode).nodeId == nodeId);
  }
  void _bubbleUp(int index) {
    while (index > 0) {
      final parentIndex = (index - 1) ~/ 2;
      if (_heap[index].compareTo(_heap[parentIndex]) >= 0) break;
      final temp = _heap[index];
      _heap[index] = _heap[parentIndex];
      _heap[parentIndex] = temp;
      index = parentIndex;
    }
  }
  void _bubbleDown(int index) {
    while (true) {
      final leftChild = 2 * index + 1;
      final rightChild = 2 * index + 2;
      int smallest = index;
      if (leftChild < _heap.length && _heap[leftChild].compareTo(_heap[smallest]) < 0) {
        smallest = leftChild;
      }
      if (rightChild < _heap.length && _heap[rightChild].compareTo(_heap[smallest]) < 0) {
        smallest = rightChild;
      }
      if (smallest == index) break;
      final temp = _heap[index];
      _heap[index] = _heap[smallest];
      _heap[smallest] = temp;
      index = smallest;
    }
  }
}