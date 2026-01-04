import 'package:latlong2/latlong.dart';
import 'smart_routing_service.dart';

Future<void> testRouting() async {
  print('\n🧪 TESTING ROUTING SERVICE\n');

  final service = SmartRoutingService();

  final start = LatLng(25.2048, 55.2708);
  final end = LatLng(25.1972, 55.2744);

  print('📍 Testing route from Dubai Marina to Dubai Mall');
  print('   Start: $start');
  print('   End: $end');
  print('');

  try {
    print('⏳ Requesting route...');
    final route = await service.getRoute(
      start: start,
      end: end,
    );

    print('\n✅ SUCCESS! Route received:');
    print('   Name: ${route.name}');
    print('   Points: ${route.points.length}');
    print('   Steps: ${route.steps.length}');
    print('   Distance: ${(route.distanceMeters / 1000).toStringAsFixed(2)} km');
    print('   Duration: ${(route.durationSeconds / 60).toStringAsFixed(0)} minutes');
    print('');

    if (route.points.length > 2) {
      print('✅ GOOD: Route has ${route.points.length} points (following streets)');
      print('');
      print('📍 First 5 points:');
      for (int i = 0; i < 5 && i < route.points.length; i++) {
        print('   $i: ${route.points[i].latitude.toStringAsFixed(6)}, ${route.points[i].longitude.toStringAsFixed(6)}');
      }
    } else {
      print('❌ BAD: Route only has ${route.points.length} points (straight line fallback)');
    }

    print('');
    print('🗺️  Navigation steps:');
    for (int i = 0; i < route.steps.length && i < 5; i++) {
      print('   ${i + 1}. ${route.steps[i].instruction}');
    }
    if (route.steps.length > 5) {
      print('   ... and ${route.steps.length - 5} more steps');
    }

  } catch (e) {
    print('\n❌ ERROR: $e');
    print('\nPossible causes:');
    print('  - No internet connection');
    print('  - API server is down');
    print('  - Invalid coordinates');
  }

  print('\n🧪 TEST COMPLETE\n');
  service.dispose();
}
