import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/model/app_model.dart';
import '../service/location_service.dart';
import '../../../core/provider/app_provider.dart';
part 'location_provider.g.dart';
final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService(ref.watch(geolocatorProvider));
});
@riverpod
class LocationController extends _$LocationController {
  @override
  Future<LocationData?> build() async {
    return null;
  }
  Future<void> getCurrentLocation() async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(locationServiceProvider);
      final location = await service.getCurrentLocation();
      state = AsyncValue.data(location);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  Future<LocationData?> getLocationFromAddress(String address) async {
    try {
      final service = ref.read(locationServiceProvider);
      return await service.getLocationFromAddress(address);
    } catch (e) {
      return null;
    }
  }
  Future<String?> getAddressFromCoordinates(double lat, double lng) async {
    try {
      final service = ref.read(locationServiceProvider);
      return await service.getAddressFromCoordinates(lat, lng);
    } catch (e) {
      return null;
    }
  }
}
@riverpod
class LocationPermissionController extends _$LocationPermissionController {
  @override
  Future<LocationPermission> build() async {
    final service = ref.read(locationServiceProvider);
    return await service.checkPermission();
  }
  Future<void> requestPermission() async {
    final service = ref.read(locationServiceProvider);
    final permission = await service.requestPermission();
    state = AsyncValue.data(permission);
  }
}