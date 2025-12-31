// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RouteResult _$RouteResultFromJson(Map<String, dynamic> json) {
  return _RouteResult.fromJson(json);
}

/// @nodoc
mixin _$RouteResult {
  List<LatLng> get points => throw _privateConstructorUsedError;
  double get distanceMeters => throw _privateConstructorUsedError;
  double get durationSeconds => throw _privateConstructorUsedError;
  RouteType get type => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RouteResultCopyWith<RouteResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteResultCopyWith<$Res> {
  factory $RouteResultCopyWith(
          RouteResult value, $Res Function(RouteResult) then) =
      _$RouteResultCopyWithImpl<$Res, RouteResult>;
  @useResult
  $Res call(
      {List<LatLng> points,
      double distanceMeters,
      double durationSeconds,
      RouteType type,
      String? name});
}

/// @nodoc
class _$RouteResultCopyWithImpl<$Res, $Val extends RouteResult>
    implements $RouteResultCopyWith<$Res> {
  _$RouteResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? points = null,
    Object? distanceMeters = null,
    Object? durationSeconds = null,
    Object? type = null,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as List<LatLng>,
      distanceMeters: null == distanceMeters
          ? _value.distanceMeters
          : distanceMeters // ignore: cast_nullable_to_non_nullable
              as double,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RouteType,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RouteResultImplCopyWith<$Res>
    implements $RouteResultCopyWith<$Res> {
  factory _$$RouteResultImplCopyWith(
          _$RouteResultImpl value, $Res Function(_$RouteResultImpl) then) =
      __$$RouteResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<LatLng> points,
      double distanceMeters,
      double durationSeconds,
      RouteType type,
      String? name});
}

/// @nodoc
class __$$RouteResultImplCopyWithImpl<$Res>
    extends _$RouteResultCopyWithImpl<$Res, _$RouteResultImpl>
    implements _$$RouteResultImplCopyWith<$Res> {
  __$$RouteResultImplCopyWithImpl(
      _$RouteResultImpl _value, $Res Function(_$RouteResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? points = null,
    Object? distanceMeters = null,
    Object? durationSeconds = null,
    Object? type = null,
    Object? name = freezed,
  }) {
    return _then(_$RouteResultImpl(
      points: null == points
          ? _value._points
          : points // ignore: cast_nullable_to_non_nullable
              as List<LatLng>,
      distanceMeters: null == distanceMeters
          ? _value.distanceMeters
          : distanceMeters // ignore: cast_nullable_to_non_nullable
              as double,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RouteType,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteResultImpl implements _RouteResult {
  const _$RouteResultImpl(
      {required final List<LatLng> points,
      required this.distanceMeters,
      required this.durationSeconds,
      required this.type,
      this.name})
      : _points = points;

  factory _$RouteResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteResultImplFromJson(json);

  final List<LatLng> _points;
  @override
  List<LatLng> get points {
    if (_points is EqualUnmodifiableListView) return _points;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_points);
  }

  @override
  final double distanceMeters;
  @override
  final double durationSeconds;
  @override
  final RouteType type;
  @override
  final String? name;

  @override
  String toString() {
    return 'RouteResult(points: $points, distanceMeters: $distanceMeters, durationSeconds: $durationSeconds, type: $type, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteResultImpl &&
            const DeepCollectionEquality().equals(other._points, _points) &&
            (identical(other.distanceMeters, distanceMeters) ||
                other.distanceMeters == distanceMeters) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_points),
      distanceMeters,
      durationSeconds,
      type,
      name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteResultImplCopyWith<_$RouteResultImpl> get copyWith =>
      __$$RouteResultImplCopyWithImpl<_$RouteResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteResultImplToJson(
      this,
    );
  }
}

abstract class _RouteResult implements RouteResult {
  const factory _RouteResult(
      {required final List<LatLng> points,
      required final double distanceMeters,
      required final double durationSeconds,
      required final RouteType type,
      final String? name}) = _$RouteResultImpl;

  factory _RouteResult.fromJson(Map<String, dynamic> json) =
      _$RouteResultImpl.fromJson;

  @override
  List<LatLng> get points;
  @override
  double get distanceMeters;
  @override
  double get durationSeconds;
  @override
  RouteType get type;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$RouteResultImplCopyWith<_$RouteResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RoutePreferences _$RoutePreferencesFromJson(Map<String, dynamic> json) {
  return _RoutePreferences.fromJson(json);
}

/// @nodoc
mixin _$RoutePreferences {
  RouteType get preferredType => throw _privateConstructorUsedError;
  bool get avoidHighways => throw _privateConstructorUsedError;
  bool get avoidTolls => throw _privateConstructorUsedError;
  bool get avoidFerries => throw _privateConstructorUsedError;
  bool get avoidUnpaved => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoutePreferencesCopyWith<RoutePreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoutePreferencesCopyWith<$Res> {
  factory $RoutePreferencesCopyWith(
          RoutePreferences value, $Res Function(RoutePreferences) then) =
      _$RoutePreferencesCopyWithImpl<$Res, RoutePreferences>;
  @useResult
  $Res call(
      {RouteType preferredType,
      bool avoidHighways,
      bool avoidTolls,
      bool avoidFerries,
      bool avoidUnpaved});
}

/// @nodoc
class _$RoutePreferencesCopyWithImpl<$Res, $Val extends RoutePreferences>
    implements $RoutePreferencesCopyWith<$Res> {
  _$RoutePreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preferredType = null,
    Object? avoidHighways = null,
    Object? avoidTolls = null,
    Object? avoidFerries = null,
    Object? avoidUnpaved = null,
  }) {
    return _then(_value.copyWith(
      preferredType: null == preferredType
          ? _value.preferredType
          : preferredType // ignore: cast_nullable_to_non_nullable
              as RouteType,
      avoidHighways: null == avoidHighways
          ? _value.avoidHighways
          : avoidHighways // ignore: cast_nullable_to_non_nullable
              as bool,
      avoidTolls: null == avoidTolls
          ? _value.avoidTolls
          : avoidTolls // ignore: cast_nullable_to_non_nullable
              as bool,
      avoidFerries: null == avoidFerries
          ? _value.avoidFerries
          : avoidFerries // ignore: cast_nullable_to_non_nullable
              as bool,
      avoidUnpaved: null == avoidUnpaved
          ? _value.avoidUnpaved
          : avoidUnpaved // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoutePreferencesImplCopyWith<$Res>
    implements $RoutePreferencesCopyWith<$Res> {
  factory _$$RoutePreferencesImplCopyWith(_$RoutePreferencesImpl value,
          $Res Function(_$RoutePreferencesImpl) then) =
      __$$RoutePreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RouteType preferredType,
      bool avoidHighways,
      bool avoidTolls,
      bool avoidFerries,
      bool avoidUnpaved});
}

/// @nodoc
class __$$RoutePreferencesImplCopyWithImpl<$Res>
    extends _$RoutePreferencesCopyWithImpl<$Res, _$RoutePreferencesImpl>
    implements _$$RoutePreferencesImplCopyWith<$Res> {
  __$$RoutePreferencesImplCopyWithImpl(_$RoutePreferencesImpl _value,
      $Res Function(_$RoutePreferencesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preferredType = null,
    Object? avoidHighways = null,
    Object? avoidTolls = null,
    Object? avoidFerries = null,
    Object? avoidUnpaved = null,
  }) {
    return _then(_$RoutePreferencesImpl(
      preferredType: null == preferredType
          ? _value.preferredType
          : preferredType // ignore: cast_nullable_to_non_nullable
              as RouteType,
      avoidHighways: null == avoidHighways
          ? _value.avoidHighways
          : avoidHighways // ignore: cast_nullable_to_non_nullable
              as bool,
      avoidTolls: null == avoidTolls
          ? _value.avoidTolls
          : avoidTolls // ignore: cast_nullable_to_non_nullable
              as bool,
      avoidFerries: null == avoidFerries
          ? _value.avoidFerries
          : avoidFerries // ignore: cast_nullable_to_non_nullable
              as bool,
      avoidUnpaved: null == avoidUnpaved
          ? _value.avoidUnpaved
          : avoidUnpaved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoutePreferencesImpl implements _RoutePreferences {
  const _$RoutePreferencesImpl(
      {this.preferredType = RouteType.fastest,
      this.avoidHighways = false,
      this.avoidTolls = false,
      this.avoidFerries = false,
      this.avoidUnpaved = false});

  factory _$RoutePreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoutePreferencesImplFromJson(json);

  @override
  @JsonKey()
  final RouteType preferredType;
  @override
  @JsonKey()
  final bool avoidHighways;
  @override
  @JsonKey()
  final bool avoidTolls;
  @override
  @JsonKey()
  final bool avoidFerries;
  @override
  @JsonKey()
  final bool avoidUnpaved;

  @override
  String toString() {
    return 'RoutePreferences(preferredType: $preferredType, avoidHighways: $avoidHighways, avoidTolls: $avoidTolls, avoidFerries: $avoidFerries, avoidUnpaved: $avoidUnpaved)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoutePreferencesImpl &&
            (identical(other.preferredType, preferredType) ||
                other.preferredType == preferredType) &&
            (identical(other.avoidHighways, avoidHighways) ||
                other.avoidHighways == avoidHighways) &&
            (identical(other.avoidTolls, avoidTolls) ||
                other.avoidTolls == avoidTolls) &&
            (identical(other.avoidFerries, avoidFerries) ||
                other.avoidFerries == avoidFerries) &&
            (identical(other.avoidUnpaved, avoidUnpaved) ||
                other.avoidUnpaved == avoidUnpaved));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, preferredType, avoidHighways,
      avoidTolls, avoidFerries, avoidUnpaved);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoutePreferencesImplCopyWith<_$RoutePreferencesImpl> get copyWith =>
      __$$RoutePreferencesImplCopyWithImpl<_$RoutePreferencesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoutePreferencesImplToJson(
      this,
    );
  }
}

abstract class _RoutePreferences implements RoutePreferences {
  const factory _RoutePreferences(
      {final RouteType preferredType,
      final bool avoidHighways,
      final bool avoidTolls,
      final bool avoidFerries,
      final bool avoidUnpaved}) = _$RoutePreferencesImpl;

  factory _RoutePreferences.fromJson(Map<String, dynamic> json) =
      _$RoutePreferencesImpl.fromJson;

  @override
  RouteType get preferredType;
  @override
  bool get avoidHighways;
  @override
  bool get avoidTolls;
  @override
  bool get avoidFerries;
  @override
  bool get avoidUnpaved;
  @override
  @JsonKey(ignore: true)
  _$$RoutePreferencesImplCopyWith<_$RoutePreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Waypoint _$WaypointFromJson(Map<String, dynamic> json) {
  return _Waypoint.fromJson(json);
}

/// @nodoc
mixin _$Waypoint {
  String get id => throw _privateConstructorUsedError;
  LatLng get location => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  int? get order => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WaypointCopyWith<Waypoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WaypointCopyWith<$Res> {
  factory $WaypointCopyWith(Waypoint value, $Res Function(Waypoint) then) =
      _$WaypointCopyWithImpl<$Res, Waypoint>;
  @useResult
  $Res call(
      {String id,
      LatLng location,
      String? name,
      String? address,
      bool isCompleted,
      int? order});
}

/// @nodoc
class _$WaypointCopyWithImpl<$Res, $Val extends Waypoint>
    implements $WaypointCopyWith<$Res> {
  _$WaypointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? location = null,
    Object? name = freezed,
    Object? address = freezed,
    Object? isCompleted = null,
    Object? order = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLng,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WaypointImplCopyWith<$Res>
    implements $WaypointCopyWith<$Res> {
  factory _$$WaypointImplCopyWith(
          _$WaypointImpl value, $Res Function(_$WaypointImpl) then) =
      __$$WaypointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      LatLng location,
      String? name,
      String? address,
      bool isCompleted,
      int? order});
}

/// @nodoc
class __$$WaypointImplCopyWithImpl<$Res>
    extends _$WaypointCopyWithImpl<$Res, _$WaypointImpl>
    implements _$$WaypointImplCopyWith<$Res> {
  __$$WaypointImplCopyWithImpl(
      _$WaypointImpl _value, $Res Function(_$WaypointImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? location = null,
    Object? name = freezed,
    Object? address = freezed,
    Object? isCompleted = null,
    Object? order = freezed,
  }) {
    return _then(_$WaypointImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLng,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WaypointImpl implements _Waypoint {
  const _$WaypointImpl(
      {required this.id,
      required this.location,
      this.name,
      this.address,
      this.isCompleted = false,
      this.order});

  factory _$WaypointImpl.fromJson(Map<String, dynamic> json) =>
      _$$WaypointImplFromJson(json);

  @override
  final String id;
  @override
  final LatLng location;
  @override
  final String? name;
  @override
  final String? address;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  final int? order;

  @override
  String toString() {
    return 'Waypoint(id: $id, location: $location, name: $name, address: $address, isCompleted: $isCompleted, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WaypointImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, location, name, address, isCompleted, order);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WaypointImplCopyWith<_$WaypointImpl> get copyWith =>
      __$$WaypointImplCopyWithImpl<_$WaypointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WaypointImplToJson(
      this,
    );
  }
}

abstract class _Waypoint implements Waypoint {
  const factory _Waypoint(
      {required final String id,
      required final LatLng location,
      final String? name,
      final String? address,
      final bool isCompleted,
      final int? order}) = _$WaypointImpl;

  factory _Waypoint.fromJson(Map<String, dynamic> json) =
      _$WaypointImpl.fromJson;

  @override
  String get id;
  @override
  LatLng get location;
  @override
  String? get name;
  @override
  String? get address;
  @override
  bool get isCompleted;
  @override
  int? get order;
  @override
  @JsonKey(ignore: true)
  _$$WaypointImplCopyWith<_$WaypointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RouteWithWaypoints _$RouteWithWaypointsFromJson(Map<String, dynamic> json) {
  return _RouteWithWaypoints.fromJson(json);
}

/// @nodoc
mixin _$RouteWithWaypoints {
  LatLng get start => throw _privateConstructorUsedError;
  LatLng get destination => throw _privateConstructorUsedError;
  List<Waypoint> get waypoints => throw _privateConstructorUsedError;
  RouteResult? get activeRoute => throw _privateConstructorUsedError;
  List<RouteResult> get alternativeRoutes => throw _privateConstructorUsedError;
  RoutePreferences get preferences => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RouteWithWaypointsCopyWith<RouteWithWaypoints> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteWithWaypointsCopyWith<$Res> {
  factory $RouteWithWaypointsCopyWith(
          RouteWithWaypoints value, $Res Function(RouteWithWaypoints) then) =
      _$RouteWithWaypointsCopyWithImpl<$Res, RouteWithWaypoints>;
  @useResult
  $Res call(
      {LatLng start,
      LatLng destination,
      List<Waypoint> waypoints,
      RouteResult? activeRoute,
      List<RouteResult> alternativeRoutes,
      RoutePreferences preferences});

  $RouteResultCopyWith<$Res>? get activeRoute;
  $RoutePreferencesCopyWith<$Res> get preferences;
}

/// @nodoc
class _$RouteWithWaypointsCopyWithImpl<$Res, $Val extends RouteWithWaypoints>
    implements $RouteWithWaypointsCopyWith<$Res> {
  _$RouteWithWaypointsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? destination = null,
    Object? waypoints = null,
    Object? activeRoute = freezed,
    Object? alternativeRoutes = null,
    Object? preferences = null,
  }) {
    return _then(_value.copyWith(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as LatLng,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as LatLng,
      waypoints: null == waypoints
          ? _value.waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as List<Waypoint>,
      activeRoute: freezed == activeRoute
          ? _value.activeRoute
          : activeRoute // ignore: cast_nullable_to_non_nullable
              as RouteResult?,
      alternativeRoutes: null == alternativeRoutes
          ? _value.alternativeRoutes
          : alternativeRoutes // ignore: cast_nullable_to_non_nullable
              as List<RouteResult>,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as RoutePreferences,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RouteResultCopyWith<$Res>? get activeRoute {
    if (_value.activeRoute == null) {
      return null;
    }

    return $RouteResultCopyWith<$Res>(_value.activeRoute!, (value) {
      return _then(_value.copyWith(activeRoute: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RoutePreferencesCopyWith<$Res> get preferences {
    return $RoutePreferencesCopyWith<$Res>(_value.preferences, (value) {
      return _then(_value.copyWith(preferences: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RouteWithWaypointsImplCopyWith<$Res>
    implements $RouteWithWaypointsCopyWith<$Res> {
  factory _$$RouteWithWaypointsImplCopyWith(_$RouteWithWaypointsImpl value,
          $Res Function(_$RouteWithWaypointsImpl) then) =
      __$$RouteWithWaypointsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LatLng start,
      LatLng destination,
      List<Waypoint> waypoints,
      RouteResult? activeRoute,
      List<RouteResult> alternativeRoutes,
      RoutePreferences preferences});

  @override
  $RouteResultCopyWith<$Res>? get activeRoute;
  @override
  $RoutePreferencesCopyWith<$Res> get preferences;
}

/// @nodoc
class __$$RouteWithWaypointsImplCopyWithImpl<$Res>
    extends _$RouteWithWaypointsCopyWithImpl<$Res, _$RouteWithWaypointsImpl>
    implements _$$RouteWithWaypointsImplCopyWith<$Res> {
  __$$RouteWithWaypointsImplCopyWithImpl(_$RouteWithWaypointsImpl _value,
      $Res Function(_$RouteWithWaypointsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? destination = null,
    Object? waypoints = null,
    Object? activeRoute = freezed,
    Object? alternativeRoutes = null,
    Object? preferences = null,
  }) {
    return _then(_$RouteWithWaypointsImpl(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as LatLng,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as LatLng,
      waypoints: null == waypoints
          ? _value._waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as List<Waypoint>,
      activeRoute: freezed == activeRoute
          ? _value.activeRoute
          : activeRoute // ignore: cast_nullable_to_non_nullable
              as RouteResult?,
      alternativeRoutes: null == alternativeRoutes
          ? _value._alternativeRoutes
          : alternativeRoutes // ignore: cast_nullable_to_non_nullable
              as List<RouteResult>,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as RoutePreferences,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteWithWaypointsImpl implements _RouteWithWaypoints {
  const _$RouteWithWaypointsImpl(
      {required this.start,
      required this.destination,
      final List<Waypoint> waypoints = const [],
      this.activeRoute,
      final List<RouteResult> alternativeRoutes = const [],
      this.preferences = const RoutePreferences()})
      : _waypoints = waypoints,
        _alternativeRoutes = alternativeRoutes;

  factory _$RouteWithWaypointsImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteWithWaypointsImplFromJson(json);

  @override
  final LatLng start;
  @override
  final LatLng destination;
  final List<Waypoint> _waypoints;
  @override
  @JsonKey()
  List<Waypoint> get waypoints {
    if (_waypoints is EqualUnmodifiableListView) return _waypoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_waypoints);
  }

  @override
  final RouteResult? activeRoute;
  final List<RouteResult> _alternativeRoutes;
  @override
  @JsonKey()
  List<RouteResult> get alternativeRoutes {
    if (_alternativeRoutes is EqualUnmodifiableListView)
      return _alternativeRoutes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alternativeRoutes);
  }

  @override
  @JsonKey()
  final RoutePreferences preferences;

  @override
  String toString() {
    return 'RouteWithWaypoints(start: $start, destination: $destination, waypoints: $waypoints, activeRoute: $activeRoute, alternativeRoutes: $alternativeRoutes, preferences: $preferences)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteWithWaypointsImpl &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            const DeepCollectionEquality()
                .equals(other._waypoints, _waypoints) &&
            (identical(other.activeRoute, activeRoute) ||
                other.activeRoute == activeRoute) &&
            const DeepCollectionEquality()
                .equals(other._alternativeRoutes, _alternativeRoutes) &&
            (identical(other.preferences, preferences) ||
                other.preferences == preferences));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      start,
      destination,
      const DeepCollectionEquality().hash(_waypoints),
      activeRoute,
      const DeepCollectionEquality().hash(_alternativeRoutes),
      preferences);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteWithWaypointsImplCopyWith<_$RouteWithWaypointsImpl> get copyWith =>
      __$$RouteWithWaypointsImplCopyWithImpl<_$RouteWithWaypointsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteWithWaypointsImplToJson(
      this,
    );
  }
}

abstract class _RouteWithWaypoints implements RouteWithWaypoints {
  const factory _RouteWithWaypoints(
      {required final LatLng start,
      required final LatLng destination,
      final List<Waypoint> waypoints,
      final RouteResult? activeRoute,
      final List<RouteResult> alternativeRoutes,
      final RoutePreferences preferences}) = _$RouteWithWaypointsImpl;

  factory _RouteWithWaypoints.fromJson(Map<String, dynamic> json) =
      _$RouteWithWaypointsImpl.fromJson;

  @override
  LatLng get start;
  @override
  LatLng get destination;
  @override
  List<Waypoint> get waypoints;
  @override
  RouteResult? get activeRoute;
  @override
  List<RouteResult> get alternativeRoutes;
  @override
  RoutePreferences get preferences;
  @override
  @JsonKey(ignore: true)
  _$$RouteWithWaypointsImplCopyWith<_$RouteWithWaypointsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
