// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'travel_plan_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TravelPlanCreationState {
  String get destination => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  double get budget => throw _privateConstructorUsedError;
  List<String> get interests => throw _privateConstructorUsedError;
  String get additionalRequirements => throw _privateConstructorUsedError;
  bool get isCreating => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TravelPlanCreationStateCopyWith<TravelPlanCreationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TravelPlanCreationStateCopyWith<$Res> {
  factory $TravelPlanCreationStateCopyWith(TravelPlanCreationState value,
          $Res Function(TravelPlanCreationState) then) =
      _$TravelPlanCreationStateCopyWithImpl<$Res, TravelPlanCreationState>;
  @useResult
  $Res call(
      {String destination,
      DateTime? startDate,
      DateTime? endDate,
      double budget,
      List<String> interests,
      String additionalRequirements,
      bool isCreating,
      String? error});
}

/// @nodoc
class _$TravelPlanCreationStateCopyWithImpl<$Res,
        $Val extends TravelPlanCreationState>
    implements $TravelPlanCreationStateCopyWith<$Res> {
  _$TravelPlanCreationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? destination = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? budget = null,
    Object? interests = null,
    Object? additionalRequirements = null,
    Object? isCreating = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as double,
      interests: null == interests
          ? _value.interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>,
      additionalRequirements: null == additionalRequirements
          ? _value.additionalRequirements
          : additionalRequirements // ignore: cast_nullable_to_non_nullable
              as String,
      isCreating: null == isCreating
          ? _value.isCreating
          : isCreating // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TravelPlanCreationStateImplCopyWith<$Res>
    implements $TravelPlanCreationStateCopyWith<$Res> {
  factory _$$TravelPlanCreationStateImplCopyWith(
          _$TravelPlanCreationStateImpl value,
          $Res Function(_$TravelPlanCreationStateImpl) then) =
      __$$TravelPlanCreationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String destination,
      DateTime? startDate,
      DateTime? endDate,
      double budget,
      List<String> interests,
      String additionalRequirements,
      bool isCreating,
      String? error});
}

/// @nodoc
class __$$TravelPlanCreationStateImplCopyWithImpl<$Res>
    extends _$TravelPlanCreationStateCopyWithImpl<$Res,
        _$TravelPlanCreationStateImpl>
    implements _$$TravelPlanCreationStateImplCopyWith<$Res> {
  __$$TravelPlanCreationStateImplCopyWithImpl(
      _$TravelPlanCreationStateImpl _value,
      $Res Function(_$TravelPlanCreationStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? destination = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? budget = null,
    Object? interests = null,
    Object? additionalRequirements = null,
    Object? isCreating = null,
    Object? error = freezed,
  }) {
    return _then(_$TravelPlanCreationStateImpl(
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as double,
      interests: null == interests
          ? _value._interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>,
      additionalRequirements: null == additionalRequirements
          ? _value.additionalRequirements
          : additionalRequirements // ignore: cast_nullable_to_non_nullable
              as String,
      isCreating: null == isCreating
          ? _value.isCreating
          : isCreating // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TravelPlanCreationStateImpl implements _TravelPlanCreationState {
  const _$TravelPlanCreationStateImpl(
      {this.destination = '',
      this.startDate,
      this.endDate,
      this.budget = 0.0,
      final List<String> interests = const [],
      this.additionalRequirements = '',
      this.isCreating = false,
      this.error})
      : _interests = interests;

  @override
  @JsonKey()
  final String destination;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  @JsonKey()
  final double budget;
  final List<String> _interests;
  @override
  @JsonKey()
  List<String> get interests {
    if (_interests is EqualUnmodifiableListView) return _interests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interests);
  }

  @override
  @JsonKey()
  final String additionalRequirements;
  @override
  @JsonKey()
  final bool isCreating;
  @override
  final String? error;

  @override
  String toString() {
    return 'TravelPlanCreationState(destination: $destination, startDate: $startDate, endDate: $endDate, budget: $budget, interests: $interests, additionalRequirements: $additionalRequirements, isCreating: $isCreating, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TravelPlanCreationStateImpl &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            const DeepCollectionEquality()
                .equals(other._interests, _interests) &&
            (identical(other.additionalRequirements, additionalRequirements) ||
                other.additionalRequirements == additionalRequirements) &&
            (identical(other.isCreating, isCreating) ||
                other.isCreating == isCreating) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      destination,
      startDate,
      endDate,
      budget,
      const DeepCollectionEquality().hash(_interests),
      additionalRequirements,
      isCreating,
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TravelPlanCreationStateImplCopyWith<_$TravelPlanCreationStateImpl>
      get copyWith => __$$TravelPlanCreationStateImplCopyWithImpl<
          _$TravelPlanCreationStateImpl>(this, _$identity);
}

abstract class _TravelPlanCreationState implements TravelPlanCreationState {
  const factory _TravelPlanCreationState(
      {final String destination,
      final DateTime? startDate,
      final DateTime? endDate,
      final double budget,
      final List<String> interests,
      final String additionalRequirements,
      final bool isCreating,
      final String? error}) = _$TravelPlanCreationStateImpl;

  @override
  String get destination;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  double get budget;
  @override
  List<String> get interests;
  @override
  String get additionalRequirements;
  @override
  bool get isCreating;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$TravelPlanCreationStateImplCopyWith<_$TravelPlanCreationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
