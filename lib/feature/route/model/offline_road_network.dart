import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
part 'offline_road_network.freezed.dart';
part 'offline_road_network.g.dart';
@freezed
class RoadNode with _$RoadNode {
  const factory RoadNode({
    required String id,
    required double latitude,
    required double longitude,
    @Default([]) List<String> connectedNodeIds,
  }) = _RoadNode;
  factory RoadNode.fromJson(Map<String, dynamic> json) =>
      _$RoadNodeFromJson(json);
}
@freezed
class RoadEdge with _$RoadEdge {
  const factory RoadEdge({
    required String id,
    required String fromNodeId,
    required String toNodeId,
    required double distanceMeters,
    required String? streetName,
    required RoadType roadType,
    required double speedLimitKmh,
    @Default(false) bool isOneWay,
    @Default([]) List<LatLng> geometry,
  }) = _RoadEdge;
  factory RoadEdge.fromJson(Map<String, dynamic> json) =>
      _$RoadEdgeFromJson(json);
}
enum RoadType {
  motorway,
  trunk,
  primary,
  secondary,
  tertiary,
  residential,
  service,
  unclassified,
}
@freezed
class RoadNetwork with _$RoadNetwork {
  const factory RoadNetwork({
    required String regionId,
    required String regionName,
    required double minLat,
    required double maxLat,
    required double minLon,
    required double maxLon,
    required Map<String, RoadNode> nodes,
    required Map<String, RoadEdge> edges,
    required DateTime lastUpdated,
  }) = _RoadNetwork;
  factory RoadNetwork.fromJson(Map<String, dynamic> json) =>
      _$RoadNetworkFromJson(json);
}
class OfflineRouteResult {
  final List<LatLng> points;
  final List<RoadEdge> edges;
  final double totalDistance;
  final double estimatedDuration;
  final List<String> nodeIds;
  OfflineRouteResult({
    required this.points,
    required this.edges,
    required this.totalDistance,
    required this.estimatedDuration,
    required this.nodeIds,
  });
}