// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TravelPlan _$TravelPlanFromJson(Map<String, dynamic> json) {
  return _TravelPlan.fromJson(json);
}

/// @nodoc
mixin _$TravelPlan {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get destination => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  List<DayPlan> get days => throw _privateConstructorUsedError;
  double get budget => throw _privateConstructorUsedError;
  List<String> get interests => throw _privateConstructorUsedError;
  List<String> get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TravelPlanCopyWith<TravelPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TravelPlanCopyWith<$Res> {
  factory $TravelPlanCopyWith(
          TravelPlan value, $Res Function(TravelPlan) then) =
      _$TravelPlanCopyWithImpl<$Res, TravelPlan>;
  @useResult
  $Res call(
      {String id,
      String title,
      String destination,
      DateTime startDate,
      DateTime endDate,
      List<DayPlan> days,
      double budget,
      List<String> interests,
      List<String> notes,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$TravelPlanCopyWithImpl<$Res, $Val extends TravelPlan>
    implements $TravelPlanCopyWith<$Res> {
  _$TravelPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? destination = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? days = null,
    Object? budget = null,
    Object? interests = null,
    Object? notes = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      days: null == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as List<DayPlan>,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as double,
      interests: null == interests
          ? _value.interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TravelPlanImplCopyWith<$Res>
    implements $TravelPlanCopyWith<$Res> {
  factory _$$TravelPlanImplCopyWith(
          _$TravelPlanImpl value, $Res Function(_$TravelPlanImpl) then) =
      __$$TravelPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String destination,
      DateTime startDate,
      DateTime endDate,
      List<DayPlan> days,
      double budget,
      List<String> interests,
      List<String> notes,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$TravelPlanImplCopyWithImpl<$Res>
    extends _$TravelPlanCopyWithImpl<$Res, _$TravelPlanImpl>
    implements _$$TravelPlanImplCopyWith<$Res> {
  __$$TravelPlanImplCopyWithImpl(
      _$TravelPlanImpl _value, $Res Function(_$TravelPlanImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? destination = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? days = null,
    Object? budget = null,
    Object? interests = null,
    Object? notes = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$TravelPlanImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      days: null == days
          ? _value._days
          : days // ignore: cast_nullable_to_non_nullable
              as List<DayPlan>,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as double,
      interests: null == interests
          ? _value._interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: null == notes
          ? _value._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TravelPlanImpl with DiagnosticableTreeMixin implements _TravelPlan {
  const _$TravelPlanImpl(
      {required this.id,
      required this.title,
      required this.destination,
      required this.startDate,
      required this.endDate,
      required final List<DayPlan> days,
      required this.budget,
      required final List<String> interests,
      final List<String> notes = const [],
      required this.createdAt,
      this.updatedAt})
      : _days = days,
        _interests = interests,
        _notes = notes;

  factory _$TravelPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$TravelPlanImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String destination;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  final List<DayPlan> _days;
  @override
  List<DayPlan> get days {
    if (_days is EqualUnmodifiableListView) return _days;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_days);
  }

  @override
  final double budget;
  final List<String> _interests;
  @override
  List<String> get interests {
    if (_interests is EqualUnmodifiableListView) return _interests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interests);
  }

  final List<String> _notes;
  @override
  @JsonKey()
  List<String> get notes {
    if (_notes is EqualUnmodifiableListView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notes);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TravelPlan(id: $id, title: $title, destination: $destination, startDate: $startDate, endDate: $endDate, days: $days, budget: $budget, interests: $interests, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TravelPlan'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('destination', destination))
      ..add(DiagnosticsProperty('startDate', startDate))
      ..add(DiagnosticsProperty('endDate', endDate))
      ..add(DiagnosticsProperty('days', days))
      ..add(DiagnosticsProperty('budget', budget))
      ..add(DiagnosticsProperty('interests', interests))
      ..add(DiagnosticsProperty('notes', notes))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TravelPlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality().equals(other._days, _days) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            const DeepCollectionEquality()
                .equals(other._interests, _interests) &&
            const DeepCollectionEquality().equals(other._notes, _notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      destination,
      startDate,
      endDate,
      const DeepCollectionEquality().hash(_days),
      budget,
      const DeepCollectionEquality().hash(_interests),
      const DeepCollectionEquality().hash(_notes),
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TravelPlanImplCopyWith<_$TravelPlanImpl> get copyWith =>
      __$$TravelPlanImplCopyWithImpl<_$TravelPlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TravelPlanImplToJson(
      this,
    );
  }
}

abstract class _TravelPlan implements TravelPlan {
  const factory _TravelPlan(
      {required final String id,
      required final String title,
      required final String destination,
      required final DateTime startDate,
      required final DateTime endDate,
      required final List<DayPlan> days,
      required final double budget,
      required final List<String> interests,
      final List<String> notes,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$TravelPlanImpl;

  factory _TravelPlan.fromJson(Map<String, dynamic> json) =
      _$TravelPlanImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get destination;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  List<DayPlan> get days;
  @override
  double get budget;
  @override
  List<String> get interests;
  @override
  List<String> get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$TravelPlanImplCopyWith<_$TravelPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DayPlan _$DayPlanFromJson(Map<String, dynamic> json) {
  return _DayPlan.fromJson(json);
}

/// @nodoc
mixin _$DayPlan {
  int get dayNumber => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  List<Activity> get activities => throw _privateConstructorUsedError;
  String get overview => throw _privateConstructorUsedError;
  double get estimatedCost => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DayPlanCopyWith<DayPlan> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DayPlanCopyWith<$Res> {
  factory $DayPlanCopyWith(DayPlan value, $Res Function(DayPlan) then) =
      _$DayPlanCopyWithImpl<$Res, DayPlan>;
  @useResult
  $Res call(
      {int dayNumber,
      DateTime date,
      List<Activity> activities,
      String overview,
      double estimatedCost});
}

/// @nodoc
class _$DayPlanCopyWithImpl<$Res, $Val extends DayPlan>
    implements $DayPlanCopyWith<$Res> {
  _$DayPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dayNumber = null,
    Object? date = null,
    Object? activities = null,
    Object? overview = null,
    Object? estimatedCost = null,
  }) {
    return _then(_value.copyWith(
      dayNumber: null == dayNumber
          ? _value.dayNumber
          : dayNumber // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      activities: null == activities
          ? _value.activities
          : activities // ignore: cast_nullable_to_non_nullable
              as List<Activity>,
      overview: null == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedCost: null == estimatedCost
          ? _value.estimatedCost
          : estimatedCost // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DayPlanImplCopyWith<$Res> implements $DayPlanCopyWith<$Res> {
  factory _$$DayPlanImplCopyWith(
          _$DayPlanImpl value, $Res Function(_$DayPlanImpl) then) =
      __$$DayPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int dayNumber,
      DateTime date,
      List<Activity> activities,
      String overview,
      double estimatedCost});
}

/// @nodoc
class __$$DayPlanImplCopyWithImpl<$Res>
    extends _$DayPlanCopyWithImpl<$Res, _$DayPlanImpl>
    implements _$$DayPlanImplCopyWith<$Res> {
  __$$DayPlanImplCopyWithImpl(
      _$DayPlanImpl _value, $Res Function(_$DayPlanImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dayNumber = null,
    Object? date = null,
    Object? activities = null,
    Object? overview = null,
    Object? estimatedCost = null,
  }) {
    return _then(_$DayPlanImpl(
      dayNumber: null == dayNumber
          ? _value.dayNumber
          : dayNumber // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      activities: null == activities
          ? _value._activities
          : activities // ignore: cast_nullable_to_non_nullable
              as List<Activity>,
      overview: null == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedCost: null == estimatedCost
          ? _value.estimatedCost
          : estimatedCost // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DayPlanImpl with DiagnosticableTreeMixin implements _DayPlan {
  const _$DayPlanImpl(
      {required this.dayNumber,
      required this.date,
      required final List<Activity> activities,
      required this.overview,
      this.estimatedCost = 0.0})
      : _activities = activities;

  factory _$DayPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$DayPlanImplFromJson(json);

  @override
  final int dayNumber;
  @override
  final DateTime date;
  final List<Activity> _activities;
  @override
  List<Activity> get activities {
    if (_activities is EqualUnmodifiableListView) return _activities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activities);
  }

  @override
  final String overview;
  @override
  @JsonKey()
  final double estimatedCost;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DayPlan(dayNumber: $dayNumber, date: $date, activities: $activities, overview: $overview, estimatedCost: $estimatedCost)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DayPlan'))
      ..add(DiagnosticsProperty('dayNumber', dayNumber))
      ..add(DiagnosticsProperty('date', date))
      ..add(DiagnosticsProperty('activities', activities))
      ..add(DiagnosticsProperty('overview', overview))
      ..add(DiagnosticsProperty('estimatedCost', estimatedCost));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DayPlanImpl &&
            (identical(other.dayNumber, dayNumber) ||
                other.dayNumber == dayNumber) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality()
                .equals(other._activities, _activities) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.estimatedCost, estimatedCost) ||
                other.estimatedCost == estimatedCost));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      dayNumber,
      date,
      const DeepCollectionEquality().hash(_activities),
      overview,
      estimatedCost);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DayPlanImplCopyWith<_$DayPlanImpl> get copyWith =>
      __$$DayPlanImplCopyWithImpl<_$DayPlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DayPlanImplToJson(
      this,
    );
  }
}

abstract class _DayPlan implements DayPlan {
  const factory _DayPlan(
      {required final int dayNumber,
      required final DateTime date,
      required final List<Activity> activities,
      required final String overview,
      final double estimatedCost}) = _$DayPlanImpl;

  factory _DayPlan.fromJson(Map<String, dynamic> json) = _$DayPlanImpl.fromJson;

  @override
  int get dayNumber;
  @override
  DateTime get date;
  @override
  List<Activity> get activities;
  @override
  String get overview;
  @override
  double get estimatedCost;
  @override
  @JsonKey(ignore: true)
  _$$DayPlanImplCopyWith<_$DayPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return _Activity.fromJson(json);
}

/// @nodoc
mixin _$Activity {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  TimeSlot get timeSlot => throw _privateConstructorUsedError;
  ActivityType get type => throw _privateConstructorUsedError;
  double get cost => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  List<String> get tips => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ActivityCopyWith<Activity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityCopyWith<$Res> {
  factory $ActivityCopyWith(Activity value, $Res Function(Activity) then) =
      _$ActivityCopyWithImpl<$Res, Activity>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String location,
      TimeSlot timeSlot,
      ActivityType type,
      double cost,
      double latitude,
      double longitude,
      List<String> tips});

  $TimeSlotCopyWith<$Res> get timeSlot;
}

/// @nodoc
class _$ActivityCopyWithImpl<$Res, $Val extends Activity>
    implements $ActivityCopyWith<$Res> {
  _$ActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? location = null,
    Object? timeSlot = null,
    Object? type = null,
    Object? cost = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? tips = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      timeSlot: null == timeSlot
          ? _value.timeSlot
          : timeSlot // ignore: cast_nullable_to_non_nullable
              as TimeSlot,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ActivityType,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      tips: null == tips
          ? _value.tips
          : tips // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TimeSlotCopyWith<$Res> get timeSlot {
    return $TimeSlotCopyWith<$Res>(_value.timeSlot, (value) {
      return _then(_value.copyWith(timeSlot: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ActivityImplCopyWith<$Res>
    implements $ActivityCopyWith<$Res> {
  factory _$$ActivityImplCopyWith(
          _$ActivityImpl value, $Res Function(_$ActivityImpl) then) =
      __$$ActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String location,
      TimeSlot timeSlot,
      ActivityType type,
      double cost,
      double latitude,
      double longitude,
      List<String> tips});

  @override
  $TimeSlotCopyWith<$Res> get timeSlot;
}

/// @nodoc
class __$$ActivityImplCopyWithImpl<$Res>
    extends _$ActivityCopyWithImpl<$Res, _$ActivityImpl>
    implements _$$ActivityImplCopyWith<$Res> {
  __$$ActivityImplCopyWithImpl(
      _$ActivityImpl _value, $Res Function(_$ActivityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? location = null,
    Object? timeSlot = null,
    Object? type = null,
    Object? cost = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? tips = null,
  }) {
    return _then(_$ActivityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      timeSlot: null == timeSlot
          ? _value.timeSlot
          : timeSlot // ignore: cast_nullable_to_non_nullable
              as TimeSlot,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ActivityType,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      tips: null == tips
          ? _value._tips
          : tips // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityImpl with DiagnosticableTreeMixin implements _Activity {
  const _$ActivityImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.location,
      required this.timeSlot,
      required this.type,
      this.cost = 0.0,
      this.latitude = 0.0,
      this.longitude = 0.0,
      final List<String> tips = const []})
      : _tips = tips;

  factory _$ActivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String location;
  @override
  final TimeSlot timeSlot;
  @override
  final ActivityType type;
  @override
  @JsonKey()
  final double cost;
  @override
  @JsonKey()
  final double latitude;
  @override
  @JsonKey()
  final double longitude;
  final List<String> _tips;
  @override
  @JsonKey()
  List<String> get tips {
    if (_tips is EqualUnmodifiableListView) return _tips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tips);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Activity(id: $id, title: $title, description: $description, location: $location, timeSlot: $timeSlot, type: $type, cost: $cost, latitude: $latitude, longitude: $longitude, tips: $tips)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Activity'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('location', location))
      ..add(DiagnosticsProperty('timeSlot', timeSlot))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('cost', cost))
      ..add(DiagnosticsProperty('latitude', latitude))
      ..add(DiagnosticsProperty('longitude', longitude))
      ..add(DiagnosticsProperty('tips', tips));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.timeSlot, timeSlot) ||
                other.timeSlot == timeSlot) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            const DeepCollectionEquality().equals(other._tips, _tips));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      location,
      timeSlot,
      type,
      cost,
      latitude,
      longitude,
      const DeepCollectionEquality().hash(_tips));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityImplCopyWith<_$ActivityImpl> get copyWith =>
      __$$ActivityImplCopyWithImpl<_$ActivityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityImplToJson(
      this,
    );
  }
}

abstract class _Activity implements Activity {
  const factory _Activity(
      {required final String id,
      required final String title,
      required final String description,
      required final String location,
      required final TimeSlot timeSlot,
      required final ActivityType type,
      final double cost,
      final double latitude,
      final double longitude,
      final List<String> tips}) = _$ActivityImpl;

  factory _Activity.fromJson(Map<String, dynamic> json) =
      _$ActivityImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get location;
  @override
  TimeSlot get timeSlot;
  @override
  ActivityType get type;
  @override
  double get cost;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  List<String> get tips;
  @override
  @JsonKey(ignore: true)
  _$$ActivityImplCopyWith<_$ActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TimeSlot _$TimeSlotFromJson(Map<String, dynamic> json) {
  return _TimeSlot.fromJson(json);
}

/// @nodoc
mixin _$TimeSlot {
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimeSlotCopyWith<TimeSlot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeSlotCopyWith<$Res> {
  factory $TimeSlotCopyWith(TimeSlot value, $Res Function(TimeSlot) then) =
      _$TimeSlotCopyWithImpl<$Res, TimeSlot>;
  @useResult
  $Res call({DateTime startTime, DateTime endTime});
}

/// @nodoc
class _$TimeSlotCopyWithImpl<$Res, $Val extends TimeSlot>
    implements $TimeSlotCopyWith<$Res> {
  _$TimeSlotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_value.copyWith(
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeSlotImplCopyWith<$Res>
    implements $TimeSlotCopyWith<$Res> {
  factory _$$TimeSlotImplCopyWith(
          _$TimeSlotImpl value, $Res Function(_$TimeSlotImpl) then) =
      __$$TimeSlotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime startTime, DateTime endTime});
}

/// @nodoc
class __$$TimeSlotImplCopyWithImpl<$Res>
    extends _$TimeSlotCopyWithImpl<$Res, _$TimeSlotImpl>
    implements _$$TimeSlotImplCopyWith<$Res> {
  __$$TimeSlotImplCopyWithImpl(
      _$TimeSlotImpl _value, $Res Function(_$TimeSlotImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_$TimeSlotImpl(
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeSlotImpl with DiagnosticableTreeMixin implements _TimeSlot {
  const _$TimeSlotImpl({required this.startTime, required this.endTime});

  factory _$TimeSlotImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeSlotImplFromJson(json);

  @override
  final DateTime startTime;
  @override
  final DateTime endTime;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TimeSlot(startTime: $startTime, endTime: $endTime)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TimeSlot'))
      ..add(DiagnosticsProperty('startTime', startTime))
      ..add(DiagnosticsProperty('endTime', endTime));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeSlotImpl &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, startTime, endTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeSlotImplCopyWith<_$TimeSlotImpl> get copyWith =>
      __$$TimeSlotImplCopyWithImpl<_$TimeSlotImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeSlotImplToJson(
      this,
    );
  }
}

abstract class _TimeSlot implements TimeSlot {
  const factory _TimeSlot(
      {required final DateTime startTime,
      required final DateTime endTime}) = _$TimeSlotImpl;

  factory _TimeSlot.fromJson(Map<String, dynamic> json) =
      _$TimeSlotImpl.fromJson;

  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  @JsonKey(ignore: true)
  _$$TimeSlotImplCopyWith<_$TimeSlotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return _ChatMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatMessage {
  String get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  bool get isUser => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  MessageType get type => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatMessageCopyWith<ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageCopyWith<$Res> {
  factory $ChatMessageCopyWith(
          ChatMessage value, $Res Function(ChatMessage) then) =
      _$ChatMessageCopyWithImpl<$Res, ChatMessage>;
  @useResult
  $Res call(
      {String id,
      String content,
      bool isUser,
      DateTime timestamp,
      MessageType type,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$ChatMessageCopyWithImpl<$Res, $Val extends ChatMessage>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? isUser = null,
    Object? timestamp = null,
    Object? type = null,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      isUser: null == isUser
          ? _value.isUser
          : isUser // ignore: cast_nullable_to_non_nullable
              as bool,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatMessageImplCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$$ChatMessageImplCopyWith(
          _$ChatMessageImpl value, $Res Function(_$ChatMessageImpl) then) =
      __$$ChatMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String content,
      bool isUser,
      DateTime timestamp,
      MessageType type,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$ChatMessageImplCopyWithImpl<$Res>
    extends _$ChatMessageCopyWithImpl<$Res, _$ChatMessageImpl>
    implements _$$ChatMessageImplCopyWith<$Res> {
  __$$ChatMessageImplCopyWithImpl(
      _$ChatMessageImpl _value, $Res Function(_$ChatMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? isUser = null,
    Object? timestamp = null,
    Object? type = null,
    Object? metadata = freezed,
  }) {
    return _then(_$ChatMessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      isUser: null == isUser
          ? _value.isUser
          : isUser // ignore: cast_nullable_to_non_nullable
              as bool,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageImpl with DiagnosticableTreeMixin implements _ChatMessage {
  const _$ChatMessageImpl(
      {required this.id,
      required this.content,
      required this.isUser,
      required this.timestamp,
      this.type = MessageType.text,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$ChatMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageImplFromJson(json);

  @override
  final String id;
  @override
  final String content;
  @override
  final bool isUser;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final MessageType type;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatMessage(id: $id, content: $content, isUser: $isUser, timestamp: $timestamp, type: $type, metadata: $metadata)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatMessage'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('isUser', isUser))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('metadata', metadata));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isUser, isUser) || other.isUser == isUser) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, content, isUser, timestamp,
      type, const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      __$$ChatMessageImplCopyWithImpl<_$ChatMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageImplToJson(
      this,
    );
  }
}

abstract class _ChatMessage implements ChatMessage {
  const factory _ChatMessage(
      {required final String id,
      required final String content,
      required final bool isUser,
      required final DateTime timestamp,
      final MessageType type,
      final Map<String, dynamic>? metadata}) = _$ChatMessageImpl;

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$ChatMessageImpl.fromJson;

  @override
  String get id;
  @override
  String get content;
  @override
  bool get isUser;
  @override
  DateTime get timestamp;
  @override
  MessageType get type;
  @override
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LocationData _$LocationDataFromJson(Map<String, dynamic> json) {
  return _LocationData.fromJson(json);
}

/// @nodoc
mixin _$LocationData {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationDataCopyWith<LocationData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationDataCopyWith<$Res> {
  factory $LocationDataCopyWith(
          LocationData value, $Res Function(LocationData) then) =
      _$LocationDataCopyWithImpl<$Res, LocationData>;
  @useResult
  $Res call(
      {double latitude,
      double longitude,
      String address,
      String? city,
      String? country,
      DateTime? timestamp});
}

/// @nodoc
class _$LocationDataCopyWithImpl<$Res, $Val extends LocationData>
    implements $LocationDataCopyWith<$Res> {
  _$LocationDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? address = null,
    Object? city = freezed,
    Object? country = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationDataImplCopyWith<$Res>
    implements $LocationDataCopyWith<$Res> {
  factory _$$LocationDataImplCopyWith(
          _$LocationDataImpl value, $Res Function(_$LocationDataImpl) then) =
      __$$LocationDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double latitude,
      double longitude,
      String address,
      String? city,
      String? country,
      DateTime? timestamp});
}

/// @nodoc
class __$$LocationDataImplCopyWithImpl<$Res>
    extends _$LocationDataCopyWithImpl<$Res, _$LocationDataImpl>
    implements _$$LocationDataImplCopyWith<$Res> {
  __$$LocationDataImplCopyWithImpl(
      _$LocationDataImpl _value, $Res Function(_$LocationDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? address = null,
    Object? city = freezed,
    Object? country = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_$LocationDataImpl(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationDataImpl with DiagnosticableTreeMixin implements _LocationData {
  const _$LocationDataImpl(
      {required this.latitude,
      required this.longitude,
      required this.address,
      this.city,
      this.country,
      this.timestamp});

  factory _$LocationDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationDataImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String address;
  @override
  final String? city;
  @override
  final String? country;
  @override
  final DateTime? timestamp;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LocationData(latitude: $latitude, longitude: $longitude, address: $address, city: $city, country: $country, timestamp: $timestamp)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LocationData'))
      ..add(DiagnosticsProperty('latitude', latitude))
      ..add(DiagnosticsProperty('longitude', longitude))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('city', city))
      ..add(DiagnosticsProperty('country', country))
      ..add(DiagnosticsProperty('timestamp', timestamp));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationDataImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, latitude, longitude, address, city, country, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationDataImplCopyWith<_$LocationDataImpl> get copyWith =>
      __$$LocationDataImplCopyWithImpl<_$LocationDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationDataImplToJson(
      this,
    );
  }
}

abstract class _LocationData implements LocationData {
  const factory _LocationData(
      {required final double latitude,
      required final double longitude,
      required final String address,
      final String? city,
      final String? country,
      final DateTime? timestamp}) = _$LocationDataImpl;

  factory _LocationData.fromJson(Map<String, dynamic> json) =
      _$LocationDataImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get address;
  @override
  String? get city;
  @override
  String? get country;
  @override
  DateTime? get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$LocationDataImplCopyWith<_$LocationDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LLMState {
  bool get isInitialized => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isGenerating => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  String? get modelPath => throw _privateConstructorUsedError;
  double get initializationProgress => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LLMStateCopyWith<LLMState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LLMStateCopyWith<$Res> {
  factory $LLMStateCopyWith(LLMState value, $Res Function(LLMState) then) =
      _$LLMStateCopyWithImpl<$Res, LLMState>;
  @useResult
  $Res call(
      {bool isInitialized,
      bool isLoading,
      bool isGenerating,
      String? error,
      String? modelPath,
      double initializationProgress});
}

/// @nodoc
class _$LLMStateCopyWithImpl<$Res, $Val extends LLMState>
    implements $LLMStateCopyWith<$Res> {
  _$LLMStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isInitialized = null,
    Object? isLoading = null,
    Object? isGenerating = null,
    Object? error = freezed,
    Object? modelPath = freezed,
    Object? initializationProgress = null,
  }) {
    return _then(_value.copyWith(
      isInitialized: null == isInitialized
          ? _value.isInitialized
          : isInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isGenerating: null == isGenerating
          ? _value.isGenerating
          : isGenerating // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      modelPath: freezed == modelPath
          ? _value.modelPath
          : modelPath // ignore: cast_nullable_to_non_nullable
              as String?,
      initializationProgress: null == initializationProgress
          ? _value.initializationProgress
          : initializationProgress // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LLMStateImplCopyWith<$Res>
    implements $LLMStateCopyWith<$Res> {
  factory _$$LLMStateImplCopyWith(
          _$LLMStateImpl value, $Res Function(_$LLMStateImpl) then) =
      __$$LLMStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isInitialized,
      bool isLoading,
      bool isGenerating,
      String? error,
      String? modelPath,
      double initializationProgress});
}

/// @nodoc
class __$$LLMStateImplCopyWithImpl<$Res>
    extends _$LLMStateCopyWithImpl<$Res, _$LLMStateImpl>
    implements _$$LLMStateImplCopyWith<$Res> {
  __$$LLMStateImplCopyWithImpl(
      _$LLMStateImpl _value, $Res Function(_$LLMStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isInitialized = null,
    Object? isLoading = null,
    Object? isGenerating = null,
    Object? error = freezed,
    Object? modelPath = freezed,
    Object? initializationProgress = null,
  }) {
    return _then(_$LLMStateImpl(
      isInitialized: null == isInitialized
          ? _value.isInitialized
          : isInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isGenerating: null == isGenerating
          ? _value.isGenerating
          : isGenerating // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      modelPath: freezed == modelPath
          ? _value.modelPath
          : modelPath // ignore: cast_nullable_to_non_nullable
              as String?,
      initializationProgress: null == initializationProgress
          ? _value.initializationProgress
          : initializationProgress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$LLMStateImpl with DiagnosticableTreeMixin implements _LLMState {
  const _$LLMStateImpl(
      {this.isInitialized = false,
      this.isLoading = false,
      this.isGenerating = false,
      this.error,
      this.modelPath,
      this.initializationProgress = 0.0});

  @override
  @JsonKey()
  final bool isInitialized;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isGenerating;
  @override
  final String? error;
  @override
  final String? modelPath;
  @override
  @JsonKey()
  final double initializationProgress;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LLMState(isInitialized: $isInitialized, isLoading: $isLoading, isGenerating: $isGenerating, error: $error, modelPath: $modelPath, initializationProgress: $initializationProgress)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LLMState'))
      ..add(DiagnosticsProperty('isInitialized', isInitialized))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isGenerating', isGenerating))
      ..add(DiagnosticsProperty('error', error))
      ..add(DiagnosticsProperty('modelPath', modelPath))
      ..add(DiagnosticsProperty(
          'initializationProgress', initializationProgress));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LLMStateImpl &&
            (identical(other.isInitialized, isInitialized) ||
                other.isInitialized == isInitialized) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isGenerating, isGenerating) ||
                other.isGenerating == isGenerating) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.modelPath, modelPath) ||
                other.modelPath == modelPath) &&
            (identical(other.initializationProgress, initializationProgress) ||
                other.initializationProgress == initializationProgress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isInitialized, isLoading,
      isGenerating, error, modelPath, initializationProgress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LLMStateImplCopyWith<_$LLMStateImpl> get copyWith =>
      __$$LLMStateImplCopyWithImpl<_$LLMStateImpl>(this, _$identity);
}

abstract class _LLMState implements LLMState {
  const factory _LLMState(
      {final bool isInitialized,
      final bool isLoading,
      final bool isGenerating,
      final String? error,
      final String? modelPath,
      final double initializationProgress}) = _$LLMStateImpl;

  @override
  bool get isInitialized;
  @override
  bool get isLoading;
  @override
  bool get isGenerating;
  @override
  String? get error;
  @override
  String? get modelPath;
  @override
  double get initializationProgress;
  @override
  @JsonKey(ignore: true)
  _$$LLMStateImplCopyWith<_$LLMStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AppError {
  String get message => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  dynamic get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppErrorCopyWith<AppError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppErrorCopyWith<$Res> {
  factory $AppErrorCopyWith(AppError value, $Res Function(AppError) then) =
      _$AppErrorCopyWithImpl<$Res, AppError>;
  @useResult
  $Res call({String message, String? code, dynamic data});
}

/// @nodoc
class _$AppErrorCopyWithImpl<$Res, $Val extends AppError>
    implements $AppErrorCopyWith<$Res> {
  _$AppErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? code = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppErrorImplCopyWith<$Res>
    implements $AppErrorCopyWith<$Res> {
  factory _$$AppErrorImplCopyWith(
          _$AppErrorImpl value, $Res Function(_$AppErrorImpl) then) =
      __$$AppErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? code, dynamic data});
}

/// @nodoc
class __$$AppErrorImplCopyWithImpl<$Res>
    extends _$AppErrorCopyWithImpl<$Res, _$AppErrorImpl>
    implements _$$AppErrorImplCopyWith<$Res> {
  __$$AppErrorImplCopyWithImpl(
      _$AppErrorImpl _value, $Res Function(_$AppErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? code = freezed,
    Object? data = freezed,
  }) {
    return _then(_$AppErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$AppErrorImpl with DiagnosticableTreeMixin implements _AppError {
  const _$AppErrorImpl({required this.message, this.code, this.data});

  @override
  final String message;
  @override
  final String? code;
  @override
  final dynamic data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppError(message: $message, code: $code, data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppError'))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, code, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppErrorImplCopyWith<_$AppErrorImpl> get copyWith =>
      __$$AppErrorImplCopyWithImpl<_$AppErrorImpl>(this, _$identity);
}

abstract class _AppError implements AppError {
  const factory _AppError(
      {required final String message,
      final String? code,
      final dynamic data}) = _$AppErrorImpl;

  @override
  String get message;
  @override
  String? get code;
  @override
  dynamic get data;
  @override
  @JsonKey(ignore: true)
  _$$AppErrorImplCopyWith<_$AppErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
