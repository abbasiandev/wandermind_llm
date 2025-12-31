import 'dart:io';
import 'dart:math';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:latlong2/latlong.dart';

class MapTileCacheService {
  static final Logger _logger = Logger();

  Future<DownloadProgress> downloadRegion({
    required LatLng center,
    required double radiusKm,
    int minZoom = 10,
    int maxZoom = 16,
    Function(int current, int total)? onProgress,
  }) async {
    final tiles = _calculateTilesToDownload(center, radiusKm, minZoom, maxZoom);
    final total = tiles.length;
    int downloaded = 0;
    int failed = 0;

    _logger.i('Starting download of $total tiles');

    final cacheDir = await _getCacheDirectory();

    for (final tile in tiles) {
      try {
        await _downloadTile(tile, cacheDir);
        downloaded++;
        onProgress?.call(downloaded, total);

        await Future.delayed(const Duration(milliseconds: 100));
      } catch (e) {
        failed++;
        _logger.w('Failed to download tile $tile: $e');
      }
    }

    _logger.i('Download complete: $downloaded/$total tiles ($failed failed)');

    return DownloadProgress(
      total: total,
      downloaded: downloaded,
      failed: failed,
    );
  }

  Future<File?> getCachedTile(int z, int x, int y) async {
    try {
      final cacheDir = await _getCacheDirectory();
      final file = File('${cacheDir.path}/$z/$x/$y.png');

      if (await file.exists()) {
        return file;
      }
      return null;
    } catch (e) {
      _logger.e('Error getting cached tile: $e');
      return null;
    }
  }

  Future<double> getCacheSize() async {
    try {
      final cacheDir = await _getCacheDirectory();
      int totalSize = 0;

      await for (final entity in cacheDir.list(recursive: true)) {
        if (entity is File) {
          totalSize += await entity.length();
        }
      }

      return totalSize / (1024 * 1024);
    } catch (e) {
      _logger.e('Error calculating cache size: $e');
      return 0;
    }
  }

  Future<void> clearCache() async {
    try {
      final cacheDir = await _getCacheDirectory();
      if (await cacheDir.exists()) {
        await cacheDir.delete(recursive: true);
        await cacheDir.create(recursive: true);
      }
      _logger.i('Cache cleared');
    } catch (e) {
      _logger.e('Error clearing cache: $e');
    }
  }

  Future<Directory> _getCacheDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final cacheDir = Directory('${appDir.path}/map_tiles');

    if (!await cacheDir.exists()) {
      await cacheDir.create(recursive: true);
    }

    return cacheDir;
  }

  Future<void> _downloadTile(TileCoordinate tile, Directory cacheDir) async {
    final url = 'https://tile.openstreetmap.org/${tile.z}/${tile.x}/${tile.y}.png';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final dir = Directory('${cacheDir.path}/${tile.z}/${tile.x}');
      await dir.create(recursive: true);

      final file = File('${dir.path}/${tile.y}.png');
      await file.writeAsBytes(response.bodyBytes);
    } else {
      throw Exception('Failed to download tile: ${response.statusCode}');
    }
  }

  List<TileCoordinate> _calculateTilesToDownload(
    LatLng center,
    double radiusKm,
    int minZoom,
    int maxZoom,
  ) {
    final tiles = <TileCoordinate>[];

    for (int z = minZoom; z <= maxZoom; z++) {
      final centerTile = _latLngToTile(center, z);
      final tilesAcross = _kmToTiles(radiusKm, z);

      for (int x = centerTile.x - tilesAcross; x <= centerTile.x + tilesAcross; x++) {
        for (int y = centerTile.y - tilesAcross; y <= centerTile.y + tilesAcross; y++) {
          if (x >= 0 && y >= 0) {
            tiles.add(TileCoordinate(z: z, x: x, y: y));
          }
        }
      }
    }

    return tiles;
  }

  TileCoordinate _latLngToTile(LatLng latLng, int zoom) {
    final n = 1 << zoom;
    final x = ((latLng.longitude + 180.0) / 360.0 * n).floor();
    final latRad = latLng.latitude * pi / 180.0;
    final y = ((1.0 - log(tan(latRad) + 1 / cos(latRad)) / pi) / 2.0 * n).floor();
    return TileCoordinate(z: zoom, x: x, y: y);
  }

  int _kmToTiles(double km, int zoom) {

    final kmPerTile = 40075 / (1 << zoom);
    return (km / kmPerTile).ceil();
  }
}

class TileCoordinate {
  final int z;
  final int x;
  final int y;

  TileCoordinate({required this.z, required this.x, required this.y});

  @override
  String toString() => 'Tile(z=$z, x=$x, y=$y)';
}

class DownloadProgress {
  final int total;
  final int downloaded;
  final int failed;

  DownloadProgress({
    required this.total,
    required this.downloaded,
    required this.failed,
  });

  double get percentage => total > 0 ? (downloaded / total) * 100 : 0;
  bool get isComplete => downloaded + failed >= total;
}
