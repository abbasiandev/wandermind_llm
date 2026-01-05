import 'package:freezed_annotation/freezed_annotation.dart';
part 'scenic_route_preferences.freezed.dart';
part 'scenic_route_preferences.g.dart';
@freezed
class ScenicRoutePreferences with _$ScenicRoutePreferences {
  const factory ScenicRoutePreferences({
    @Default(ScenicMode.balanced) ScenicMode mode,
    @Default(1.5) double maxDetourMultiplier,
    @Default(true) bool avoidHighways,
    @Default(true) bool preferLocalStreets,
    @Default(true) bool exploreSideStreets,
    @Default([]) List<String> preferredRoadTypes,
    @Default([]) List<PointOfInterestType> poiPreferences,
  }) = _ScenicRoutePreferences;
  factory ScenicRoutePreferences.fromJson(Map<String, dynamic> json) =>
      _$ScenicRoutePreferencesFromJson(json);
}
enum ScenicMode {
  direct,
  balanced,
  scenic,
  exploration,
  spiral,
}
enum PointOfInterestType {
  parks,
  landmarks,
  viewpoints,
  historicSites,
  restaurants,
  shops,
  waterfront,
  gardens,
}
extension ScenicModeExtension on ScenicMode {
  String get displayName {
    switch (this) {
      case ScenicMode.direct:
        return 'Direct Route';
      case ScenicMode.balanced:
        return 'Balanced Route';
      case ScenicMode.scenic:
        return 'Scenic Route';
      case ScenicMode.exploration:
        return 'Exploration Route';
      case ScenicMode.spiral:
        return 'Spiral Route';
    }
  }
  String get description {
    switch (this) {
      case ScenicMode.direct:
        return 'Fastest route, minimal detours';
      case ScenicMode.balanced:
        return 'Good balance of speed and scenery';
      case ScenicMode.scenic:
        return 'Prioritizes beautiful streets and views';
      case ScenicMode.exploration:
        return 'Discover new areas and neighborhoods';
      case ScenicMode.spiral:
        return 'Winding path through streets and alleys';
    }
  }
  double get detourMultiplier {
    switch (this) {
      case ScenicMode.direct:
        return 1.0;
      case ScenicMode.balanced:
        return 1.3;
      case ScenicMode.scenic:
        return 1.8;
      case ScenicMode.exploration:
        return 2.5;
      case ScenicMode.spiral:
        return 3.0;
    }
  }
}