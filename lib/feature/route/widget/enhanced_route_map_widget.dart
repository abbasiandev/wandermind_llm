import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../core/config/map_config.dart';
import '../../../core/theme/app_color.dart';
import '../../location/provider/location_provider.dart';
import '../provider/route_provider.dart';
import '../model/route_models.dart';

class EnhancedRouteMapWidget extends ConsumerStatefulWidget {
  final RouteResult? route;
  final Function(LatLng)? onMapTap;

  const EnhancedRouteMapWidget({
    super.key,
    this.route,
    this.onMapTap,
  });

  @override
  ConsumerState<EnhancedRouteMapWidget> createState() => _EnhancedRouteMapWidgetState();
}

class _EnhancedRouteMapWidgetState extends ConsumerState<EnhancedRouteMapWidget> {
  final MapController _mapController = MapController();
  final FlutterTts _flutterTts = FlutterTts();
  StreamSubscription? _locationSubscription;
  
  LatLng? _currentLocation;
  double _currentZoom = 16.0;
  bool _followMode = true;
  double _previousDistanceToStep = 0.0;

  @override
  void initState() {
    super.initState();
    _initTts();
    _startLocationTracking();
  }

  Future<void> _initTts() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    _mapController.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  void _startLocationTracking() {
    final locationService = ref.read(locationServiceProvider);

    _locationSubscription = locationService.getLocationStream().listen(
      (locationData) {
        final newLocation = LatLng(locationData.latitude, locationData.longitude);
        
        setState(() {
          _currentLocation = newLocation;
        });

        final navState = ref.read(navigationStateNotifierProvider);
        if (navState.isNavigating) {
          ref.read(navigationStateNotifierProvider.notifier).updateLocation(newLocation);
          
          _checkForVoiceAnnouncement();
        }

        if (_followMode && mounted) {
          _mapController.move(newLocation, _currentZoom);
        }
      },
    );
  }

  void _checkForVoiceAnnouncement() {
    final navState = ref.read(navigationStateNotifierProvider);
    final notifier = ref.read(navigationStateNotifierProvider.notifier);
    
    if (navState.distanceToNextStep > 0) {
      if (notifier.shouldAnnounce(_previousDistanceToStep, navState.distanceToNextStep)) {
        final instruction = notifier.getVoiceInstruction();
        _speak(instruction);
      }
      _previousDistanceToStep = navState.distanceToNextStep;
    }

    if (navState.isOffRoute && !navState.isRerouting) {
      _speak('Rerouting...');
    }
  }

  Future<void> _speak(String text) async {
    try {
      await _flutterTts.speak(text);
    } catch (e) {
      debugPrint('TTS error: $e');
    }
  }

  void _startNavigation() {
    if (widget.route != null) {
      ref.read(navigationStateNotifierProvider.notifier).startNavigation(widget.route!);
      
      setState(() {
        _followMode = true;
        _currentZoom = 17.0;
      });

      if (_currentLocation != null) {
        _mapController.move(_currentLocation!, _currentZoom);
      }

      _speak('Navigation started');
    }
  }

  void _stopNavigation() {
    ref.read(navigationStateNotifierProvider.notifier).stopNavigation();
    
    setState(() {
      _currentZoom = 16.0;
    });

    _speak('Navigation stopped');
  }

  List<Marker> _buildMarkers() {
    final markers = <Marker>[];

    if (_currentLocation != null) {
      markers.add(
        Marker(
          point: _currentLocation!,
          width: 50,
          height: 50,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withOpacity(0.3),
                ),
              ),
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.navigation,
                color: Colors.white,
                size: 12,
              ),
            ],
          ),
        ),
      );
    }

    if (widget.route != null && widget.route!.points.isNotEmpty) {
      markers.add(
        Marker(
          point: widget.route!.points.last,
          width: 40,
          height: 40,
          child: const Icon(
            Icons.location_on,
            color: AppColors.error,
            size: 40,
          ),
        ),
      );
    }

    return markers;
  }

  List<Polyline> _buildRoute() {
    if (widget.route == null || widget.route!.points.isEmpty) {
      debugPrint('⚠️ No route to display');
      return [];
    }

    debugPrint('📍 Drawing route with ${widget.route!.points.length} points');
    debugPrint('   Route name: ${widget.route!.name}');
    debugPrint('   Distance: ${(widget.route!.distanceMeters / 1000).toStringAsFixed(2)} km');
    debugPrint('   Steps: ${widget.route!.steps.length}');

    return [
      Polyline(
        points: widget.route!.points,
        strokeWidth: 5.0,
        color: AppColors.primary,
        borderStrokeWidth: 2.0,
        borderColor: Colors.white,
      ),
    ];
  }

  IconData _getManeuverIcon(ManeuverType type) {
    switch (type) {
      case ManeuverType.turnLeft:
      case ManeuverType.turnSlightLeft:
      case ManeuverType.turnSharpLeft:
        return Icons.turn_left;
      case ManeuverType.turnRight:
      case ManeuverType.turnSlightRight:
      case ManeuverType.turnSharpRight:
        return Icons.turn_right;
      case ManeuverType.uTurn:
        return Icons.u_turn_left;
      case ManeuverType.merge:
        return Icons.merge;
      case ManeuverType.roundabout:
        return Icons.roundabout_left;
      case ManeuverType.arrive:
        return Icons.flag;
      default:
        return Icons.arrow_upward;
    }
  }

  @override
  Widget build(BuildContext context) {
    final navState = ref.watch(navigationStateNotifierProvider);
    final locationAsync = ref.watch(locationControllerProvider);

    return locationAsync.when(
      data: (location) {
        if (_currentLocation == null && location != null) {
          _currentLocation = LatLng(location.latitude, location.longitude);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _mapController.move(_currentLocation!, _currentZoom);
          });
        }

        return Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _currentLocation ?? const LatLng(25.2048, 55.2708),
                initialZoom: _currentZoom,
                minZoom: 3.0,
                maxZoom: 18.0,
                onTap: (_, point) {
                  if (!navState.isNavigating) {
                    widget.onMapTap?.call(point);
                    setState(() {
                      _followMode = false;
                    });
                  }
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: MapConfig.getTileUrlTemplate(),
                  userAgentPackageName: 'dev.abbasian.wandermind_llm',
                  maxNativeZoom: 19,
                ),
                PolylineLayer(polylines: _buildRoute()),
                MarkerLayer(markers: _buildMarkers()),
              ],
            ),

            if (navState.isNavigating && navState.currentStep != null)
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: navState.isOffRoute ? AppColors.error : AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            _getManeuverIcon(navState.currentStep!.maneuver),
                            color: Colors.white,
                            size: 40,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  navState.currentStep!.instruction,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (navState.distanceToNextStep > 0)
                                  Text(
                                    'in ${_formatDistance(navState.distanceToNextStep)}',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                if (navState.currentStep!.streetName != null)
                                  Text(
                                    navState.currentStep!.streetName!,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (navState.isOffRoute)
                        const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Icon(Icons.warning, color: Colors.white, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Off route - Recalculating...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

            Positioned(
              right: 16,
              bottom: navState.isNavigating ? 180 : 100,
              child: FloatingActionButton.small(
                heroTag: 'follow',
                onPressed: () {
                  setState(() {
                    _followMode = !_followMode;
                  });
                  if (_followMode && _currentLocation != null) {
                    _mapController.move(_currentLocation!, _currentZoom);
                  }
                },
                backgroundColor: _followMode ? AppColors.primary : Colors.white,
                child: Icon(
                  Icons.my_location,
                  color: _followMode ? Colors.white : AppColors.primary,
                ),
              ),
            ),

            if (widget.route != null)
              Positioned(
                top: navState.isNavigating ? 100 : 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Route: ${widget.route!.name ?? "Unknown"}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Points: ${widget.route!.points.length}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        'Steps: ${widget.route!.steps.length}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            if (_currentLocation != null && widget.route != null)
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: _buildInfoColumn(
                              'Distance',
                              _formatDistance(navState.isNavigating
                                  ? navState.totalDistanceRemaining
                                  : widget.route!.distanceMeters),
                            ),
                          ),
                          Expanded(
                            child: _buildInfoColumn(
                              'ETA',
                              _formatDuration(navState.isNavigating
                                  ? navState.totalDurationRemaining
                                  : widget.route!.durationSeconds),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: navState.isNavigating
                            ? ElevatedButton.icon(
                                onPressed: _stopNavigation,
                                icon: const Icon(Icons.stop),
                                label: const Text('Stop Navigation'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.error,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                              )
                            : ElevatedButton.icon(
                                onPressed: _startNavigation,
                                icon: const Icon(Icons.navigation),
                                label: const Text('Start Navigation'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  String _formatDistance(double meters) {
    if (meters < 1000) {
      return '${meters.toStringAsFixed(0)} m';
    } else {
      return '${(meters / 1000).toStringAsFixed(1)} km';
    }
  }

  String _formatDuration(double seconds) {
    if (seconds < 60) {
      return '< 1 min';
    } else if (seconds < 3600) {
      final minutes = (seconds / 60).round();
      return '$minutes min';
    } else {
      final hours = (seconds / 3600).floor();
      final minutes = ((seconds % 3600) / 60).round();
      return '${hours}h ${minutes}m';
    }
  }
}
