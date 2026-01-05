import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.abbasian.wandermind_llm',
          maxZoom: 19,
          tileProvider: NetworkTileProvider(),
        ),
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
Future<LatLng?> getLatLngFromAddress(String address) async {
  try {
    return null;
  } catch (e) {
    return null;
  }
}