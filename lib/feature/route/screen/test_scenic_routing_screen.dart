import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/theme/app_color.dart';
import '../model/scenic_route_preferences.dart';
import '../service/smart_routing_service.dart';
import '../service/test_scenic_routing.dart';
import '../widget/enhanced_route_map_widget.dart';

class TestScenicRoutingScreen extends ConsumerStatefulWidget {
  const TestScenicRoutingScreen({super.key});

  @override
  ConsumerState<TestScenicRoutingScreen> createState() => _TestScenicRoutingScreenState();
}

class _TestScenicRoutingScreenState extends ConsumerState<TestScenicRoutingScreen> {
  final _routingService = SmartRoutingService();
  ScenicMode _selectedMode = ScenicMode.spiral;
  dynamic _currentRoute;
  bool _isCalculating = false;
  String _testResults = '';

  final _start = LatLng(25.2048, 55.2708);
  final _end = LatLng(25.1972, 55.2744);

  @override
  void initState() {
    super.initState();
    _initializeService();
  }

  Future<void> _initializeService() async {
    await _routingService.initialize();
  }

  Future<void> _calculateRoute() async {
    setState(() {
      _isCalculating = true;
      _testResults = '';
    });

    try {
      final route = await _routingService.getScenicRoute(
        start: _start,
        end: _end,
        preferences: ScenicRoutePreferences(
          mode: _selectedMode,
          maxDetourMultiplier: _selectedMode.detourMultiplier,
          avoidHighways: true,
          preferLocalStreets: true,
          exploreSideStreets: true,
        ),
      );

      setState(() {
        _currentRoute = route;
        _isCalculating = false;
      });

      if (route != null) {
        _analyzeRoute(route);
      }
    } catch (e) {
      setState(() {
        _isCalculating = false;
        _testResults = 'Error: $e';
      });
    }
  }

  void _analyzeRoute(dynamic route) {
    final buffer = StringBuffer();

    buffer.writeln('✅ Route Calculated Successfully!\n');
    buffer.writeln('📊 Statistics:');
    buffer.writeln('   Mode: ${route.name}');
    buffer.writeln('   Points: ${route.points.length}');
    buffer.writeln('   Steps: ${route.steps.length}');
    buffer.writeln('   Distance: ${(route.distanceMeters / 1000).toStringAsFixed(2)} km');
    buffer.writeln('   Duration: ${(route.durationSeconds / 60).toStringAsFixed(0)} min\n');

    final directDistance = const Distance()(_start, _end);
    final detourRatio = route.distanceMeters / directDistance;
    buffer.writeln('   Direct: ${(directDistance / 1000).toStringAsFixed(2)} km');
    buffer.writeln('   Detour: ${detourRatio.toStringAsFixed(2)}x\n');

    if (_selectedMode == ScenicMode.spiral) {
      buffer.writeln('🌀 Spiral Analysis:');
      final centerLat = (_start.latitude + _end.latitude) / 2;
      final centerLon = (_start.longitude + _end.longitude) / 2;
      final center = LatLng(centerLat, centerLon);

      final distances = <double>[];
      for (final point in route.points) {
        distances.add(const Distance()(center, point));
      }

      final avgDist = distances.reduce((a, b) => a + b) / distances.length;
      final maxDist = distances.reduce((a, b) => a > b ? a : b);
      final minDist = distances.reduce((a, b) => a < b ? a : b);

      buffer.writeln('   Avg from center: ${avgDist.toStringAsFixed(0)} m');
      buffer.writeln('   Range: ${(maxDist - minDist).toStringAsFixed(0)} m');

      if (maxDist - minDist > 500) {
        buffer.writeln('   ✅ Good spiral variation!');
      }
    }

    if (route.points.length > 2) {
      buffer.writeln('\n✅ Route follows real streets!');
    } else {
      buffer.writeln('\n⚠️ Route may be too simple');
    }

    setState(() {
      _testResults = buffer.toString();
    });
  }

  Future<void> _runAllTests() async {
    setState(() {
      _testResults = 'Running all tests...\n';
    });

    await ScenicRoutingTester.runAllTests();

    setState(() {
      _testResults = 'All tests complete! Check console for details.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Scenic Routing'),
        actions: [
          IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: _isCalculating ? null : _runAllTests,
            tooltip: 'Run all tests',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.primary.withOpacity(0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Test Route:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Start: Dubai Marina ($_start)'),
                Text('End: Dubai Mall ($_end)'),
                const SizedBox(height: 8),
                const Text(
                  'Select Mode:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: ScenicMode.values.map((mode) {
                    return ChoiceChip(
                      label: Text(mode.displayName.split(' ').first),
                      selected: _selectedMode == mode,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => _selectedMode = mode);
                        }
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isCalculating ? null : _calculateRoute,
                    icon: _isCalculating
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.route),
                    label: Text(_isCalculating ? 'Calculating...' : 'Calculate Route'),
                  ),
                ),
              ],
            ),
          ),
          if (_testResults.isNotEmpty)
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.black87,
                child: SingleChildScrollView(
                  child: Text(
                    _testResults,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      color: Colors.greenAccent,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          if (_currentRoute != null)
            Expanded(
              flex: 2,
              child: EnhancedRouteMapWidget(route: _currentRoute),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _routingService.dispose();
    super.dispose();
  }
}
