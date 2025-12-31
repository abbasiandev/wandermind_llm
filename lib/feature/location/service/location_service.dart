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
      // Check service first - this is quick
      final serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        _logger.w('Location services are disabled');
        throw Exception('Location services are disabled');
      }

      // Check permissions
      LocationPermission permission = await checkPermission();
      _logger.d('Current permission: $permission');
      
      if (permission == LocationPermission.denied) {
        _logger.i('Requesting location permission...');
        permission = await requestPermission();
        if (permission == LocationPermission.denied) {
          _logger.w('Location permissions are denied');
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _logger.w('Location permissions are permanently denied');
        throw Exception('Location permissions are permanently denied');
      }

      _logger.d('Getting position...');
      final position = await _geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw Exception('Location request timed out. Please check your GPS signal.');
        },
      );

      _logger.d('Position acquired: ${position.latitude}, ${position.longitude}');
      
      // Try to get address, but don't fail if geocoding fails
      String address = 'Location: ${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}';
      try {
        final geocodedAddress = await getAddressFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (geocodedAddress != null && geocodedAddress.isNotEmpty) {
          address = geocodedAddress;
        }
      } catch (e) {
        _logger.w('Failed to geocode address, using coordinates: $e');
        // Continue with coordinate-based address
      }

      final locationData = LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
        timestamp: DateTime.now(),
      );

      _logger.i('Got current location: ${locationData.address}');
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
      final placemarks = await placemarkFromCoordinates(lat, lng).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          _logger.w('Geocoding timeout, skipping address lookup');
          return [];
        },
      );
      
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        final addressComponents = [
          placemark.street,
          placemark.locality,
          placemark.administrativeArea,
          placemark.country,
        ].where((component) => component != null && component.isNotEmpty);

        final address = addressComponents.join(', ');
        if (address.isNotEmpty) {
          return address;
        }
      }
      return null;
    } catch (e) {
      _logger.w('Failed to get address from coordinates (non-critical): $e');
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