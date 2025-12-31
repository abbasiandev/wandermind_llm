import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/theme/app_color.dart';
import '../widget/route_map_widget.dart';
import '../widget/route_preferences_sheet.dart';
import '../widget/waypoints_manager.dart';
import '../widget/route_options_selector.dart';
import '../widget/map_provider_selector.dart';
import '../provider/route_provider.dart';
import '../model/route_models.dart';
import '../../../core/config/map_config.dart';
import '../../location/provider/location_provider.dart';

class RouteScreen extends ConsumerStatefulWidget {
  final String? startLocation;
  final String? endLocation;

  const RouteScreen({
    super.key,
    this.startLocation,
    this.endLocation,
  });

  @override
  ConsumerState<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends ConsumerState<RouteScreen> {
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  LatLng? _destinationLocation;
  bool _showWaypoints = false;
  bool _isCalculatingRoutes = false;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    _startController.text = widget.startLocation ?? 'Current Location';
    _endController.text = widget.endLocation ?? '';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(locationControllerProvider.notifier).getCurrentLocation();
    });
  }

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationAsync = ref.watch(locationControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Navigation'),
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: _showMapProviderSelector,
            tooltip: 'Change map provider',
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: _showPreferences,
            tooltip: 'Route preferences',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(locationControllerProvider),
            tooltip: 'Refresh location',
          ),
        ],
      ),
      body: Column(
        children: [

          if (!_isNavigating)
            Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [

                TextField(
                  controller: _startController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.my_location, color: AppColors.primary),
                    hintText: 'Starting point',
                    filled: true,
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.gps_fixed),
                      onPressed: _useCurrentLocation,
                      tooltip: 'Use current location',
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: _endController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.location_on, color: AppColors.error),
                    hintText: 'Destination',
                    filled: true,
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _showRoute,
                        icon: _isCalculatingRoutes
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                ),
                              )
                            : const Icon(Icons.directions),
                        label: Text(_isCalculatingRoutes ? 'Calculating...' : 'Show Routes'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _showWaypoints = !_showWaypoints;
                        });
                      },
                      icon: Icon(
                        _showWaypoints ? Icons.expand_less : Icons.add_location_alt,
                        color: AppColors.primary,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        padding: const EdgeInsets.all(16),
                      ),
                      tooltip: 'Add waypoints',
                    ),
                  ],
                ),
              ],
            ),
          ),

          if (_showWaypoints)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: WaypointsManager(
                waypoints: ref.watch(routeManagerProvider)?.waypoints ?? [],
                onWaypointsChanged: (waypoints) {
                  ref.read(routeManagerProvider.notifier).updateWaypoints(waypoints);
                },
                onWaypointTap: (location) {

                },
              ),
            ),

          if (ref.watch(routeManagerProvider)?.alternativeRoutes.isNotEmpty ?? false)
            RouteOptionsSelector(
              routes: ref.watch(routeManagerProvider)!.alternativeRoutes,
              selectedRoute: ref.watch(routeManagerProvider)?.activeRoute,
              onRouteSelected: (route) {
                ref.read(routeManagerProvider.notifier).selectRoute(route);
              },
            ),

          Expanded(
            child: locationAsync.when(
              data: (location) {
                if (location == null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_off, size: 64, color: AppColors.textSecondary),
                        const SizedBox(height: 16),
                        const Text('Location not available'),
                        const SizedBox(height: 8),
                        const Text(
                          'Please enable location services',
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () async {

                            await ref.read(locationPermissionControllerProvider.notifier).requestPermission();

                            await ref.read(locationControllerProvider.notifier).getCurrentLocation();
                          },
                          icon: const Icon(Icons.location_on),
                          label: const Text('Enable Location'),
                        ),
                      ],
                    ),
                  );
                }

                return RouteMapWidget(
                  destination: _destinationLocation,
                  onMapTap: (point) {
                    setState(() {
                      _destinationLocation = point;
                      _endController.text = '${point.latitude.toStringAsFixed(4)}, ${point.longitude.toStringAsFixed(4)}';
                    });
                  },
                  onNavigationStateChanged: (isNavigating) {
                    setState(() {
                      _isNavigating = isNavigating;
                    });
                  },
                );
              },
              loading: () => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Getting your location...'),
                  ],
                ),
              ),
              error: (error, stack) {
                final errorMessage = error.toString();
                final isServiceDisabled = errorMessage.contains('Location services are disabled');
                final isPermissionDenied = errorMessage.contains('permissions are denied');
                final isPermissionDeniedForever = errorMessage.contains('permanently denied');

                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isServiceDisabled ? Icons.location_disabled : Icons.location_off,
                          size: 64,
                          color: AppColors.error,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          isServiceDisabled
                              ? 'Location Service Disabled'
                              : isPermissionDeniedForever
                                  ? 'Location Permission Denied'
                                  : 'Location Not Available',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          isServiceDisabled
                              ? 'Please enable location services in your device settings to use route navigation.'
                              : isPermissionDeniedForever
                                  ? 'Location permission is permanently denied. Please enable it in your device settings under App Permissions.'
                                  : isPermissionDenied
                                      ? 'Location permission is required to show routes and navigation.'
                                      : 'Unable to get your current location.',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        if (isServiceDisabled)
                          ElevatedButton.icon(
                            onPressed: () async {

                              await Geolocator.openLocationSettings();
                            },
                            icon: const Icon(Icons.settings),
                            label: const Text('Open Settings'),
                          )
                        else if (isPermissionDeniedForever)
                          ElevatedButton.icon(
                            onPressed: () async {

                              await Geolocator.openAppSettings();
                            },
                            icon: const Icon(Icons.settings),
                            label: const Text('Open App Settings'),
                          )
                        else
                          ElevatedButton.icon(
                            onPressed: () async {
                              await ref.read(locationPermissionControllerProvider.notifier).requestPermission();
                              await ref.read(locationControllerProvider.notifier).getCurrentLocation();
                            },
                            icon: const Icon(Icons.location_on),
                            label: const Text('Enable Location'),
                          ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () => ref.refresh(locationControllerProvider),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          if (!_isNavigating && _startController.text.isNotEmpty && _endController.text.isNotEmpty)
            _buildRouteInfoPanel(),
        ],
      ),
    );
  }

  Widget _buildRouteInfoPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.directions_car, color: AppColors.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'By Car',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Calculating route...',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            ' Tip: Offline routing uses pre-downloaded map data. For live traffic updates, connect to the internet.',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  void _useCurrentLocation() async {
    final location = await ref.read(locationControllerProvider.future);
    if (location != null) {
      setState(() {
        _startController.text = 'Current Location';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Using current location')),
      );
    }
  }

  void _showMapProviderSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => MapProviderSelector(
        onProviderChanged: () {

          setState(() {

          });
        },
      ),
    );
  }

  void _showPreferences() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => RoutePreferencesSheet(
        initialPreferences: ref.read(routeManagerProvider)?.preferences ??
            const RoutePreferences(),
        onApply: (preferences) {
          ref.read(routeManagerProvider.notifier).updatePreferences(preferences);
          _calculateRoutes();
        },
      ),
    );
  }

  Future<void> _showRoute() async {
    if (_endController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a destination')),
      );
      return;
    }

    if (_destinationLocation == null) {
      final parts = _endController.text.split(',');
      if (parts.length == 2) {
        final lat = double.tryParse(parts[0].trim());
        final lng = double.tryParse(parts[1].trim());
        if (lat != null && lng != null) {
          setState(() {
            _destinationLocation = LatLng(lat, lng);
          });
        }
      }
    }

    if (_destinationLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please tap on map or enter valid coordinates')),
      );
      return;
    }

    await _calculateRoutes();
  }

  Future<void> _calculateRoutes() async {
    final location = await ref.read(locationControllerProvider.future);
    if (location == null || _destinationLocation == null) return;

    setState(() {
      _isCalculatingRoutes = true;
    });

    try {

      ref.read(routeManagerProvider.notifier).setRoute(
        LatLng(location.latitude, location.longitude),
        _destinationLocation!,
      );

      await ref.read(routeManagerProvider.notifier).calculateRoutes();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Found ${ref.read(routeManagerProvider)?.alternativeRoutes.length ?? 0} route options!',
            ),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error calculating routes: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCalculatingRoutes = false;
        });
      }
    }
  }
}
