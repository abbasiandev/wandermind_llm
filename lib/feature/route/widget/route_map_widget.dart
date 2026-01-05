import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../../core/config/map_config.dart';
import '../../../core/theme/app_color.dart';
import '../../location/provider/location_provider.dart';
import '../../location/service/location_service.dart';
class RouteMapWidget extends ConsumerStatefulWidget {
  final LatLng? destination;
  final Function(LatLng)? onMapTap;
  final Function(bool)? onNavigationStateChanged;
  const RouteMapWidget({
    super.key,
    this.destination,
    this.onMapTap,
    this.onNavigationStateChanged,
  });
  @override
  ConsumerState<RouteMapWidget> createState() => _RouteMapWidgetState();
}
class _RouteMapWidgetState extends ConsumerState<RouteMapWidget> {
  final MapController _mapController = MapController();
  final FlutterTts _flutterTts = FlutterTts();
  StreamSubscription? _locationSubscription;
  LatLng? _currentLocation;
  LatLng? _previousLocation;
  double _currentZoom = 16.0;
  double _currentRotation = 0.0;
  bool _followMode = true;
  double _currentSpeed = 0.0;
  DateTime? _lastUpdateTime;
  String _nextTurn = '';
  double _distanceToTurn = 0.0;
  bool _isNavigating = false;
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
        final now = DateTime.now();
        if (_previousLocation != null && _lastUpdateTime != null) {
          final distance = const Distance().distance(_previousLocation!, newLocation);
          final timeDiff = now.difference(_lastUpdateTime!).inSeconds;
          if (timeDiff > 0) {
            _currentSpeed = distance / timeDiff;
          }
        }
        setState(() {
          _previousLocation = _currentLocation;
          _currentLocation = newLocation;
          _lastUpdateTime = now;
        });
        if (widget.destination != null && _isNavigating) {
          _updateNavigationInstructions(newLocation);
        }
        if (_followMode && mounted) {
          _mapController.move(newLocation, _currentZoom);
        }
        if (_isNavigating && !_followMode) {
          setState(() {
            _followMode = true;
          });
        }
      },
      onError: (error) {
        debugPrint('Location stream error: $error');
      },
    );
  }
  void _updateNavigationInstructions(LatLng currentPos) {
    if (widget.destination == null) return;
    final distanceToDestination = const Distance().distance(currentPos, widget.destination!);
    if (distanceToDestination < 100) {
      _nextTurn = 'Arriving at destination';
      _distanceToTurn = distanceToDestination;
      if (distanceToDestination < 50 && _nextTurn != 'Arrived') {
        _speak('You have arrived at your destination');
        setState(() {
          _nextTurn = 'Arrived';
          _isNavigating = false;
        });
      }
    } else if (distanceToDestination < 500) {
      _nextTurn = 'Continue straight';
      _distanceToTurn = distanceToDestination;
      if (_distanceToTurn < 400 && _distanceToTurn > 350) {
        _speak('In 400 meters, you will arrive at your destination');
      }
    } else {
      _nextTurn = 'Head towards destination';
      _distanceToTurn = distanceToDestination;
    }
    setState(() {});
  }
  Future<void> _speak(String text) async {
    try {
      await _flutterTts.speak(text);
    } catch (e) {
      debugPrint('TTS error: $e');
    }
  }
  void _startNavigation() {
    if (widget.destination != null) {
      setState(() {
        _isNavigating = true;
        _followMode = true;
        _currentZoom = 17.0;
      });
      if (_currentLocation != null) {
        _mapController.move(_currentLocation!, _currentZoom);
      }
      _speak('Navigation started');
      widget.onNavigationStateChanged?.call(true);
    }
  }
  void _stopNavigation() {
    setState(() {
      _isNavigating = false;
      _nextTurn = '';
      _distanceToTurn = 0.0;
      _currentZoom = 16.0;
    });
    if (_currentLocation != null) {
      _mapController.move(_currentLocation!, _currentZoom);
    }
    _speak('Navigation stopped');
    widget.onNavigationStateChanged?.call(false);
  }
  void _toggleFollowMode() {
    if (_isNavigating) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Follow mode is locked during navigation'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    setState(() {
      _followMode = !_followMode;
    });
    if (_followMode && _currentLocation != null) {
      _mapController.move(_currentLocation!, _currentZoom);
    }
  }
  void _zoomIn() {
    setState(() {
      _currentZoom = (_currentZoom + 1).clamp(3.0, 18.0);
    });
    if (_currentLocation != null) {
      _mapController.move(_currentLocation!, _currentZoom);
    }
  }
  void _zoomOut() {
    setState(() {
      _currentZoom = (_currentZoom - 1).clamp(3.0, 18.0);
    });
    if (_currentLocation != null) {
      _mapController.move(_currentLocation!, _currentZoom);
    }
  }
  void _tiltMap() {
    setState(() {
      _currentRotation = _currentRotation == 0.0 ? 45.0 : 0.0;
    });
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
    if (widget.destination != null) {
      markers.add(
        Marker(
          point: widget.destination!,
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
    if (_currentLocation == null || widget.destination == null) {
      return [];
    }
    return [
      Polyline(
        points: [_currentLocation!, widget.destination!],
        strokeWidth: 4.0,
        color: AppColors.primary,
        borderStrokeWidth: 2.0,
        borderColor: Colors.white,
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
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
                  if (!_isNavigating) {
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
                  tileProvider: NetworkTileProvider(),
                ),
                PolylineLayer(
                  polylines: _buildRoute(),
                ),
                MarkerLayer(
                  markers: _buildMarkers(),
                ),
              ],
            ),
            Positioned(
              right: 16,
              bottom: 100,
              child: Column(
                children: [
                  FloatingActionButton.small(
                    heroTag: 'follow',
                    onPressed: _toggleFollowMode,
                    backgroundColor: _followMode ? AppColors.primary : Colors.white,
                    child: Icon(
                      Icons.my_location,
                      color: _followMode ? Colors.white : AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FloatingActionButton.small(
                    heroTag: '3d',
                    onPressed: _tiltMap,
                    backgroundColor: Colors.white,
                    child: Icon(
                      _currentRotation > 0 ? Icons.threed_rotation : Icons.layers,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FloatingActionButton.small(
                    heroTag: 'zoom_in',
                    onPressed: _zoomIn,
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.add, color: AppColors.primary),
                  ),
                  const SizedBox(height: 8),
                  FloatingActionButton.small(
                    heroTag: 'zoom_out',
                    onPressed: _zoomOut,
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.remove, color: AppColors.primary),
                  ),
                ],
              ),
            ),
            if (_followMode || _isNavigating)
              Positioned(
                top: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: _isNavigating ? AppColors.success : AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isNavigating ? Icons.navigation : Icons.my_location,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _isNavigating ? 'Navigating...' : 'Following your location',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            Positioned(
              top: 80,
              left: 16,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.speed, size: 16, color: AppColors.primary),
                        const SizedBox(width: 4),
                        Text(
                          '${(_currentSpeed * 3.6).toStringAsFixed(0)} km/h',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (_currentLocation != null && widget.destination != null)
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
                            child: Column(
                              children: [
                                const Text(
                                  'Distance',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _calculateDistance(_currentLocation!, widget.destination!),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  'ETA',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _calculateETA(_currentLocation!, widget.destination!),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (!_isNavigating)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _startNavigation,
                              icon: const Icon(Icons.navigation),
                              label: const Text('Start Navigation'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                        ),
                      if (_isNavigating)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _stopNavigation,
                              icon: const Icon(Icons.stop),
                              label: const Text('Stop Navigation'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.error,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            if (_isNavigating && _nextTurn.isNotEmpty)
              Positioned(
                top: 80,
                right: 16,
                left: 80,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                            size: 32,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _nextTurn,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (_distanceToTurn > 0)
                                  Text(
                                    'in ${_formatDistance(_distanceToTurn)}',
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
                    ],
                  ),
                ),
              ),
          ],
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => Center(
        child: Text('Error loading map: $error'),
      ),
    );
  }
  String _calculateDistance(LatLng from, LatLng to) {
    const distance = Distance();
    final meters = distance(from, to);
    return _formatDistance(meters);
  }
  String _formatDistance(double meters) {
    if (meters < 1000) {
      return '${meters.toStringAsFixed(0)} m';
    } else {
      return '${(meters / 1000).toStringAsFixed(1)} km';
    }
  }
  String _calculateETA(LatLng from, LatLng to) {
    const distance = Distance();
    final meters = distance(from, to);
    double speedMps = _currentSpeed > 0 ? _currentSpeed : 8.33;
    final seconds = (meters / speedMps).round();
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