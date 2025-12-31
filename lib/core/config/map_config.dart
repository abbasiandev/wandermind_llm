import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Map provider type
enum MapProvider {
  mapbox,
  openStreetMap,
  auto, // Automatic: Mapbox if available, else OSM
}

/// Map provider configuration
class MapConfig {
  static String? _mapboxToken;
  static bool _initialized = false;
  static MapProvider _userPreference = MapProvider.auto;
  static const String _prefKey = 'map_provider_preference';
  
  /// Initialize map configuration
  static Future<void> initialize() async {
    if (_initialized) return;
    
    try {
      await dotenv.load(fileName: ".env");
      _mapboxToken = dotenv.env['MAPBOX_ACCESS_TOKEN'];
      
      // Load user preference
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
      // .env file not found or error loading, will use OSM
      _initialized = true;
    }
  }
  
  /// Set user's preferred map provider
  static Future<void> setPreferredProvider(MapProvider provider) async {
    _userPreference = provider;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, provider.name);
  }
  
  /// Get user's preferred provider
  static MapProvider get preferredProvider => _userPreference;
  
  /// Check if Mapbox is available
  static bool get isMapboxAvailable {
    return _mapboxToken != null && _mapboxToken!.isNotEmpty;
  }
  
  /// Check if should use Mapbox based on user preference
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
  
  /// Get Mapbox token
  static String? get mapboxToken => _mapboxToken;
  
  /// Get tile URL template based on user preference and availability
  static String getTileUrlTemplate({bool useSatellite = false}) {
    if (shouldUseMapbox) {
      // Mapbox tiles
      final style = useSatellite ? 'satellite-streets-v12' : 'streets-v12';
      return 'https://api.mapbox.com/styles/v1/mapbox/$style/tiles/{z}/{x}/{y}?access_token=$_mapboxToken';
    } else {
      // OpenStreetMap tiles (free, no token needed)
      return 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
    }
  }
  
  /// Get current active provider name
  static String get providerName {
    return shouldUseMapbox ? 'Mapbox' : 'OpenStreetMap';
  }
  
  /// Get list of available providers
  static List<MapProvider> get availableProviders {
    final providers = <MapProvider>[MapProvider.openStreetMap];
    if (isMapboxAvailable) {
      providers.insert(0, MapProvider.mapbox);
      providers.add(MapProvider.auto);
    }
    return providers;
  }
  
  /// Get display name for provider
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
  
  /// Get attribution text
  static String get attribution {
    if (isMapboxAvailable) {
      return '© Mapbox © OpenStreetMap';
    } else {
      return '© OpenStreetMap contributors';
    }
  }
}
