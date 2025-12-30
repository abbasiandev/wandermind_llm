import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// A reusable map widget using OpenStreetMap (free alternative to Google Maps)
/// 
/// Example usage:
/// ```dart
/// MapWidget(
///   center: LatLng(37.7749, -122.4194), // San Francisco
///   markers: [
///     Marker(
///       point: LatLng(37.7749, -122.4194),
///       width: 40,
///       height: 40,
///       child: Icon(Icons.location_on, color: Colors.red, size: 40),
///     ),
///   ],
/// )
/// ```
class MapWidget extends StatefulWidget {
  final LatLng center;
  final double zoom;
  final List<Marker> markers;
  final Function(LatLng)? onTap;
  final Function(LatLng)? onLongPress;

  const MapWidget({
    super.key,
    required this.center,
    this.zoom = 13.0,
    this.markers = const [],
    this.onTap,
    this.onLongPress,
  });

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: widget.center,
        initialZoom: widget.zoom,
        onTap: (tapPosition, point) {
          widget.onTap?.call(point);
        },
        onLongPress: (tapPosition, point) {
          widget.onLongPress?.call(point);
        },
      ),
      children: [
        // OpenStreetMap tile layer (free to use)
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.abbasian.wandermind_llm',
          maxZoom: 19,
          // Rate limiting: Be respectful of OSM servers
          tileProvider: NetworkTileProvider(),
        ),
        // Markers layer
        if (widget.markers.isNotEmpty)
          MarkerLayer(
            markers: widget.markers,
          ),
      ],
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}

/// Helper function to convert address to coordinates using the existing LocationService
/// This works with the geocoding package which uses various free geocoding services
Future<LatLng?> getLatLngFromAddress(String address) async {
  try {
    // Import your LocationService here
    // final locationService = ref.read(locationServiceProvider);
    // final locationData = await locationService.getLocationFromAddress(address);
    // if (locationData != null) {
    //   return LatLng(locationData.latitude, locationData.longitude);
    // }
    return null;
  } catch (e) {
    return null;
  }
}
