import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
enum MapProvider {
  mapbox,
  openStreetMap,
  auto,
}
class MapConfig {
  static String? _mapboxToken;
  static bool _initialized = false;
  static MapProvider _userPreference = MapProvider.auto;
  static const String _prefKey = 'map_provider_preference';
  static Future<void> initialize() async {
    if (_initialized) return;
    try {
      await dotenv.load(fileName: ".env");
      _mapboxToken = dotenv.env['MAPBOX_ACCESS_TOKEN'];
      final prefs = await SharedPreferences.getInstance();
      final prefValue = prefs.getString(_prefKey);
      if (prefValue != null) {
        _userPreference = MapProvider.values.firstWhere(
          (e) => e.name == prefValue,
          orElse: () => MapProvider.auto,
        );
      }
      _initialized = true;
    } catch (e) {
      _initialized = true;
    }
  }
  static Future<void> setPreferredProvider(MapProvider provider) async {
    _userPreference = provider;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, provider.name);
  }
  static MapProvider get preferredProvider => _userPreference;
  static bool get isMapboxAvailable {
    return _mapboxToken != null && _mapboxToken!.isNotEmpty;
  }
  static bool get shouldUseMapbox {
    switch (_userPreference) {
      case MapProvider.mapbox:
        return isMapboxAvailable;
      case MapProvider.openStreetMap:
        return false;
      case MapProvider.auto:
        return isMapboxAvailable;
    }
  }
  static String? get mapboxToken => _mapboxToken;
  static String getTileUrlTemplate({bool useSatellite = false}) {
    if (shouldUseMapbox) {
      final style = useSatellite ? 'satellite-streets-v12' : 'streets-v12';
      return 'https://api.mapbox.com/styles/v1/mapbox/$style/tiles/{z}/{x}/{y}?access_token=$_mapboxToken';
    } else {
      return 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
    }
  }
  static String get providerName {
    return shouldUseMapbox ? 'Mapbox' : 'OpenStreetMap';
  }
  static List<MapProvider> get availableProviders {
    final providers = <MapProvider>[MapProvider.openStreetMap];
    if (isMapboxAvailable) {
      providers.insert(0, MapProvider.mapbox);
      providers.add(MapProvider.auto);
    }
    return providers;
  }
  static String getProviderDisplayName(MapProvider provider) {
    switch (provider) {
      case MapProvider.mapbox:
        return 'Mapbox';
      case MapProvider.openStreetMap:
        return 'OpenStreetMap';
      case MapProvider.auto:
        return 'Auto (Mapbox if available)';
    }
  }
  static String get attribution {
    if (isMapboxAvailable) {
      return '© Mapbox © OpenStreetMap';
    } else {
      return '© OpenStreetMap contributors';
    }
  }
}