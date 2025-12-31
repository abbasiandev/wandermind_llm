import 'dart:math' as math;
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';

import '../model/scenic_route_preferences.dart';
import 'smart_routing_service.dart';

class ScenicRoutingTester {
  static final Logger _logger = Logger();

  static Future<void> runAllTests() async {
    _logger.i('\n🧪 STARTING SCENIC ROUTING TESTS\n');

    await testDirectMode();
    await testBalancedMode();
    await testScenicMode();
    await testExplorationMode();
    await testSpiralMode();

    _logger.i('\n✅ ALL TESTS COMPLETE\n');
  }

  static Future<void> testDirectMode() async {
    _logger.i('=' * 80);
    _logger.i('TEST 1: DIRECT MODE 🎯');
    _logger.i('=' * 80);

    final service = SmartRoutingService();
    await service.initialize();

    final start = LatLng(25.2048, 55.2708);
    final end = LatLng(25.1972, 55.2744);

    _logger.i('Start: Dubai Marina ($start)');
    _logger.i('End: Dubai Mall ($end)');
    _logger.i('Mode: Direct (fastest route)');

    try {
      final route = await service.getScenicRoute(
        start: start,
        end: end,
        preferences: const ScenicRoutePreferences(
          mode: ScenicMode.direct,
        ),
      );

      if (route != null) {
        _printRouteResults(route, 'Direct');
      } else {
        _logger.e('❌ No route found');
      }
    } catch (e) {
      _logger.e('❌ Error: $e');
    }

    service.dispose();
    _logger.i('');
  }

  static Future<void> testBalancedMode() async {
    _logger.i('=' * 80);
    _logger.i('TEST 2: BALANCED MODE ⚖️');
    _logger.i('=' * 80);

    final service = SmartRoutingService();
    await service.initialize();

    final start = LatLng(25.2048, 55.2708);
    final end = LatLng(25.1972, 55.2744);

    _logger.i('Start: Dubai Marina ($start)');
    _logger.i('End: Dubai Mall ($end)');
    _logger.i('Mode: Balanced (speed + scenery)');

    try {
      final route = await service.getScenicRoute(
        start: start,
        end: end,
        preferences: const ScenicRoutePreferences(
          mode: ScenicMode.balanced,
        ),
      );

      if (route != null) {
        _printRouteResults(route, 'Balanced');
      } else {
        _logger.e('❌ No route found');
      }
    } catch (e) {
      _logger.e('❌ Error: $e');
    }

    service.dispose();
    _logger.i('');
  }

  static Future<void> testScenicMode() async {
    _logger.i('=' * 80);
    _logger.i('TEST 3: SCENIC MODE 🏞️');
    _logger.i('=' * 80);

    final service = SmartRoutingService();
    await service.initialize();

    final start = LatLng(25.2048, 55.2708);
    final end = LatLng(25.1972, 55.2744);

    _logger.i('Start: Dubai Marina ($start)');
    _logger.i('End: Dubai Mall ($end)');
    _logger.i('Mode: Scenic (beautiful streets)');

    try {
      final route = await service.getScenicRoute(
        start: start,
        end: end,
        preferences: const ScenicRoutePreferences(
          mode: ScenicMode.scenic,
        ),
      );

      if (route != null) {
        _printRouteResults(route, 'Scenic');
      } else {
        _logger.e('❌ No route found');
      }
    } catch (e) {
      _logger.e('❌ Error: $e');
    }

    service.dispose();
    _logger.i('');
  }

  static Future<void> testExplorationMode() async {
    _logger.i('=' * 80);
    _logger.i('TEST 4: EXPLORATION MODE 🗺️');
    _logger.i('=' * 80);

    final service = SmartRoutingService();
    await service.initialize();

    final start = LatLng(25.2048, 55.2708);
    final end = LatLng(25.1972, 55.2744);

    _logger.i('Start: Dubai Marina ($start)');
    _logger.i('End: Dubai Mall ($end)');
    _logger.i('Mode: Exploration (discover areas)');

    try {
      final route = await service.getScenicRoute(
        start: start,
        end: end,
        preferences: const ScenicRoutePreferences(
          mode: ScenicMode.exploration,
        ),
      );

      if (route != null) {
        _printRouteResults(route, 'Exploration');
      } else {
        _logger.e('❌ No route found');
      }
    } catch (e) {
      _logger.e('❌ Error: $e');
    }

    service.dispose();
    _logger.i('');
  }

  static Future<void> testSpiralMode() async {
    _logger.i('=' * 80);
    _logger.i('TEST 5: SPIRAL MODE 🌀 (MAIN TEST)');
    _logger.i('=' * 80);

    final service = SmartRoutingService();
    await service.initialize();

    final start = LatLng(25.2048, 55.2708);
    final end = LatLng(25.1972, 55.2744);

    _logger.i('Start: Dubai Marina ($start)');
    _logger.i('End: Dubai Mall ($end)');
    _logger.i('Mode: Spiral (winding exploration path)');
    _logger.i('Expected: Route spirals around center point');

    try {
      final route = await service.getScenicRoute(
        start: start,
        end: end,
        preferences: const ScenicRoutePreferences(
          mode: ScenicMode.spiral,
          maxDetourMultiplier: 3.0,
          avoidHighways: true,
          preferLocalStreets: true,
          exploreSideStreets: true,
        ),
      );

      if (route != null) {
        _printRouteResults(route, 'Spiral');
        _analyzeSpiralPattern(route, start, end);
      } else {
        _logger.e('❌ No route found');
      }
    } catch (e) {
      _logger.e('❌ Error: $e');
    }

    service.dispose();
    _logger.i('');
  }

  static void _printRouteResults(dynamic route, String modeName) {
    _logger.i('');
    _logger.i('✅ SUCCESS! Route calculated:');
    _logger.i('');
    _logger.i('📊 ROUTE STATISTICS:');
    _logger.i('   Name: ${route.name}');
    _logger.i('   Points: ${route.points.length}');
    _logger.i('   Steps: ${route.steps.length}');
    _logger.i('   Distance: ${(route.distanceMeters / 1000).toStringAsFixed(2)} km');
    _logger.i('   Duration: ${(route.durationSeconds / 60).toStringAsFixed(0)} minutes');

    final directDistance = const Distance()(
      route.points.first,
      route.points.last,
    );
    final detourRatio = route.distanceMeters / directDistance;
    _logger.i('   Direct distance: ${(directDistance / 1000).toStringAsFixed(2)} km');
    _logger.i('   Detour ratio: ${detourRatio.toStringAsFixed(2)}x');

    if (route.points.length > 2) {
      _logger.i('');
      _logger.i('✅ GOOD: Route follows streets (${route.points.length} waypoints)');
    } else {
      _logger.w('⚠️  WARNING: Route only has ${route.points.length} points');
    }

    if (route.points.length >= 5) {
      _logger.i('');
      _logger.i('📍 FIRST 5 WAYPOINTS:');
      for (int i = 0; i < 5 && i < route.points.length; i++) {
        final point = route.points[i];
        _logger.i('   ${i + 1}. ${point.latitude.toStringAsFixed(6)}, ${point.longitude.toStringAsFixed(6)}');
      }
    }

    if (modeName == 'Spiral' && route.points.length > 10) {
      _logger.i('');
      _logger.i('📍 MIDDLE WAYPOINTS (showing spiral pattern):');
      final mid = route.points.length ~/ 2;
      for (int i = mid - 2; i <= mid + 2 && i < route.points.length; i++) {
        if (i >= 0) {
          final point = route.points[i];
          _logger.i('   ${i + 1}. ${point.latitude.toStringAsFixed(6)}, ${point.longitude.toStringAsFixed(6)}');
        }
      }
    }
  }

  static void _analyzeSpiralPattern(dynamic route, LatLng start, LatLng end) {
    _logger.i('');
    _logger.i('🌀 SPIRAL PATTERN ANALYSIS:');

    final centerLat = (start.latitude + end.latitude) / 2;
    final centerLon = (start.longitude + end.longitude) / 2;
    final center = LatLng(centerLat, centerLon);

    _logger.i('   Center point: ${center.latitude.toStringAsFixed(6)}, ${center.longitude.toStringAsFixed(6)}');

    final distances = <double>[];
    for (final point in route.points) {
      distances.add(const Distance()(center, point));
    }

    final avgDistance = distances.reduce((a, b) => a + b) / distances.length;
    final maxDistance = distances.reduce((a, b) => a > b ? a : b);
    final minDistance = distances.reduce((a, b) => a < b ? a : b);

    _logger.i('   Average distance from center: ${avgDistance.toStringAsFixed(0)} m');
    _logger.i('   Min distance: ${minDistance.toStringAsFixed(0)} m');
    _logger.i('   Max distance: ${maxDistance.toStringAsFixed(0)} m');
    _logger.i('   Range: ${(maxDistance - minDistance).toStringAsFixed(0)} m');

    if (maxDistance - minDistance > 500) {
      _logger.i('   ✅ Good spiral variation (explores different distances from center)');
    } else {
      _logger.w('   ⚠️  Low variation - route may not be very spiral-like');
    }

    var angleChanges = 0;
    if (route.points.length > 3) {
      for (int i = 1; i < route.points.length - 1; i++) {
        final prev = route.points[i - 1];
        final curr = route.points[i];
        final next = route.points[i + 1];

        final angle1 = _calculateAngle(center, prev);
        final angle2 = _calculateAngle(center, curr);
        final angle3 = _calculateAngle(center, next);

        if ((angle2 - angle1).abs() > 10 || (angle3 - angle2).abs() > 10) {
          angleChanges++;
        }
      }

      _logger.i('   Angle changes: $angleChanges / ${route.points.length - 2}');
      
      if (angleChanges > route.points.length ~/ 4) {
        _logger.i('   ✅ Good angular variation (winding path detected)');
      } else {
        _logger.w('   ⚠️  Low angular variation - path may be too direct');
      }
    }

    _logger.i('');
    _logger.i('🎯 SPIRAL QUALITY:');
    final spiralScore = _calculateSpiralScore(route, center);
    _logger.i('   Score: ${spiralScore.toStringAsFixed(1)}/100');
    
    if (spiralScore > 70) {
      _logger.i('   ✅ EXCELLENT: Strong spiral pattern detected!');
    } else if (spiralScore > 50) {
      _logger.i('   ✅ GOOD: Spiral pattern present');
    } else if (spiralScore > 30) {
      _logger.i('   ⚠️  FAIR: Some winding, but not strongly spiral');
    } else {
      _logger.w('   ⚠️  POOR: Route is too direct, not spiral-like');
    }
  }

  static double _calculateAngle(LatLng center, LatLng point) {
    final dx = point.longitude - center.longitude;
    final dy = point.latitude - center.latitude;
    return math.atan2(dy, dx) * 180 / math.pi;
  }

  static double _calculateSpiralScore(dynamic route, LatLng center) {
    double score = 0;

    if (route.points.length > 10) {
      score += 30;
    } else if (route.points.length > 5) {
      score += 15;
    }

    final distances = <double>[];
    for (final point in route.points) {
      distances.add(const Distance()(center, point));
    }

    final maxDist = distances.reduce((a, b) => a > b ? a : b);
    final minDist = distances.reduce((a, b) => a < b ? a : b);
    final variation = maxDist - minDist;

    if (variation > 1000) {
      score += 30;
    } else if (variation > 500) {
      score += 20;
    } else if (variation > 200) {
      score += 10;
    }

    var angleChanges = 0;
    if (route.points.length > 3) {
      for (int i = 2; i < route.points.length; i++) {
        final angle1 = _calculateAngle(center, route.points[i - 2]);
        final angle2 = _calculateAngle(center, route.points[i - 1]);
        final angle3 = _calculateAngle(center, route.points[i]);

        final change1 = (angle2 - angle1).abs();
        final change2 = (angle3 - angle2).abs();

        if (change1 > 5 || change2 > 5) {
          angleChanges++;
        }
      }

      final angleRatio = angleChanges / (route.points.length - 2);
      score += angleRatio * 40;
    }

    return score.clamp(0, 100);
  }
}
