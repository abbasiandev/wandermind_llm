// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_road_network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoadNodeImpl _$$RoadNodeImplFromJson(Map<String, dynamic> json) =>
    _$RoadNodeImpl(
      id: json['id'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      connectedNodeIds: (json['connectedNodeIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$RoadNodeImplToJson(_$RoadNodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'connectedNodeIds': instance.connectedNodeIds,
    };

_$RoadEdgeImpl _$$RoadEdgeImplFromJson(Map<String, dynamic> json) =>
    _$RoadEdgeImpl(
      id: json['id'] as String,
      fromNodeId: json['fromNodeId'] as String,
      toNodeId: json['toNodeId'] as String,
      distanceMeters: (json['distanceMeters'] as num).toDouble(),
      streetName: json['streetName'] as String?,
      roadType: $enumDecode(_$RoadTypeEnumMap, json['roadType']),
      speedLimitKmh: (json['speedLimitKmh'] as num).toDouble(),
      isOneWay: json['isOneWay'] as bool? ?? false,
      geometry: (json['geometry'] as List<dynamic>?)
              ?.map((e) => LatLng.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$RoadEdgeImplToJson(_$RoadEdgeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fromNodeId': instance.fromNodeId,
      'toNodeId': instance.toNodeId,
      'distanceMeters': instance.distanceMeters,
      'streetName': instance.streetName,
      'roadType': _$RoadTypeEnumMap[instance.roadType]!,
      'speedLimitKmh': instance.speedLimitKmh,
      'isOneWay': instance.isOneWay,
      'geometry': instance.geometry,
    };

const _$RoadTypeEnumMap = {
  RoadType.motorway: 'motorway',
  RoadType.trunk: 'trunk',
  RoadType.primary: 'primary',
  RoadType.secondary: 'secondary',
  RoadType.tertiary: 'tertiary',
  RoadType.residential: 'residential',
  RoadType.service: 'service',
  RoadType.unclassified: 'unclassified',
};

_$RoadNetworkImpl _$$RoadNetworkImplFromJson(Map<String, dynamic> json) =>
    _$RoadNetworkImpl(
      regionId: json['regionId'] as String,
      regionName: json['regionName'] as String,
      minLat: (json['minLat'] as num).toDouble(),
      maxLat: (json['maxLat'] as num).toDouble(),
      minLon: (json['minLon'] as num).toDouble(),
      maxLon: (json['maxLon'] as num).toDouble(),
      nodes: (json['nodes'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, RoadNode.fromJson(e as Map<String, dynamic>)),
      ),
      edges: (json['edges'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, RoadEdge.fromJson(e as Map<String, dynamic>)),
      ),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$RoadNetworkImplToJson(_$RoadNetworkImpl instance) =>
    <String, dynamic>{
      'regionId': instance.regionId,
      'regionName': instance.regionName,
      'minLat': instance.minLat,
      'maxLat': instance.maxLat,
      'minLon': instance.minLon,
      'maxLon': instance.maxLon,
      'nodes': instance.nodes,
      'edges': instance.edges,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };
