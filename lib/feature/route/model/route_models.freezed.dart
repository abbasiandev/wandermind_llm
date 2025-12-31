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
  List<NavigationStep> get steps => throw _privateConstructorUsedError;

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
      String? name,
      List<NavigationStep> steps});
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
    Object? steps = null,
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
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<NavigationStep>,
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
      String? name,
      List<NavigationStep> steps});
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
    Object? steps = null,
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
      steps: null == steps
          ? _value._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<NavigationStep>,
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
      this.name,
      final List<NavigationStep> steps = const []})
      : _points = points,
        _steps = steps;

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
  final List<NavigationStep> _steps;
  @override
  @JsonKey()
  List<NavigationStep> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  @override
  String toString() {
    return 'RouteResult(points: $points, distanceMeters: $distanceMeters, durationSeconds: $durationSeconds, type: $type, name: $name, steps: $steps)';
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
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._steps, _steps));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_points),
      distanceMeters,
      durationSeconds,
      type,
      name,
      const DeepCollectionEquality().hash(_steps));

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
      final String? name,
      final List<NavigationStep> steps}) = _$RouteResultImpl;

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
  List<NavigationStep> get steps;
  @override
  @JsonKey(ignore: true)
  _$$RouteResultImplCopyWith<_$RouteResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NavigationStep _$NavigationStepFromJson(Map<String, dynamic> json) {
  return _NavigationStep.fromJson(json);
}

/// @nodoc
mixin _$NavigationStep {
  int get index => throw _privateConstructorUsedError;
  LatLng get location => throw _privateConstructorUsedError;
  double get distanceMeters => throw _privateConstructorUsedError;
  double get durationSeconds => throw _privateConstructorUsedError;
  String get instruction => throw _privateConstructorUsedError;
  ManeuverType get maneuver => throw _privateConstructorUsedError;
  String? get streetName => throw _privateConstructorUsedError;
  String? get destination => throw _privateConstructorUsedError;
  int? get exitNumber => throw _privateConstructorUsedError;
  double get bearing => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NavigationStepCopyWith<NavigationStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavigationStepCopyWith<$Res> {
  factory $NavigationStepCopyWith(
          NavigationStep value, $Res Function(NavigationStep) then) =
      _$NavigationStepCopyWithImpl<$Res, NavigationStep>;
  @useResult
  $Res call(
      {int index,
      LatLng location,
      double distanceMeters,
      double durationSeconds,
      String instruction,
      ManeuverType maneuver,
      String? streetName,
      String? destination,
      int? exitNumber,
      double bearing});
}

/// @nodoc
class _$NavigationStepCopyWithImpl<$Res, $Val extends NavigationStep>
    implements $NavigationStepCopyWith<$Res> {
  _$NavigationStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? location = null,
    Object? distanceMeters = null,
    Object? durationSeconds = null,
    Object? instruction = null,
    Object? maneuver = null,
    Object? streetName = freezed,
    Object? destination = freezed,
    Object? exitNumber = freezed,
    Object? bearing = null,
  }) {
    return _then(_value.copyWith(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLng,
      distanceMeters: null == distanceMeters
          ? _value.distanceMeters
          : distanceMeters // ignore: cast_nullable_to_non_nullable
              as double,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as double,
      instruction: null == instruction
          ? _value.instruction
          : instruction // ignore: cast_nullable_to_non_nullable
              as String,
      maneuver: null == maneuver
          ? _value.maneuver
          : maneuver // ignore: cast_nullable_to_non_nullable
              as ManeuverType,
      streetName: freezed == streetName
          ? _value.streetName
          : streetName // ignore: cast_nullable_to_non_nullable
              as String?,
      destination: freezed == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String?,
      exitNumber: freezed == exitNumber
          ? _value.exitNumber
          : exitNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      bearing: null == bearing
          ? _value.bearing
          : bearing // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NavigationStepImplCopyWith<$Res>
    implements $NavigationStepCopyWith<$Res> {
  factory _$$NavigationStepImplCopyWith(_$NavigationStepImpl value,
          $Res Function(_$NavigationStepImpl) then) =
      __$$NavigationStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int index,
      LatLng location,
      double distanceMeters,
      double durationSeconds,
      String instruction,
      ManeuverType maneuver,
      String? streetName,
      String? destination,
      int? exitNumber,
      double bearing});
}

/// @nodoc
class __$$NavigationStepImplCopyWithImpl<$Res>
    extends _$NavigationStepCopyWithImpl<$Res, _$NavigationStepImpl>
    implements _$$NavigationStepImplCopyWith<$Res> {
  __$$NavigationStepImplCopyWithImpl(
      _$NavigationStepImpl _value, $Res Function(_$NavigationStepImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? location = null,
    Object? distanceMeters = null,
    Object? durationSeconds = null,
    Object? instruction = null,
    Object? maneuver = null,
    Object? streetName = freezed,
    Object? destination = freezed,
    Object? exitNumber = freezed,
    Object? bearing = null,
  }) {
    return _then(_$NavigationStepImpl(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLng,
      distanceMeters: null == distanceMeters
          ? _value.distanceMeters
          : distanceMeters // ignore: cast_nullable_to_non_nullable
              as double,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as double,
      instruction: null == instruction
          ? _value.instruction
          : instruction // ignore: cast_nullable_to_non_nullable
              as String,
      maneuver: null == maneuver
          ? _value.maneuver
          : maneuver // ignore: cast_nullable_to_non_nullable
              as ManeuverType,
      streetName: freezed == streetName
          ? _value.streetName
          : streetName // ignore: cast_nullable_to_non_nullable
              as String?,
      destination: freezed == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String?,
      exitNumber: freezed == exitNumber
          ? _value.exitNumber
          : exitNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      bearing: null == bearing
          ? _value.bearing
          : bearing // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NavigationStepImpl implements _NavigationStep {
  const _$NavigationStepImpl(
      {required this.index,
      required this.location,
      required this.distanceMeters,
      required this.durationSeconds,
      required this.instruction,
      required this.maneuver,
      this.streetName,
      this.destination,
      this.exitNumber,
      this.bearing = 0.0});

  factory _$NavigationStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$NavigationStepImplFromJson(json);

  @override
  final int index;
  @override
  final LatLng location;
  @override
  final double distanceMeters;
  @override
  final double durationSeconds;
  @override
  final String instruction;
  @override
  final ManeuverType maneuver;
  @override
  final String? streetName;
  @override
  final String? destination;
  @override
  final int? exitNumber;
  @override
  @JsonKey()
  final double bearing;

  @override
  String toString() {
    return 'NavigationStep(index: $index, location: $location, distanceMeters: $distanceMeters, durationSeconds: $durationSeconds, instruction: $instruction, maneuver: $maneuver, streetName: $streetName, destination: $destination, exitNumber: $exitNumber, bearing: $bearing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NavigationStepImpl &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.distanceMeters, distanceMeters) ||
                other.distanceMeters == distanceMeters) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.instruction, instruction) ||
                other.instruction == instruction) &&
            (identical(other.maneuver, maneuver) ||
                other.maneuver == maneuver) &&
            (identical(other.streetName, streetName) ||
                other.streetName == streetName) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.exitNumber, exitNumber) ||
                other.exitNumber == exitNumber) &&
            (identical(other.bearing, bearing) || other.bearing == bearing));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      index,
      location,
      distanceMeters,
      durationSeconds,
      instruction,
      maneuver,
      streetName,
      destination,
      exitNumber,
      bearing);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NavigationStepImplCopyWith<_$NavigationStepImpl> get copyWith =>
      __$$NavigationStepImplCopyWithImpl<_$NavigationStepImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NavigationStepImplToJson(
      this,
    );
  }
}

abstract class _NavigationStep implements NavigationStep {
  const factory _NavigationStep(
      {required final int index,
      required final LatLng location,
      required final double distanceMeters,
      required final double durationSeconds,
      required final String instruction,
      required final ManeuverType maneuver,
      final String? streetName,
      final String? destination,
      final int? exitNumber,
      final double bearing}) = _$NavigationStepImpl;

  factory _NavigationStep.fromJson(Map<String, dynamic> json) =
      _$NavigationStepImpl.fromJson;

  @override
  int get index;
  @override
  LatLng get location;
  @override
  double get distanceMeters;
  @override
  double get durationSeconds;
  @override
  String get instruction;
  @override
  ManeuverType get maneuver;
  @override
  String? get streetName;
  @override
  String? get destination;
  @override
  int? get exitNumber;
  @override
  double get bearing;
  @override
  @JsonKey(ignore: true)
  _$$NavigationStepImplCopyWith<_$NavigationStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NavigationState _$NavigationStateFromJson(Map<String, dynamic> json) {
  return _NavigationState.fromJson(json);
}

/// @nodoc
mixin _$NavigationState {
  bool get isNavigating => throw _privateConstructorUsedError;
  NavigationStep? get currentStep => throw _privateConstructorUsedError;
  NavigationStep? get nextStep => throw _privateConstructorUsedError;
  int get currentStepIndex => throw _privateConstructorUsedError;
  double get distanceToNextStep => throw _privateConstructorUsedError;
  double get totalDistanceRemaining => throw _privateConstructorUsedError;
  double get totalDurationRemaining => throw _privateConstructorUsedError;
  bool get isOffRoute => throw _privateConstructorUsedError;
  bool get isRerouting => throw _privateConstructorUsedError;
  DateTime? get lastUpdateTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NavigationStateCopyWith<NavigationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavigationStateCopyWith<$Res> {
  factory $NavigationStateCopyWith(
          NavigationState value, $Res Function(NavigationState) then) =
      _$NavigationStateCopyWithImpl<$Res, NavigationState>;
  @useResult
  $Res call(
      {bool isNavigating,
      NavigationStep? currentStep,
      NavigationStep? nextStep,
      int currentStepIndex,
      double distanceToNextStep,
      double totalDistanceRemaining,
      double totalDurationRemaining,
      bool isOffRoute,
      bool isRerouting,
      DateTime? lastUpdateTime});

  $NavigationStepCopyWith<$Res>? get currentStep;
  $NavigationStepCopyWith<$Res>? get nextStep;
}

/// @nodoc
class _$NavigationStateCopyWithImpl<$Res, $Val extends NavigationState>
    implements $NavigationStateCopyWith<$Res> {
  _$NavigationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isNavigating = null,
    Object? currentStep = freezed,
    Object? nextStep = freezed,
    Object? currentStepIndex = null,
    Object? distanceToNextStep = null,
    Object? totalDistanceRemaining = null,
    Object? totalDurationRemaining = null,
    Object? isOffRoute = null,
    Object? isRerouting = null,
    Object? lastUpdateTime = freezed,
  }) {
    return _then(_value.copyWith(
      isNavigating: null == isNavigating
          ? _value.isNavigating
          : isNavigating // ignore: cast_nullable_to_non_nullable
              as bool,
      currentStep: freezed == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as NavigationStep?,
      nextStep: freezed == nextStep
          ? _value.nextStep
          : nextStep // ignore: cast_nullable_to_non_nullable
              as NavigationStep?,
      currentStepIndex: null == currentStepIndex
          ? _value.currentStepIndex
          : currentStepIndex // ignore: cast_nullable_to_non_nullable
              as int,
      distanceToNextStep: null == distanceToNextStep
          ? _value.distanceToNextStep
          : distanceToNextStep // ignore: cast_nullable_to_non_nullable
              as double,
      totalDistanceRemaining: null == totalDistanceRemaining
          ? _value.totalDistanceRemaining
          : totalDistanceRemaining // ignore: cast_nullable_to_non_nullable
              as double,
      totalDurationRemaining: null == totalDurationRemaining
          ? _value.totalDurationRemaining
          : totalDurationRemaining // ignore: cast_nullable_to_non_nullable
              as double,
      isOffRoute: null == isOffRoute
          ? _value.isOffRoute
          : isOffRoute // ignore: cast_nullable_to_non_nullable
              as bool,
      isRerouting: null == isRerouting
          ? _value.isRerouting
          : isRerouting // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdateTime: freezed == lastUpdateTime
          ? _value.lastUpdateTime
          : lastUpdateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NavigationStepCopyWith<$Res>? get currentStep {
    if (_value.currentStep == null) {
      return null;
    }

    return $NavigationStepCopyWith<$Res>(_value.currentStep!, (value) {
      return _then(_value.copyWith(currentStep: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NavigationStepCopyWith<$Res>? get nextStep {
    if (_value.nextStep == null) {
      return null;
    }

    return $NavigationStepCopyWith<$Res>(_value.nextStep!, (value) {
      return _then(_value.copyWith(nextStep: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NavigationStateImplCopyWith<$Res>
    implements $NavigationStateCopyWith<$Res> {
  factory _$$NavigationStateImplCopyWith(_$NavigationStateImpl value,
          $Res Function(_$NavigationStateImpl) then) =
      __$$NavigationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isNavigating,
      NavigationStep? currentStep,
      NavigationStep? nextStep,
      int currentStepIndex,
      double distanceToNextStep,
      double totalDistanceRemaining,
      double totalDurationRemaining,
      bool isOffRoute,
      bool isRerouting,
      DateTime? lastUpdateTime});

  @override
  $NavigationStepCopyWith<$Res>? get currentStep;
  @override
  $NavigationStepCopyWith<$Res>? get nextStep;
}

/// @nodoc
class __$$NavigationStateImplCopyWithImpl<$Res>
    extends _$NavigationStateCopyWithImpl<$Res, _$NavigationStateImpl>
    implements _$$NavigationStateImplCopyWith<$Res> {
  __$$NavigationStateImplCopyWithImpl(
      _$NavigationStateImpl _value, $Res Function(_$NavigationStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isNavigating = null,
    Object? currentStep = freezed,
    Object? nextStep = freezed,
    Object? currentStepIndex = null,
    Object? distanceToNextStep = null,
    Object? totalDistanceRemaining = null,
    Object? totalDurationRemaining = null,
    Object? isOffRoute = null,
    Object? isRerouting = null,
    Object? lastUpdateTime = freezed,
  }) {
    return _then(_$NavigationStateImpl(
      isNavigating: null == isNavigating
          ? _value.isNavigating
          : isNavigating // ignore: cast_nullable_to_non_nullable
              as bool,
      currentStep: freezed == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as NavigationStep?,
      nextStep: freezed == nextStep
          ? _value.nextStep
          : nextStep // ignore: cast_nullable_to_non_nullable
              as NavigationStep?,
      currentStepIndex: null == currentStepIndex
          ? _value.currentStepIndex
          : currentStepIndex // ignore: cast_nullable_to_non_nullable
              as int,
      distanceToNextStep: null == distanceToNextStep
          ? _value.distanceToNextStep
          : distanceToNextStep // ignore: cast_nullable_to_non_nullable
              as double,
      totalDistanceRemaining: null == totalDistanceRemaining
          ? _value.totalDistanceRemaining
          : totalDistanceRemaining // ignore: cast_nullable_to_non_nullable
              as double,
      totalDurationRemaining: null == totalDurationRemaining
          ? _value.totalDurationRemaining
          : totalDurationRemaining // ignore: cast_nullable_to_non_nullable
              as double,
      isOffRoute: null == isOffRoute
          ? _value.isOffRoute
          : isOffRoute // ignore: cast_nullable_to_non_nullable
              as bool,
      isRerouting: null == isRerouting
          ? _value.isRerouting
          : isRerouting // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdateTime: freezed == lastUpdateTime
          ? _value.lastUpdateTime
          : lastUpdateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NavigationStateImpl implements _NavigationState {
  const _$NavigationStateImpl(
      {required this.isNavigating,
      this.currentStep,
      this.nextStep,
      this.currentStepIndex = 0,
      this.distanceToNextStep = 0.0,
      this.totalDistanceRemaining = 0.0,
      this.totalDurationRemaining = 0.0,
      this.isOffRoute = false,
      this.isRerouting = false,
      this.lastUpdateTime});

  factory _$NavigationStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$NavigationStateImplFromJson(json);

  @override
  final bool isNavigating;
  @override
  final NavigationStep? currentStep;
  @override
  final NavigationStep? nextStep;
  @override
  @JsonKey()
  final int currentStepIndex;
  @override
  @JsonKey()
  final double distanceToNextStep;
  @override
  @JsonKey()
  final double totalDistanceRemaining;
  @override
  @JsonKey()
  final double totalDurationRemaining;
  @override
  @JsonKey()
  final bool isOffRoute;
  @override
  @JsonKey()
  final bool isRerouting;
  @override
  final DateTime? lastUpdateTime;

  @override
  String toString() {
    return 'NavigationState(isNavigating: $isNavigating, currentStep: $currentStep, nextStep: $nextStep, currentStepIndex: $currentStepIndex, distanceToNextStep: $distanceToNextStep, totalDistanceRemaining: $totalDistanceRemaining, totalDurationRemaining: $totalDurationRemaining, isOffRoute: $isOffRoute, isRerouting: $isRerouting, lastUpdateTime: $lastUpdateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NavigationStateImpl &&
            (identical(other.isNavigating, isNavigating) ||
                other.isNavigating == isNavigating) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.nextStep, nextStep) ||
                other.nextStep == nextStep) &&
            (identical(other.currentStepIndex, currentStepIndex) ||
                other.currentStepIndex == currentStepIndex) &&
            (identical(other.distanceToNextStep, distanceToNextStep) ||
                other.distanceToNextStep == distanceToNextStep) &&
            (identical(other.totalDistanceRemaining, totalDistanceRemaining) ||
                other.totalDistanceRemaining == totalDistanceRemaining) &&
            (identical(other.totalDurationRemaining, totalDurationRemaining) ||
                other.totalDurationRemaining == totalDurationRemaining) &&
            (identical(other.isOffRoute, isOffRoute) ||
                other.isOffRoute == isOffRoute) &&
            (identical(other.isRerouting, isRerouting) ||
                other.isRerouting == isRerouting) &&
            (identical(other.lastUpdateTime, lastUpdateTime) ||
                other.lastUpdateTime == lastUpdateTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isNavigating,
      currentStep,
      nextStep,
      currentStepIndex,
      distanceToNextStep,
      totalDistanceRemaining,
      totalDurationRemaining,
      isOffRoute,
      isRerouting,
      lastUpdateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NavigationStateImplCopyWith<_$NavigationStateImpl> get copyWith =>
      __$$NavigationStateImplCopyWithImpl<_$NavigationStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NavigationStateImplToJson(
      this,
    );
  }
}

abstract class _NavigationState implements NavigationState {
  const factory _NavigationState(
      {required final bool isNavigating,
      final NavigationStep? currentStep,
      final NavigationStep? nextStep,
      final int currentStepIndex,
      final double distanceToNextStep,
      final double totalDistanceRemaining,
      final double totalDurationRemaining,
      final bool isOffRoute,
      final bool isRerouting,
      final DateTime? lastUpdateTime}) = _$NavigationStateImpl;

  factory _NavigationState.fromJson(Map<String, dynamic> json) =
      _$NavigationStateImpl.fromJson;

  @override
  bool get isNavigating;
  @override
  NavigationStep? get currentStep;
  @override
  NavigationStep? get nextStep;
  @override
  int get currentStepIndex;
  @override
  double get distanceToNextStep;
  @override
  double get totalDistanceRemaining;
  @override
  double get totalDurationRemaining;
  @override
  bool get isOffRoute;
  @override
  bool get isRerouting;
  @override
  DateTime? get lastUpdateTime;
  @override
  @JsonKey(ignore: true)
  _$$NavigationStateImplCopyWith<_$NavigationStateImpl> get copyWith =>
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
