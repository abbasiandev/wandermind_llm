import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/route_models.dart';

class DebugRouteWidget extends ConsumerWidget {
  final RouteResult? route;

  const DebugRouteWidget({super.key, this.route});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (route == null) {
      return const Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('No route available'),
        ),
      );
    }

    final routeData = route!;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Route Debug Info',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('Name: ${routeData.name ?? "Unknown"}'),
            Text('Points: ${routeData.points.length}'),
            Text('Steps: ${routeData.steps.length}'),
            Text('Distance: ${(routeData.distanceMeters / 1000).toStringAsFixed(2)} km'),
            Text('Duration: ${(routeData.durationSeconds / 60).toStringAsFixed(0)} min'),
            const SizedBox(height: 8),
            if (routeData.points.isNotEmpty) ...[
              Text('First point: ${routeData.points.first.latitude.toStringAsFixed(5)}, ${routeData.points.first.longitude.toStringAsFixed(5)}'),
              Text('Last point: ${routeData.points.last.latitude.toStringAsFixed(5)}, ${routeData.points.last.longitude.toStringAsFixed(5)}'),
            ],
            const SizedBox(height: 8),
            if (routeData.steps.isNotEmpty) ...[
              const Text('Steps:', style: TextStyle(fontWeight: FontWeight.bold)),
              ...routeData.steps.take(3).map((step) => Padding(
                padding: const EdgeInsets.only(left: 16, top: 4),
                child: Text('${step.index + 1}. ${step.instruction}'),
              )),
              if (routeData.steps.length > 3)
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 4),
                  child: Text('... and ${routeData.steps.length - 3} more steps'),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
