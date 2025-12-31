// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'offline_road_network.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RoadNode _$RoadNodeFromJson(Map<String, dynamic> json) {
  return _RoadNode.fromJson(json);
}

/// @nodoc
mixin _$RoadNode {
  String get id => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  List<String> get connectedNodeIds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoadNodeCopyWith<RoadNode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoadNodeCopyWith<$Res> {
  factory $RoadNodeCopyWith(RoadNode value, $Res Function(RoadNode) then) =
      _$RoadNodeCopyWithImpl<$Res, RoadNode>;
  @useResult
  $Res call(
      {String id,
      double latitude,
      double longitude,
      List<String> connectedNodeIds});
}

/// @nodoc
class _$RoadNodeCopyWithImpl<$Res, $Val extends RoadNode>
    implements $RoadNodeCopyWith<$Res> {
  _$RoadNodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? connectedNodeIds = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      connectedNodeIds: null == connectedNodeIds
          ? _value.connectedNodeIds
          : connectedNodeIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoadNodeImplCopyWith<$Res>
    implements $RoadNodeCopyWith<$Res> {
  factory _$$RoadNodeImplCopyWith(
          _$RoadNodeImpl value, $Res Function(_$RoadNodeImpl) then) =
      __$$RoadNodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      double latitude,
      double longitude,
      List<String> connectedNodeIds});
}

/// @nodoc
class __$$RoadNodeImplCopyWithImpl<$Res>
    extends _$RoadNodeCopyWithImpl<$Res, _$RoadNodeImpl>
    implements _$$RoadNodeImplCopyWith<$Res> {
  __$$RoadNodeImplCopyWithImpl(
      _$RoadNodeImpl _value, $Res Function(_$RoadNodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? connectedNodeIds = null,
  }) {
    return _then(_$RoadNodeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      connectedNodeIds: null == connectedNodeIds
          ? _value._connectedNodeIds
          : connectedNodeIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoadNodeImpl implements _RoadNode {
  const _$RoadNodeImpl(
      {required this.id,
      required this.latitude,
      required this.longitude,
      final List<String> connectedNodeIds = const []})
      : _connectedNodeIds = connectedNodeIds;

  factory _$RoadNodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoadNodeImplFromJson(json);

  @override
  final String id;
  @override
  final double latitude;
  @override
  final double longitude;
  final List<String> _connectedNodeIds;
  @override
  @JsonKey()
  List<String> get connectedNodeIds {
    if (_connectedNodeIds is EqualUnmodifiableListView)
      return _connectedNodeIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_connectedNodeIds);
  }

  @override
  String toString() {
    return 'RoadNode(id: $id, latitude: $latitude, longitude: $longitude, connectedNodeIds: $connectedNodeIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoadNodeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            const DeepCollectionEquality()
                .equals(other._connectedNodeIds, _connectedNodeIds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, latitude, longitude,
      const DeepCollectionEquality().hash(_connectedNodeIds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoadNodeImplCopyWith<_$RoadNodeImpl> get copyWith =>
      __$$RoadNodeImplCopyWithImpl<_$RoadNodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoadNodeImplToJson(
      this,
    );
  }
}

abstract class _RoadNode implements RoadNode {
  const factory _RoadNode(
      {required final String id,
      required final double latitude,
      required final double longitude,
      final List<String> connectedNodeIds}) = _$RoadNodeImpl;

  factory _RoadNode.fromJson(Map<String, dynamic> json) =
      _$RoadNodeImpl.fromJson;

  @override
  String get id;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  List<String> get connectedNodeIds;
  @override
  @JsonKey(ignore: true)
  _$$RoadNodeImplCopyWith<_$RoadNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RoadEdge _$RoadEdgeFromJson(Map<String, dynamic> json) {
  return _RoadEdge.fromJson(json);
}

/// @nodoc
mixin _$RoadEdge {
  String get id => throw _privateConstructorUsedError;
  String get fromNodeId => throw _privateConstructorUsedError;
  String get toNodeId => throw _privateConstructorUsedError;
  double get distanceMeters => throw _privateConstructorUsedError;
  String? get streetName => throw _privateConstructorUsedError;
  RoadType get roadType => throw _privateConstructorUsedError;
  double get speedLimitKmh => throw _privateConstructorUsedError;
  bool get isOneWay => throw _privateConstructorUsedError;
  List<LatLng> get geometry => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoadEdgeCopyWith<RoadEdge> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoadEdgeCopyWith<$Res> {
  factory $RoadEdgeCopyWith(RoadEdge value, $Res Function(RoadEdge) then) =
      _$RoadEdgeCopyWithImpl<$Res, RoadEdge>;
  @useResult
  $Res call(
      {String id,
      String fromNodeId,
      String toNodeId,
      double distanceMeters,
      String? streetName,
      RoadType roadType,
      double speedLimitKmh,
      bool isOneWay,
      List<LatLng> geometry});
}

/// @nodoc
class _$RoadEdgeCopyWithImpl<$Res, $Val extends RoadEdge>
    implements $RoadEdgeCopyWith<$Res> {
  _$RoadEdgeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fromNodeId = null,
    Object? toNodeId = null,
    Object? distanceMeters = null,
    Object? streetName = freezed,
    Object? roadType = null,
    Object? speedLimitKmh = null,
    Object? isOneWay = null,
    Object? geometry = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fromNodeId: null == fromNodeId
          ? _value.fromNodeId
          : fromNodeId // ignore: cast_nullable_to_non_nullable
              as String,
      toNodeId: null == toNodeId
          ? _value.toNodeId
          : toNodeId // ignore: cast_nullable_to_non_nullable
              as String,
      distanceMeters: null == distanceMeters
          ? _value.distanceMeters
          : distanceMeters // ignore: cast_nullable_to_non_nullable
              as double,
      streetName: freezed == streetName
          ? _value.streetName
          : streetName // ignore: cast_nullable_to_non_nullable
              as String?,
      roadType: null == roadType
          ? _value.roadType
          : roadType // ignore: cast_nullable_to_non_nullable
              as RoadType,
      speedLimitKmh: null == speedLimitKmh
          ? _value.speedLimitKmh
          : speedLimitKmh // ignore: cast_nullable_to_non_nullable
              as double,
      isOneWay: null == isOneWay
          ? _value.isOneWay
          : isOneWay // ignore: cast_nullable_to_non_nullable
              as bool,
      geometry: null == geometry
          ? _value.geometry
          : geometry // ignore: cast_nullable_to_non_nullable
              as List<LatLng>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoadEdgeImplCopyWith<$Res>
    implements $RoadEdgeCopyWith<$Res> {
  factory _$$RoadEdgeImplCopyWith(
          _$RoadEdgeImpl value, $Res Function(_$RoadEdgeImpl) then) =
      __$$RoadEdgeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String fromNodeId,
      String toNodeId,
      double distanceMeters,
      String? streetName,
      RoadType roadType,
      double speedLimitKmh,
      bool isOneWay,
      List<LatLng> geometry});
}

/// @nodoc
class __$$RoadEdgeImplCopyWithImpl<$Res>
    extends _$RoadEdgeCopyWithImpl<$Res, _$RoadEdgeImpl>
    implements _$$RoadEdgeImplCopyWith<$Res> {
  __$$RoadEdgeImplCopyWithImpl(
      _$RoadEdgeImpl _value, $Res Function(_$RoadEdgeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fromNodeId = null,
    Object? toNodeId = null,
    Object? distanceMeters = null,
    Object? streetName = freezed,
    Object? roadType = null,
    Object? speedLimitKmh = null,
    Object? isOneWay = null,
    Object? geometry = null,
  }) {
    return _then(_$RoadEdgeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fromNodeId: null == fromNodeId
          ? _value.fromNodeId
          : fromNodeId // ignore: cast_nullable_to_non_nullable
              as String,
      toNodeId: null == toNodeId
          ? _value.toNodeId
          : toNodeId // ignore: cast_nullable_to_non_nullable
              as String,
      distanceMeters: null == distanceMeters
          ? _value.distanceMeters
          : distanceMeters // ignore: cast_nullable_to_non_nullable
              as double,
      streetName: freezed == streetName
          ? _value.streetName
          : streetName // ignore: cast_nullable_to_non_nullable
              as String?,
      roadType: null == roadType
          ? _value.roadType
          : roadType // ignore: cast_nullable_to_non_nullable
              as RoadType,
      speedLimitKmh: null == speedLimitKmh
          ? _value.speedLimitKmh
          : speedLimitKmh // ignore: cast_nullable_to_non_nullable
              as double,
      isOneWay: null == isOneWay
          ? _value.isOneWay
          : isOneWay // ignore: cast_nullable_to_non_nullable
              as bool,
      geometry: null == geometry
          ? _value._geometry
          : geometry // ignore: cast_nullable_to_non_nullable
              as List<LatLng>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoadEdgeImpl implements _RoadEdge {
  const _$RoadEdgeImpl(
      {required this.id,
      required this.fromNodeId,
      required this.toNodeId,
      required this.distanceMeters,
      required this.streetName,
      required this.roadType,
      required this.speedLimitKmh,
      this.isOneWay = false,
      final List<LatLng> geometry = const []})
      : _geometry = geometry;

  factory _$RoadEdgeImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoadEdgeImplFromJson(json);

  @override
  final String id;
  @override
  final String fromNodeId;
  @override
  final String toNodeId;
  @override
  final double distanceMeters;
  @override
  final String? streetName;
  @override
  final RoadType roadType;
  @override
  final double speedLimitKmh;
  @override
  @JsonKey()
  final bool isOneWay;
  final List<LatLng> _geometry;
  @override
  @JsonKey()
  List<LatLng> get geometry {
    if (_geometry is EqualUnmodifiableListView) return _geometry;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_geometry);
  }

  @override
  String toString() {
    return 'RoadEdge(id: $id, fromNodeId: $fromNodeId, toNodeId: $toNodeId, distanceMeters: $distanceMeters, streetName: $streetName, roadType: $roadType, speedLimitKmh: $speedLimitKmh, isOneWay: $isOneWay, geometry: $geometry)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoadEdgeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fromNodeId, fromNodeId) ||
                other.fromNodeId == fromNodeId) &&
            (identical(other.toNodeId, toNodeId) ||
                other.toNodeId == toNodeId) &&
            (identical(other.distanceMeters, distanceMeters) ||
                other.distanceMeters == distanceMeters) &&
            (identical(other.streetName, streetName) ||
                other.streetName == streetName) &&
            (identical(other.roadType, roadType) ||
                other.roadType == roadType) &&
            (identical(other.speedLimitKmh, speedLimitKmh) ||
                other.speedLimitKmh == speedLimitKmh) &&
            (identical(other.isOneWay, isOneWay) ||
                other.isOneWay == isOneWay) &&
            const DeepCollectionEquality().equals(other._geometry, _geometry));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      fromNodeId,
      toNodeId,
      distanceMeters,
      streetName,
      roadType,
      speedLimitKmh,
      isOneWay,
      const DeepCollectionEquality().hash(_geometry));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoadEdgeImplCopyWith<_$RoadEdgeImpl> get copyWith =>
      __$$RoadEdgeImplCopyWithImpl<_$RoadEdgeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoadEdgeImplToJson(
      this,
    );
  }
}

abstract class _RoadEdge implements RoadEdge {
  const factory _RoadEdge(
      {required final String id,
      required final String fromNodeId,
      required final String toNodeId,
      required final double distanceMeters,
      required final String? streetName,
      required final RoadType roadType,
      required final double speedLimitKmh,
      final bool isOneWay,
      final List<LatLng> geometry}) = _$RoadEdgeImpl;

  factory _RoadEdge.fromJson(Map<String, dynamic> json) =
      _$RoadEdgeImpl.fromJson;

  @override
  String get id;
  @override
  String get fromNodeId;
  @override
  String get toNodeId;
  @override
  double get distanceMeters;
  @override
  String? get streetName;
  @override
  RoadType get roadType;
  @override
  double get speedLimitKmh;
  @override
  bool get isOneWay;
  @override
  List<LatLng> get geometry;
  @override
  @JsonKey(ignore: true)
  _$$RoadEdgeImplCopyWith<_$RoadEdgeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RoadNetwork _$RoadNetworkFromJson(Map<String, dynamic> json) {
  return _RoadNetwork.fromJson(json);
}

/// @nodoc
mixin _$RoadNetwork {
  String get regionId => throw _privateConstructorUsedError;
  String get regionName => throw _privateConstructorUsedError;
  double get minLat => throw _privateConstructorUsedError;
  double get maxLat => throw _privateConstructorUsedError;
  double get minLon => throw _privateConstructorUsedError;
  double get maxLon => throw _privateConstructorUsedError;
  Map<String, RoadNode> get nodes => throw _privateConstructorUsedError;
  Map<String, RoadEdge> get edges => throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoadNetworkCopyWith<RoadNetwork> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoadNetworkCopyWith<$Res> {
  factory $RoadNetworkCopyWith(
          RoadNetwork value, $Res Function(RoadNetwork) then) =
      _$RoadNetworkCopyWithImpl<$Res, RoadNetwork>;
  @useResult
  $Res call(
      {String regionId,
      String regionName,
      double minLat,
      double maxLat,
      double minLon,
      double maxLon,
      Map<String, RoadNode> nodes,
      Map<String, RoadEdge> edges,
      DateTime lastUpdated});
}

/// @nodoc
class _$RoadNetworkCopyWithImpl<$Res, $Val extends RoadNetwork>
    implements $RoadNetworkCopyWith<$Res> {
  _$RoadNetworkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regionId = null,
    Object? regionName = null,
    Object? minLat = null,
    Object? maxLat = null,
    Object? minLon = null,
    Object? maxLon = null,
    Object? nodes = null,
    Object? edges = null,
    Object? lastUpdated = null,
  }) {
    return _then(_value.copyWith(
      regionId: null == regionId
          ? _value.regionId
          : regionId // ignore: cast_nullable_to_non_nullable
              as String,
      regionName: null == regionName
          ? _value.regionName
          : regionName // ignore: cast_nullable_to_non_nullable
              as String,
      minLat: null == minLat
          ? _value.minLat
          : minLat // ignore: cast_nullable_to_non_nullable
              as double,
      maxLat: null == maxLat
          ? _value.maxLat
          : maxLat // ignore: cast_nullable_to_non_nullable
              as double,
      minLon: null == minLon
          ? _value.minLon
          : minLon // ignore: cast_nullable_to_non_nullable
              as double,
      maxLon: null == maxLon
          ? _value.maxLon
          : maxLon // ignore: cast_nullable_to_non_nullable
              as double,
      nodes: null == nodes
          ? _value.nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as Map<String, RoadNode>,
      edges: null == edges
          ? _value.edges
          : edges // ignore: cast_nullable_to_non_nullable
              as Map<String, RoadEdge>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoadNetworkImplCopyWith<$Res>
    implements $RoadNetworkCopyWith<$Res> {
  factory _$$RoadNetworkImplCopyWith(
          _$RoadNetworkImpl value, $Res Function(_$RoadNetworkImpl) then) =
      __$$RoadNetworkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String regionId,
      String regionName,
      double minLat,
      double maxLat,
      double minLon,
      double maxLon,
      Map<String, RoadNode> nodes,
      Map<String, RoadEdge> edges,
      DateTime lastUpdated});
}

/// @nodoc
class __$$RoadNetworkImplCopyWithImpl<$Res>
    extends _$RoadNetworkCopyWithImpl<$Res, _$RoadNetworkImpl>
    implements _$$RoadNetworkImplCopyWith<$Res> {
  __$$RoadNetworkImplCopyWithImpl(
      _$RoadNetworkImpl _value, $Res Function(_$RoadNetworkImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regionId = null,
    Object? regionName = null,
    Object? minLat = null,
    Object? maxLat = null,
    Object? minLon = null,
    Object? maxLon = null,
    Object? nodes = null,
    Object? edges = null,
    Object? lastUpdated = null,
  }) {
    return _then(_$RoadNetworkImpl(
      regionId: null == regionId
          ? _value.regionId
          : regionId // ignore: cast_nullable_to_non_nullable
              as String,
      regionName: null == regionName
          ? _value.regionName
          : regionName // ignore: cast_nullable_to_non_nullable
              as String,
      minLat: null == minLat
          ? _value.minLat
          : minLat // ignore: cast_nullable_to_non_nullable
              as double,
      maxLat: null == maxLat
          ? _value.maxLat
          : maxLat // ignore: cast_nullable_to_non_nullable
              as double,
      minLon: null == minLon
          ? _value.minLon
          : minLon // ignore: cast_nullable_to_non_nullable
              as double,
      maxLon: null == maxLon
          ? _value.maxLon
          : maxLon // ignore: cast_nullable_to_non_nullable
              as double,
      nodes: null == nodes
          ? _value._nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as Map<String, RoadNode>,
      edges: null == edges
          ? _value._edges
          : edges // ignore: cast_nullable_to_non_nullable
              as Map<String, RoadEdge>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoadNetworkImpl implements _RoadNetwork {
  const _$RoadNetworkImpl(
      {required this.regionId,
      required this.regionName,
      required this.minLat,
      required this.maxLat,
      required this.minLon,
      required this.maxLon,
      required final Map<String, RoadNode> nodes,
      required final Map<String, RoadEdge> edges,
      required this.lastUpdated})
      : _nodes = nodes,
        _edges = edges;

  factory _$RoadNetworkImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoadNetworkImplFromJson(json);

  @override
  final String regionId;
  @override
  final String regionName;
  @override
  final double minLat;
  @override
  final double maxLat;
  @override
  final double minLon;
  @override
  final double maxLon;
  final Map<String, RoadNode> _nodes;
  @override
  Map<String, RoadNode> get nodes {
    if (_nodes is EqualUnmodifiableMapView) return _nodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_nodes);
  }

  final Map<String, RoadEdge> _edges;
  @override
  Map<String, RoadEdge> get edges {
    if (_edges is EqualUnmodifiableMapView) return _edges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_edges);
  }

  @override
  final DateTime lastUpdated;

  @override
  String toString() {
    return 'RoadNetwork(regionId: $regionId, regionName: $regionName, minLat: $minLat, maxLat: $maxLat, minLon: $minLon, maxLon: $maxLon, nodes: $nodes, edges: $edges, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoadNetworkImpl &&
            (identical(other.regionId, regionId) ||
                other.regionId == regionId) &&
            (identical(other.regionName, regionName) ||
                other.regionName == regionName) &&
            (identical(other.minLat, minLat) || other.minLat == minLat) &&
            (identical(other.maxLat, maxLat) || other.maxLat == maxLat) &&
            (identical(other.minLon, minLon) || other.minLon == minLon) &&
            (identical(other.maxLon, maxLon) || other.maxLon == maxLon) &&
            const DeepCollectionEquality().equals(other._nodes, _nodes) &&
            const DeepCollectionEquality().equals(other._edges, _edges) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      regionId,
      regionName,
      minLat,
      maxLat,
      minLon,
      maxLon,
      const DeepCollectionEquality().hash(_nodes),
      const DeepCollectionEquality().hash(_edges),
      lastUpdated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoadNetworkImplCopyWith<_$RoadNetworkImpl> get copyWith =>
      __$$RoadNetworkImplCopyWithImpl<_$RoadNetworkImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoadNetworkImplToJson(
      this,
    );
  }
}

abstract class _RoadNetwork implements RoadNetwork {
  const factory _RoadNetwork(
      {required final String regionId,
      required final String regionName,
      required final double minLat,
      required final double maxLat,
      required final double minLon,
      required final double maxLon,
      required final Map<String, RoadNode> nodes,
      required final Map<String, RoadEdge> edges,
      required final DateTime lastUpdated}) = _$RoadNetworkImpl;

  factory _RoadNetwork.fromJson(Map<String, dynamic> json) =
      _$RoadNetworkImpl.fromJson;

  @override
  String get regionId;
  @override
  String get regionName;
  @override
  double get minLat;
  @override
  double get maxLat;
  @override
  double get minLon;
  @override
  double get maxLon;
  @override
  Map<String, RoadNode> get nodes;
  @override
  Map<String, RoadEdge> get edges;
  @override
  DateTime get lastUpdated;
  @override
  @JsonKey(ignore: true)
  _$$RoadNetworkImplCopyWith<_$RoadNetworkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
