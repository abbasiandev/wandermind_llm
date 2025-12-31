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
            Text('Name: ${route.name ?? "Unknown"}'),
            Text('Points: ${route.points.length}'),
            Text('Steps: ${route.steps.length}'),
            Text('Distance: ${(route.distanceMeters / 1000).toStringAsFixed(2)} km'),
            Text('Duration: ${(route.durationSeconds / 60).toStringAsFixed(0)} min'),
            const SizedBox(height: 8),
            if (route.points.length > 0) ...[
              Text('First point: ${route.points.first.latitude.toStringAsFixed(5)}, ${route.points.first.longitude.toStringAsFixed(5)}'),
              Text('Last point: ${route.points.last.latitude.toStringAsFixed(5)}, ${route.points.last.longitude.toStringAsFixed(5)}'),
            ],
            const SizedBox(height: 8),
            if (route.steps.isNotEmpty) ...[
              const Text('Steps:', style: TextStyle(fontWeight: FontWeight.bold)),
              ...route.steps.take(3).map((step) => Padding(
                padding: const EdgeInsets.only(left: 16, top: 4),
                child: Text('${step.index + 1}. ${step.instruction}'),
              )),
              if (route.steps.length > 3)
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 4),
                  child: Text('... and ${route.steps.length - 3} more steps'),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
