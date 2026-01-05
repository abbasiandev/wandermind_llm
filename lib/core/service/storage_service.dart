import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
class StorageService {
  static final Logger _logger = Logger();
  final HiveInterface _hive;
  StorageService(this._hive);
  Future<void> initialize() async {
    try {
      _logger.i('Initializing storage service...');
      _logger.i('Storage service initialized');
    } catch (e) {
      _logger.e('Failed to initialize storage service: $e');
      rethrow;
    }
  }
  Future<Box> openBox(String boxName) async {
    try {
      if (_hive.isBoxOpen(boxName)) {
        return _hive.box(boxName);
      }
      return await _hive.openBox(boxName);
    } catch (e) {
      _logger.e('Failed to open box $boxName: $e');
      rethrow;
    }
  }
  Future<void> closeBox(String boxName) async {
    try {
      if (_hive.isBoxOpen(boxName)) {
        await _hive.box(boxName).close();
      }
    } catch (e) {
      _logger.e('Failed to close box $boxName: $e');
    }
  }
  Future<void> clearBox(String boxName) async {
    try {
      final box = await openBox(boxName);
      await box.clear();
      _logger.d('Cleared box: $boxName');
    } catch (e) {
      _logger.e('Failed to clear box $boxName: $e');
      rethrow;
    }
  }
  Future<void> deleteBox(String boxName) async {
    try {
      await _hive.deleteBoxFromDisk(boxName);
      _logger.d('Deleted box: $boxName');
    } catch (e) {
      _logger.e('Failed to delete box $boxName: $e');
      rethrow;
    }
  }
}