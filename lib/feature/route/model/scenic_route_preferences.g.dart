// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scenic_route_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScenicRoutePreferencesImpl _$$ScenicRoutePreferencesImplFromJson(
        Map<String, dynamic> json) =>
    _$ScenicRoutePreferencesImpl(
      mode: $enumDecodeNullable(_$ScenicModeEnumMap, json['mode']) ??
          ScenicMode.balanced,
      maxDetourMultiplier:
          (json['maxDetourMultiplier'] as num?)?.toDouble() ?? 1.5,
      avoidHighways: json['avoidHighways'] as bool? ?? true,
      preferLocalStreets: json['preferLocalStreets'] as bool? ?? true,
      exploreSideStreets: json['exploreSideStreets'] as bool? ?? true,
      preferredRoadTypes: (json['preferredRoadTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      poiPreferences: (json['poiPreferences'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$PointOfInterestTypeEnumMap, e))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ScenicRoutePreferencesImplToJson(
        _$ScenicRoutePreferencesImpl instance) =>
    <String, dynamic>{
      'mode': _$ScenicModeEnumMap[instance.mode]!,
      'maxDetourMultiplier': instance.maxDetourMultiplier,
      'avoidHighways': instance.avoidHighways,
      'preferLocalStreets': instance.preferLocalStreets,
      'exploreSideStreets': instance.exploreSideStreets,
      'preferredRoadTypes': instance.preferredRoadTypes,
      'poiPreferences': instance.poiPreferences
          .map((e) => _$PointOfInterestTypeEnumMap[e]!)
          .toList(),
    };

const _$ScenicModeEnumMap = {
  ScenicMode.direct: 'direct',
  ScenicMode.balanced: 'balanced',
  ScenicMode.scenic: 'scenic',
  ScenicMode.exploration: 'exploration',
  ScenicMode.spiral: 'spiral',
};

const _$PointOfInterestTypeEnumMap = {
  PointOfInterestType.parks: 'parks',
  PointOfInterestType.landmarks: 'landmarks',
  PointOfInterestType.viewpoints: 'viewpoints',
  PointOfInterestType.historicSites: 'historicSites',
  PointOfInterestType.restaurants: 'restaurants',
  PointOfInterestType.shops: 'shops',
  PointOfInterestType.waterfront: 'waterfront',
  PointOfInterestType.gardens: 'gardens',
};
