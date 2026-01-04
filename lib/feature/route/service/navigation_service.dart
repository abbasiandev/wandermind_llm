import 'dart:async';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';

import '../model/route_models.dart';
import 'smart_routing_service.dart';

class NavigationService {
  static final Logger _logger = Logger();
  final Distance _distance = const Distance();

  final SmartRoutingService _routingService;

  NavigationState? _currentState;
  RouteResult? _currentRoute;
  StreamController<NavigationState>? _stateController;

  static const double _offRouteThreshold = 50.0;
  static const double _stepCompletionThreshold = 25.0;
  static const int _rerouteDebounceSeconds = 5;

  DateTime? _lastRerouteTime;
  bool _isRerouting = false;

  NavigationService({SmartRoutingService? routingService})
      : _routingService = routingService ?? SmartRoutingService();

  Stream<NavigationState> get navigationStateStream {
    _stateController ??= StreamController<NavigationState>.broadcast();
    return _stateController!.stream;
  }

  NavigationState? get currentState => _currentState;

  void startNavigation(RouteResult route) {
    _logger.i('Starting navigation with ${route.steps.length} steps');

    _currentRoute = route;
    _currentState = NavigationState(
      isNavigating: true,
      currentStep: route.steps.isNotEmpty ? route.steps[0] : null,
      nextStep: route.steps.length > 1 ? route.steps[1] : null,
      currentStepIndex: 0,
      totalDistanceRemaining: route.distanceMeters,
      totalDurationRemaining: route.durationSeconds,
      lastUpdateTime: DateTime.now(),
    );

    _stateController?.add(_currentState!);
  }

  Future<void> updateLocation(LatLng currentLocation) async {
    if (_currentState == null || !_currentState!.isNavigating || _currentRoute == null) {
      return;
    }

    final now = DateTime.now();

    final distanceToNextStep = _currentState!.currentStep != null
        ? _distance(currentLocation, _currentState!.currentStep!.location)
        : 0.0;

    final totalRemaining = _calculateRemainingDistance(currentLocation);

    final isOffRoute = _checkIfOffRoute(currentLocation);

    if (isOffRoute && !_isRerouting) {
      await _handleOffRoute(currentLocation);
      return;
    }

    if (_currentState!.currentStep != null &&
        distanceToNextStep < _stepCompletionThreshold) {
      _advanceToNextStep();
    }

    _currentState = _currentState!.copyWith(
      distanceToNextStep: distanceToNextStep,
      totalDistanceRemaining: totalRemaining,
      totalDurationRemaining: _estimateRemainingDuration(totalRemaining),
      isOffRoute: isOffRoute,
      lastUpdateTime: now,
    );

    _stateController?.add(_currentState!);
  }

  bool _checkIfOffRoute(LatLng currentLocation) {
    if (_currentRoute == null || _currentRoute!.points.isEmpty) {
      return false;
    }

    double minDistance = double.infinity;

    for (int i = 0; i < _currentRoute!.points.length - 1; i++) {
      final segmentDistance = _distanceToSegment(
        currentLocation,
        _currentRoute!.points[i],
        _currentRoute!.points[i + 1],
      );

      if (segmentDistance < minDistance) {
        minDistance = segmentDistance;
      }
    }

    final isOff = minDistance > _offRouteThreshold;

    if (isOff) {
      _logger.w('User is off route: ${minDistance.toStringAsFixed(1)}m from route');
    }

    return isOff;
  }

  double _distanceToSegment(LatLng point, LatLng lineStart, LatLng lineEnd) {
    final x = point.longitude;
    final y = point.latitude;
    final x1 = lineStart.longitude;
    final y1 = lineStart.latitude;
    final x2 = lineEnd.longitude;
    final y2 = lineEnd.latitude;

    final A = x - x1;
    final B = y - y1;
    final C = x2 - x1;
    final D = y2 - y1;

    final dot = A * C + B * D;
    final lenSq = C * C + D * D;
    double param = -1;

    if (lenSq != 0) {
      param = dot / lenSq;
    }

    double xx, yy;

    if (param < 0) {
      xx = x1;
      yy = y1;
    } else if (param > 1) {
      xx = x2;
      yy = y2;
    } else {
      xx = x1 + param * C;
      yy = y1 + param * D;
    }

    final pointOnSegment = LatLng(yy, xx);
    return _distance(point, pointOnSegment);
  }

  Future<void> _handleOffRoute(LatLng currentLocation) async {
    final now = DateTime.now();

    if (_lastRerouteTime != null &&
        now.difference(_lastRerouteTime!).inSeconds < _rerouteDebounceSeconds) {
      _logger.d('Rerouting debounced');
      return;
    }

    _logger.i('Initiating reroute from current location');
    _isRerouting = true;
    _lastRerouteTime = now;

    _currentState = _currentState!.copyWith(
      isOffRoute: true,
      isRerouting: true,
    );
    _stateController?.add(_currentState!);

    try {
      final destination = _currentRoute!.points.last;

      final newRoute = await _routingService.getRoute(
        start: currentLocation,
        end: destination,
        type: _currentRoute!.type,
      );

      _currentRoute = newRoute;

      _currentState = NavigationState(
        isNavigating: true,
        currentStep: newRoute.steps.isNotEmpty ? newRoute.steps[0] : null,
        nextStep: newRoute.steps.length > 1 ? newRoute.steps[1] : null,
        currentStepIndex: 0,
        totalDistanceRemaining: newRoute.distanceMeters,
        totalDurationRemaining: newRoute.durationSeconds,
        isOffRoute: false,
        isRerouting: false,
        lastUpdateTime: DateTime.now(),
      );

      _stateController?.add(_currentState!);
      _logger.i('Successfully rerouted');

    } catch (e) {
      _logger.e('Failed to reroute: $e');

      _currentState = _currentState!.copyWith(
        isRerouting: false,
      );
      _stateController?.add(_currentState!);
    } finally {
      _isRerouting = false;
    }
  }

  void _advanceToNextStep() {
    if (_currentRoute == null || _currentState == null) return;

    final nextIndex = _currentState!.currentStepIndex + 1;

    if (nextIndex >= _currentRoute!.steps.length) {
      _logger.i('Navigation completed - arrived at destination');
      stopNavigation();
      return;
    }

    final nextNextIndex = nextIndex + 1;

    _currentState = _currentState!.copyWith(
      currentStepIndex: nextIndex,
      currentStep: _currentRoute!.steps[nextIndex],
      nextStep: nextNextIndex < _currentRoute!.steps.length
          ? _currentRoute!.steps[nextNextIndex]
          : null,
    );

    _logger.d('Advanced to step $nextIndex: ${_currentState!.currentStep?.instruction}');
    _stateController?.add(_currentState!);
  }

  double _calculateRemainingDistance(LatLng currentLocation) {
    if (_currentRoute == null || _currentState == null) return 0.0;

    double remaining = 0.0;

    final currentStepIndex = _currentState!.currentStepIndex;
    for (int i = currentStepIndex; i < _currentRoute!.steps.length; i++) {
      remaining += _currentRoute!.steps[i].distanceMeters;
    }

    if (_currentState!.currentStep != null) {
      final distanceToCurrentStep = _distance(
        currentLocation,
        _currentState!.currentStep!.location,
      );
      remaining += distanceToCurrentStep;
    }

    return remaining;
  }

  double _estimateRemainingDuration(double remainingDistance) {
    if (remainingDistance == 0) return 0.0;

    const averageSpeedKmh = 40.0;
    const averageSpeedMps = averageSpeedKmh * 1000 / 3600;

    return remainingDistance / averageSpeedMps;
  }

  void stopNavigation() {
    _logger.i('Stopping navigation');

    _currentState = NavigationState(
      isNavigating: false,
      lastUpdateTime: DateTime.now(),
    );

    _stateController?.add(_currentState!);

    _currentRoute = null;
  }

  String getVoiceInstruction() {
    if (_currentState == null || _currentState!.currentStep == null) {
      return '';
    }

    final step = _currentState!.currentStep!;
    final distance = _currentState!.distanceToNextStep;

    if (distance > 800) {
      return 'In ${(distance / 1000).toStringAsFixed(1)} kilometers, ${step.instruction}';
    } else if (distance > 400) {
      return 'In ${distance.toStringAsFixed(0)} meters, ${step.instruction}';
    } else if (distance > 100) {
      return 'In ${distance.toStringAsFixed(0)} meters, ${step.instruction}';
    } else if (distance > 50) {
      return 'In ${distance.toStringAsFixed(0)} meters, ${step.instruction}';
    } else {
      return step.instruction;
    }
  }

  bool shouldAnnounceInstruction(double previousDistance, double currentDistance) {
    final thresholds = [800.0, 400.0, 200.0, 100.0, 50.0];

    for (final threshold in thresholds) {
      if (previousDistance > threshold && currentDistance <= threshold) {
        return true;
      }
    }

    return false;
  }

  void dispose() {
    _stateController?.close();
    _stateController = null;
    _routingService.dispose();
  }
}
