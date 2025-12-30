import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';

import '../routing/app_router.dart';
import '../service/storage_service.dart';
import '../service/connectivity_service.dart';
import '../../feature/location/service/location_service.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be initialized in main.dart');
});

final hiveProvider = Provider<HiveInterface>((ref) {
  return Hive;
});

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.connectTimeout = const Duration(seconds: 30);
  dio.options.receiveTimeout = const Duration(seconds: 30);
  return dio;
});

final connectivityProvider = Provider<Connectivity>((ref) {
  return Connectivity();
});

final geolocatorProvider = Provider<GeolocatorPlatform>((ref) {
  return GeolocatorPlatform.instance;
});

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService(ref.watch(hiveProvider));
});

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService(ref.watch(geolocatorProvider));
});

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService(ref.watch(connectivityProvider));
});

final routerProvider = Provider<GoRouter>((ref) {
  return AppRouter.createRouter();
});

final appInitializationProvider = FutureProvider<void>((ref) async {
  final prefs = await SharedPreferences.getInstance();

  await ref.read(storageServiceProvider).initialize();
});

final initializedSharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Use overrideWith in main.dart');
});