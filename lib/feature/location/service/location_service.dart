import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:logger/logger.dart';

import '../../../core/model/app_model.dart';

class LocationService {
  static final Logger _logger = Logger();
  final GeolocatorPlatform _geolocator;

  LocationService(this._geolocator);

  Future<LocationPermission> checkPermission() async {
    return await _geolocator.checkPermission();
  }

  Future<LocationPermission> requestPermission() async {
    return await _geolocator.requestPermission();
  }

  Future<bool> isLocationServiceEnabled() async {
    return await _geolocator.isLocationServiceEnabled();
  }

  Future<LocationData> getCurrentLocation() async {
    try {
      final serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled');
      }

      LocationPermission permission = await checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied');
      }

      final position = await _geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 30),
        ),
      );

      final address = await getAddressFromCoordinates(
        position.latitude,
        position.longitude,
      );

      final locationData = LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address ?? 'Unknown location',
        timestamp: DateTime.now(),
      );

      _logger.d('Got current location: ${locationData.address}');
      return locationData;

    } catch (e) {
      _logger.e('Failed to get current location: $e');
      rethrow;
    }
  }

  Future<LocationData?> getLocationFromAddress(String address) async {
    try {
      final locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        final location = locations.first;
        return LocationData(
          latitude: location.latitude,
          longitude: location.longitude,
          address: address,
          timestamp: DateTime.now(),
        );
      }
      return null;
    } catch (e) {
      _logger.e('Failed to get location from address: $e');
      return null;
    }
  }

  Future<String?> getAddressFromCoordinates(double lat, double lng) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        final addressComponents = [
          placemark.street,
          placemark.locality,
          placemark.administrativeArea,
          placemark.country,
        ].where((component) => component != null && component.isNotEmpty);

        return addressComponents.join(', ');
      }
      return null;
    } catch (e) {
      _logger.e('Failed to get address from coordinates: $e');
      return null;
    }
  }

  Stream<LocationData> getLocationStream() {
    return _geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).asyncMap((position) async {
      final address = await getAddressFromCoordinates(
        position.latitude,
        position.longitude,
      );

      return LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address ?? 'Unknown location',
        timestamp: DateTime.now(),
      );
    });
  }
}