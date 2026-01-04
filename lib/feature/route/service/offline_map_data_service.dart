import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import '../model/offline_road_network.dart';

class OfflineMapDataService {
  static final Logger _logger = Logger();
  final http.Client _client;

  OfflineMapDataService({http.Client? client}) : _client = client ?? http.Client();

  Future<RoadNetwork> downloadRegionData({
    required String regionName,
    required double minLat,
    required double maxLat,
    required double minLon,
    required double maxLon,
  }) async {
    _logger.i('Downloading road data for $regionName...');

    final overpassQuery = _buildOverpassQuery(minLat, maxLat, minLon, maxLon);

    final url = Uri.parse('https://overpass-api.de/api/interpreter');

    try {
      final response = await _client.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'data': overpassQuery},
      ).timeout(const Duration(minutes: 2));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final network = _parseOSMData(data, regionName, minLat, maxLat, minLon, maxLon);

        await _saveNetworkToFile(network);

        _logger.i('Downloaded ${network.nodes.length} nodes and ${network.edges.length} edges for $regionName');
        return network;
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      _logger.e('Error downloading region data: $e');
      rethrow;
    }
  }

  String _buildOverpassQuery(double minLat, double maxLat, double minLon, double maxLon) {
    return '''
[out:json][timeout:120];
(
  way["highway"]["highway"!="footway"]["highway"!="path"]["highway"!="cycleway"]["highway"!="steps"]
    ($minLat,$minLon,$maxLat,$maxLon);
);
out body;
>;
out skel qt;
''';
  }

  RoadNetwork _parseOSMData(
    Map<String, dynamic> data,
    String regionName,
    double minLat,
    double maxLat,
    double minLon,
    double maxLon,
  ) {
    final elements = data['elements'] as List;

    final osmNodes = <String, Map<String, dynamic>>{};
    final ways = <Map<String, dynamic>>[];

    for (final element in elements) {
      if (element['type'] == 'node') {
        osmNodes[element['id'].toString()] = element;
      } else if (element['type'] == 'way') {
        ways.add(element);
      }
    }

    final roadNodes = <String, RoadNode>{};
    final roadEdges = <String, RoadEdge>{};
    final nodeConnections = <String, Set<String>>{};

    for (final way in ways) {
      final wayId = way['id'].toString();
      final tags = way['tags'] as Map<String, dynamic>? ?? {};
      final nodeIds = (way['nodes'] as List).map((id) => id.toString()).toList();

      if (nodeIds.length < 2) continue;

      final highway = tags['highway'] as String?;
      if (highway == null) continue;

      final roadType = _parseRoadType(highway);
      final speedLimit = _getSpeedLimit(roadType);
      final streetName = tags['name'] as String?;
      final isOneWay = tags['oneway'] == 'yes';

      for (int i = 0; i < nodeIds.length - 1; i++) {
        final fromNodeId = nodeIds[i];
        final toNodeId = nodeIds[i + 1];

        final fromOSM = osmNodes[fromNodeId];
        final toOSM = osmNodes[toNodeId];

        if (fromOSM == null || toOSM == null) continue;

        if (!roadNodes.containsKey(fromNodeId)) {
          roadNodes[fromNodeId] = RoadNode(
            id: fromNodeId,
            latitude: fromOSM['lat'].toDouble(),
            longitude: fromOSM['lon'].toDouble(),
          );
          nodeConnections[fromNodeId] = {};
        }

        if (!roadNodes.containsKey(toNodeId)) {
          roadNodes[toNodeId] = RoadNode(
            id: toNodeId,
            latitude: toOSM['lat'].toDouble(),
            longitude: toOSM['lon'].toDouble(),
          );
          nodeConnections[toNodeId] = {};
        }

        final fromLatLng = LatLng(fromOSM['lat'].toDouble(), fromOSM['lon'].toDouble());
        final toLatLng = LatLng(toOSM['lat'].toDouble(), toOSM['lon'].toDouble());
        final distance = const Distance()(fromLatLng, toLatLng);

        final geometry = <LatLng>[];
        for (int j = i; j <= i + 1 && j < nodeIds.length; j++) {
          final nodeId = nodeIds[j];
          final osmNode = osmNodes[nodeId];
          if (osmNode != null) {
            geometry.add(LatLng(osmNode['lat'].toDouble(), osmNode['lon'].toDouble()));
          }
        }

        final edgeId = '${wayId}_${i}';
        roadEdges[edgeId] = RoadEdge(
          id: edgeId,
          fromNodeId: fromNodeId,
          toNodeId: toNodeId,
          distanceMeters: distance,
          streetName: streetName,
          roadType: roadType,
          speedLimitKmh: speedLimit,
          isOneWay: isOneWay,
          geometry: geometry,
        );

        nodeConnections[fromNodeId]!.add(toNodeId);
        if (!isOneWay) {
          nodeConnections[toNodeId]!.add(fromNodeId);
        }
      }
    }

    final finalNodes = <String, RoadNode>{};
    for (final entry in roadNodes.entries) {
      finalNodes[entry.key] = entry.value.copyWith(
        connectedNodeIds: nodeConnections[entry.key]?.toList() ?? [],
      );
    }

    return RoadNetwork(
      regionId: _generateRegionId(minLat, maxLat, minLon, maxLon),
      regionName: regionName,
      minLat: minLat,
      maxLat: maxLat,
      minLon: minLon,
      maxLon: maxLon,
      nodes: finalNodes,
      edges: roadEdges,
      lastUpdated: DateTime.now(),
    );
  }

  RoadType _parseRoadType(String highway) {
    switch (highway) {
      case 'motorway':
        return RoadType.motorway;
      case 'trunk':
        return RoadType.trunk;
      case 'primary':
        return RoadType.primary;
      case 'secondary':
        return RoadType.secondary;
      case 'tertiary':
        return RoadType.tertiary;
      case 'residential':
        return RoadType.residential;
      case 'service':
        return RoadType.service;
      default:
        return RoadType.unclassified;
    }
  }

  double _getSpeedLimit(RoadType roadType) {
    switch (roadType) {
      case RoadType.motorway:
        return 120.0;
      case RoadType.trunk:
        return 100.0;
      case RoadType.primary:
        return 80.0;
      case RoadType.secondary:
        return 60.0;
      case RoadType.tertiary:
        return 50.0;
      case RoadType.residential:
        return 40.0;
      case RoadType.service:
        return 20.0;
      case RoadType.unclassified:
        return 50.0;
    }
  }

  String _generateRegionId(double minLat, double maxLat, double minLon, double maxLon) {
    return 'region_${minLat.toStringAsFixed(2)}_${maxLat.toStringAsFixed(2)}_${minLon.toStringAsFixed(2)}_${maxLon.toStringAsFixed(2)}';
  }

  Future<void> _saveNetworkToFile(RoadNetwork network) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/offline_maps/${network.regionId}.json');

      await file.parent.create(recursive: true);

      final jsonData = json.encode(network.toJson());
      await file.writeAsString(jsonData);

      _logger.i('Saved network to ${file.path}');
    } catch (e) {
      _logger.e('Error saving network: $e');
    }
  }

  Future<RoadNetwork?> loadNetworkFromFile(String regionId) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/offline_maps/$regionId.json');

      if (!await file.exists()) {
        _logger.w('Network file not found: $regionId');
        return null;
      }

      final jsonData = await file.readAsString();
      final data = json.decode(jsonData);

      final network = RoadNetwork.fromJson(data);
      _logger.i('Loaded network: ${network.regionName} with ${network.nodes.length} nodes');

      return network;
    } catch (e) {
      _logger.e('Error loading network: $e');
      return null;
    }
  }

  Future<List<String>> listAvailableRegions() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final offlineMapsDir = Directory('${dir.path}/offline_maps');

      if (!await offlineMapsDir.exists()) {
        return [];
      }

      final files = await offlineMapsDir.list().toList();
      return files
          .where((f) => f.path.endsWith('.json'))
          .map((f) => f.path.split('/').last.replaceAll('.json', ''))
          .toList();
    } catch (e) {
      _logger.e('Error listing regions: $e');
      return [];
    }
  }

  Future<void> deleteRegion(String regionId) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/offline_maps/$regionId.json');

      if (await file.exists()) {
        await file.delete();
        _logger.i('Deleted region: $regionId');
      }
    } catch (e) {
      _logger.e('Error deleting region: $e');
    }
  }

  Future<RoadNetwork> createSampleNetwork() async {
    _logger.i('Creating sample road network for Dubai...');

    final nodes = <String, RoadNode>{
      '1': const RoadNode(
        id: '1',
        latitude: 25.2048,
        longitude: 55.2708,
        connectedNodeIds: ['2'],
      ),
      '2': const RoadNode(
        id: '2',
        latitude: 25.2050,
        longitude: 55.2715,
        connectedNodeIds: ['1', '3'],
      ),
      '3': const RoadNode(
        id: '3',
        latitude: 25.2045,
        longitude: 55.2720,
        connectedNodeIds: ['2', '4'],
      ),
      '4': const RoadNode(
        id: '4',
        latitude: 25.2040,
        longitude: 55.2728,
        connectedNodeIds: ['3', '5'],
      ),
      '5': const RoadNode(
        id: '5',
        latitude: 25.2000,
        longitude: 55.2735,
        connectedNodeIds: ['4', '6'],
      ),
      '6': const RoadNode(
        id: '6',
        latitude: 25.1985,
        longitude: 55.2740,
        connectedNodeIds: ['5', '7'],
      ),
      '7': const RoadNode(
        id: '7',
        latitude: 25.1972,
        longitude: 55.2744,
        connectedNodeIds: ['6'],
      ),
    };

    final edges = <String, RoadEdge>{
      'e1': RoadEdge(
        id: 'e1',
        fromNodeId: '1',
        toNodeId: '2',
        distanceMeters: const Distance()(
          const LatLng(25.2048, 55.2708),
          const LatLng(25.2050, 55.2715),
        ),
        streetName: 'Sheikh Zayed Road',
        roadType: RoadType.primary,
        speedLimitKmh: 80,
        geometry: const [
          LatLng(25.2048, 55.2708),
          LatLng(25.2050, 55.2715),
        ],
      ),
      'e2': RoadEdge(
        id: 'e2',
        fromNodeId: '2',
        toNodeId: '3',
        distanceMeters: const Distance()(
          const LatLng(25.2050, 55.2715),
          const LatLng(25.2045, 55.2720),
        ),
        streetName: 'Sheikh Zayed Road',
        roadType: RoadType.primary,
        speedLimitKmh: 80,
        geometry: const [
          LatLng(25.2050, 55.2715),
          LatLng(25.2045, 55.2720),
        ],
      ),
      'e3': RoadEdge(
        id: 'e3',
        fromNodeId: '3',
        toNodeId: '4',
        distanceMeters: const Distance()(
          const LatLng(25.2045, 55.2720),
          const LatLng(25.2040, 55.2728),
        ),
        streetName: 'Sheikh Zayed Road',
        roadType: RoadType.primary,
        speedLimitKmh: 80,
        geometry: const [
          LatLng(25.2045, 55.2720),
          LatLng(25.2040, 55.2728),
        ],
      ),
      'e4': RoadEdge(
        id: 'e4',
        fromNodeId: '4',
        toNodeId: '5',
        distanceMeters: const Distance()(
          const LatLng(25.2040, 55.2728),
          const LatLng(25.2000, 55.2735),
        ),
        streetName: 'Financial Centre Road',
        roadType: RoadType.secondary,
        speedLimitKmh: 60,
        geometry: const [
          LatLng(25.2040, 55.2728),
          LatLng(25.2000, 55.2735),
        ],
      ),
      'e5': RoadEdge(
        id: 'e5',
        fromNodeId: '5',
        toNodeId: '6',
        distanceMeters: const Distance()(
          const LatLng(25.2000, 55.2735),
          const LatLng(25.1985, 55.2740),
        ),
        streetName: 'Financial Centre Road',
        roadType: RoadType.secondary,
        speedLimitKmh: 60,
        geometry: const [
          LatLng(25.2000, 55.2735),
          LatLng(25.1985, 55.2740),
        ],
      ),
      'e6': RoadEdge(
        id: 'e6',
        fromNodeId: '6',
        toNodeId: '7',
        distanceMeters: const Distance()(
          const LatLng(25.1985, 55.2740),
          const LatLng(25.1972, 55.2744),
        ),
        streetName: 'Mohammed Bin Rashid Boulevard',
        roadType: RoadType.tertiary,
        speedLimitKmh: 50,
        geometry: const [
          LatLng(25.1985, 55.2740),
          LatLng(25.1972, 55.2744),
        ],
      ),
    };

    final network = RoadNetwork(
      regionId: 'dubai_sample',
      regionName: 'Dubai Sample Network',
      minLat: 25.1970,
      maxLat: 25.2050,
      minLon: 55.2700,
      maxLon: 55.2750,
      nodes: nodes,
      edges: edges,
      lastUpdated: DateTime.now(),
    );

    await _saveNetworkToFile(network);

    return network;
  }

  void dispose() {
    _client.close();
  }
}
