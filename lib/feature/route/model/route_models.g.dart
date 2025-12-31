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
      steps: (json['steps'] as List<dynamic>?)
              ?.map((e) => NavigationStep.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$RouteResultImplToJson(_$RouteResultImpl instance) =>
    <String, dynamic>{
      'points': instance.points,
      'distanceMeters': instance.distanceMeters,
      'durationSeconds': instance.durationSeconds,
      'type': _$RouteTypeEnumMap[instance.type]!,
      'name': instance.name,
      'steps': instance.steps,
    };

const _$RouteTypeEnumMap = {
  RouteType.fastest: 'fastest',
  RouteType.shortest: 'shortest',
  RouteType.balanced: 'balanced',
};

_$NavigationStepImpl _$$NavigationStepImplFromJson(Map<String, dynamic> json) =>
    _$NavigationStepImpl(
      index: (json['index'] as num).toInt(),
      location: LatLng.fromJson(json['location'] as Map<String, dynamic>),
      distanceMeters: (json['distanceMeters'] as num).toDouble(),
      durationSeconds: (json['durationSeconds'] as num).toDouble(),
      instruction: json['instruction'] as String,
      maneuver: $enumDecode(_$ManeuverTypeEnumMap, json['maneuver']),
      streetName: json['streetName'] as String?,
      destination: json['destination'] as String?,
      exitNumber: (json['exitNumber'] as num?)?.toInt(),
      bearing: (json['bearing'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$NavigationStepImplToJson(
        _$NavigationStepImpl instance) =>
    <String, dynamic>{
      'index': instance.index,
      'location': instance.location,
      'distanceMeters': instance.distanceMeters,
      'durationSeconds': instance.durationSeconds,
      'instruction': instance.instruction,
      'maneuver': _$ManeuverTypeEnumMap[instance.maneuver]!,
      'streetName': instance.streetName,
      'destination': instance.destination,
      'exitNumber': instance.exitNumber,
      'bearing': instance.bearing,
    };

const _$ManeuverTypeEnumMap = {
  ManeuverType.depart: 'depart',
  ManeuverType.turn: 'turn',
  ManeuverType.newName: 'newName',
  ManeuverType.continueRoute: 'continueRoute',
  ManeuverType.merge: 'merge',
  ManeuverType.onRamp: 'onRamp',
  ManeuverType.offRamp: 'offRamp',
  ManeuverType.fork: 'fork',
  ManeuverType.endOfRoad: 'endOfRoad',
  ManeuverType.useLane: 'useLane',
  ManeuverType.continueUturn: 'continueUturn',
  ManeuverType.continueLeft: 'continueLeft',
  ManeuverType.continueRight: 'continueRight',
  ManeuverType.keepLeft: 'keepLeft',
  ManeuverType.keepRight: 'keepRight',
  ManeuverType.turnLeft: 'turnLeft',
  ManeuverType.turnRight: 'turnRight',
  ManeuverType.turnSlightLeft: 'turnSlightLeft',
  ManeuverType.turnSlightRight: 'turnSlightRight',
  ManeuverType.turnSharpLeft: 'turnSharpLeft',
  ManeuverType.turnSharpRight: 'turnSharpRight',
  ManeuverType.uTurn: 'uTurn',
  ManeuverType.arrive: 'arrive',
  ManeuverType.roundabout: 'roundabout',
  ManeuverType.rotary: 'rotary',
};

_$NavigationStateImpl _$$NavigationStateImplFromJson(
        Map<String, dynamic> json) =>
    _$NavigationStateImpl(
      isNavigating: json['isNavigating'] as bool,
      currentStep: json['currentStep'] == null
          ? null
          : NavigationStep.fromJson(
              json['currentStep'] as Map<String, dynamic>),
      nextStep: json['nextStep'] == null
          ? null
          : NavigationStep.fromJson(json['nextStep'] as Map<String, dynamic>),
      currentStepIndex: (json['currentStepIndex'] as num?)?.toInt() ?? 0,
      distanceToNextStep:
          (json['distanceToNextStep'] as num?)?.toDouble() ?? 0.0,
      totalDistanceRemaining:
          (json['totalDistanceRemaining'] as num?)?.toDouble() ?? 0.0,
      totalDurationRemaining:
          (json['totalDurationRemaining'] as num?)?.toDouble() ?? 0.0,
      isOffRoute: json['isOffRoute'] as bool? ?? false,
      isRerouting: json['isRerouting'] as bool? ?? false,
      lastUpdateTime: json['lastUpdateTime'] == null
          ? null
          : DateTime.parse(json['lastUpdateTime'] as String),
    );

Map<String, dynamic> _$$NavigationStateImplToJson(
        _$NavigationStateImpl instance) =>
    <String, dynamic>{
      'isNavigating': instance.isNavigating,
      'currentStep': instance.currentStep,
      'nextStep': instance.nextStep,
      'currentStepIndex': instance.currentStepIndex,
      'distanceToNextStep': instance.distanceToNextStep,
      'totalDistanceRemaining': instance.totalDistanceRemaining,
      'totalDurationRemaining': instance.totalDurationRemaining,
      'isOffRoute': instance.isOffRoute,
      'isRerouting': instance.isRerouting,
      'lastUpdateTime': instance.lastUpdateTime?.toIso8601String(),
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
