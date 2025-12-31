// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RouteResultImpl _$$RouteResultImplFromJson(Map<String, dynamic> json) =>
    _$RouteResultImpl(
      points: (json['points'] as List<dynamic>)
          .map((e) => LatLng.fromJson(e as Map<String, dynamic>))
          .toList(),
      distanceMeters: (json['distanceMeters'] as num).toDouble(),
      durationSeconds: (json['durationSeconds'] as num).toDouble(),
      type: $enumDecode(_$RouteTypeEnumMap, json['type']),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$RouteResultImplToJson(_$RouteResultImpl instance) =>
    <String, dynamic>{
      'points': instance.points,
      'distanceMeters': instance.distanceMeters,
      'durationSeconds': instance.durationSeconds,
      'type': _$RouteTypeEnumMap[instance.type]!,
      'name': instance.name,
    };

const _$RouteTypeEnumMap = {
  RouteType.fastest: 'fastest',
  RouteType.shortest: 'shortest',
  RouteType.balanced: 'balanced',
};

_$RoutePreferencesImpl _$$RoutePreferencesImplFromJson(
        Map<String, dynamic> json) =>
    _$RoutePreferencesImpl(
      preferredType:
          $enumDecodeNullable(_$RouteTypeEnumMap, json['preferredType']) ??
              RouteType.fastest,
      avoidHighways: json['avoidHighways'] as bool? ?? false,
      avoidTolls: json['avoidTolls'] as bool? ?? false,
      avoidFerries: json['avoidFerries'] as bool? ?? false,
      avoidUnpaved: json['avoidUnpaved'] as bool? ?? false,
    );

Map<String, dynamic> _$$RoutePreferencesImplToJson(
        _$RoutePreferencesImpl instance) =>
    <String, dynamic>{
      'preferredType': _$RouteTypeEnumMap[instance.preferredType]!,
      'avoidHighways': instance.avoidHighways,
      'avoidTolls': instance.avoidTolls,
      'avoidFerries': instance.avoidFerries,
      'avoidUnpaved': instance.avoidUnpaved,
    };

_$WaypointImpl _$$WaypointImplFromJson(Map<String, dynamic> json) =>
    _$WaypointImpl(
      id: json['id'] as String,
      location: LatLng.fromJson(json['location'] as Map<String, dynamic>),
      name: json['name'] as String?,
      address: json['address'] as String?,
      isCompleted: json['isCompleted'] as bool? ?? false,
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$WaypointImplToJson(_$WaypointImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'location': instance.location,
      'name': instance.name,
      'address': instance.address,
      'isCompleted': instance.isCompleted,
      'order': instance.order,
    };

_$RouteWithWaypointsImpl _$$RouteWithWaypointsImplFromJson(
        Map<String, dynamic> json) =>
    _$RouteWithWaypointsImpl(
      start: LatLng.fromJson(json['start'] as Map<String, dynamic>),
      destination: LatLng.fromJson(json['destination'] as Map<String, dynamic>),
      waypoints: (json['waypoints'] as List<dynamic>?)
              ?.map((e) => Waypoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      activeRoute: json['activeRoute'] == null
          ? null
          : RouteResult.fromJson(json['activeRoute'] as Map<String, dynamic>),
      alternativeRoutes: (json['alternativeRoutes'] as List<dynamic>?)
              ?.map((e) => RouteResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      preferences: json['preferences'] == null
          ? const RoutePreferences()
          : RoutePreferences.fromJson(
              json['preferences'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RouteWithWaypointsImplToJson(
        _$RouteWithWaypointsImpl instance) =>
    <String, dynamic>{
      'start': instance.start,
      'destination': instance.destination,
      'waypoints': instance.waypoints,
      'activeRoute': instance.activeRoute,
      'alternativeRoutes': instance.alternativeRoutes,
      'preferences': instance.preferences,
    };
