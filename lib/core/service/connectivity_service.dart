import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';

class ConnectivityService {
  static final Logger _logger = Logger();
  final Connectivity _connectivity;

  ConnectivityService(this._connectivity);

  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result != ConnectivityResult.none;
    } catch (e) {
      _logger.e('Failed to check connectivity: $e');
      return false;
    }
  }

  Stream<ConnectivityResult> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged;
  }

  Future<ConnectivityResult> checkConnectivity() async {
    try {
      return await _connectivity.checkConnectivity();
    } catch (e) {
      _logger.e('Failed to check connectivity: $e');
      return ConnectivityResult.none;
    }
  }
}