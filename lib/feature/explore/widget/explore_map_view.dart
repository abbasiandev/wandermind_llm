import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/widget/map_widget.dart';

class ExploreMapView extends StatefulWidget {
  final double? latitude;
  final double? longitude;
  final String? locationName;

  const ExploreMapView({
    super.key,
    this.latitude,
    this.longitude,
    this.locationName,
  });

  @override
  State<ExploreMapView> createState() => _ExploreMapViewState();
}

class _ExploreMapViewState extends State<ExploreMapView> {
  late LatLng _center;
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();

    _center = LatLng(
      widget.latitude ?? 37.7749,
      widget.longitude ?? -122.4194,
    );

    if (widget.latitude != null && widget.longitude != null) {
      _markers = [
        Marker(
          point: _center,
          width: 50,
          height: 50,
          child: Column(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 40,
              ),
              if (widget.locationName != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Text(
                    widget.locationName!,
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
            ],
          ),
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          child: Row(
            children: [
              const Icon(Icons.map_outlined),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explore Location',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Powered by OpenStreetMap (Free)',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.my_location),
                onPressed: () {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Feature coming soon!')),
                  );
                },
              ),
            ],
          ),
        ),

        Expanded(
          child: MapWidget(
            center: _center,
            zoom: 13.0,
            markers: _markers,
            onTap: (point) {
              setState(() {
                _center = point;
                _markers = [
                  Marker(
                    point: point,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),
                ];
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Location: ${point.latitude.toStringAsFixed(4)}, ${point.longitude.toStringAsFixed(4)}',
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ),

        Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {

                },
                icon: const Icon(Icons.add_location_alt, size: 18),
                label: const Text('Add to Plan'),
              ),
              OutlinedButton.icon(
                onPressed: () {

                },
                icon: const Icon(Icons.search, size: 18),
                label: const Text('Search Nearby'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
