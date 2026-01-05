import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/theme/app_color.dart';
import '../model/route_models.dart';
class WaypointsManager extends ConsumerStatefulWidget {
  final List<Waypoint> waypoints;
  final Function(List<Waypoint>) onWaypointsChanged;
  final Function(LatLng)? onWaypointTap;
  const WaypointsManager({
    super.key,
    required this.waypoints,
    required this.onWaypointsChanged,
    this.onWaypointTap,
  });
  @override
  ConsumerState<WaypointsManager> createState() => _WaypointsManagerState();
}
class _WaypointsManagerState extends ConsumerState<WaypointsManager> {
  late List<Waypoint> _waypoints;
  @override
  void initState() {
    super.initState();
    _waypoints = List.from(widget.waypoints);
  }
  @override
  void didUpdateWidget(WaypointsManager oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.waypoints != oldWidget.waypoints) {
      _waypoints = List.from(widget.waypoints);
    }
  }
  void _addWaypoint(LatLng location) {
    final newWaypoint = Waypoint(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      location: location,
      name: 'Stop ${_waypoints.length + 1}',
      order: _waypoints.length,
    );
    setState(() {
      _waypoints.add(newWaypoint);
    });
    widget.onWaypointsChanged(_waypoints);
  }
  void _removeWaypoint(String id) {
    setState(() {
      _waypoints.removeWhere((w) => w.id == id);
      for (int i = 0; i < _waypoints.length; i++) {
        _waypoints[i] = _waypoints[i].copyWith(
          order: i,
          name: 'Stop ${i + 1}',
        );
      }
    });
    widget.onWaypointsChanged(_waypoints);
  }
  void _reorderWaypoints(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _waypoints.removeAt(oldIndex);
      _waypoints.insert(newIndex, item);
      for (int i = 0; i < _waypoints.length; i++) {
        _waypoints[i] = _waypoints[i].copyWith(
          order: i,
          name: 'Stop ${i + 1}',
        );
      }
    });
    widget.onWaypointsChanged(_waypoints);
  }
  void _optimizeRoute() {
    if (_waypoints.length <= 1) return;
    setState(() {
      final optimized = <Waypoint>[_waypoints.first];
      final remaining = List<Waypoint>.from(_waypoints.skip(1));
      while (remaining.isNotEmpty) {
        final current = optimized.last;
        remaining.sort((a, b) {
          final distA = const Distance()(current.location, a.location);
          final distB = const Distance()(current.location, b.location);
          return distA.compareTo(distB);
        });
        optimized.add(remaining.removeAt(0));
      }
      _waypoints = optimized;
      for (int i = 0; i < _waypoints.length; i++) {
        _waypoints[i] = _waypoints[i].copyWith(order: i);
      }
    });
    widget.onWaypointsChanged(_waypoints);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Route optimized!'),
        backgroundColor: AppColors.success,
        duration: Duration(seconds: 2),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    if (_waypoints.isEmpty) {
      return _buildEmptyState();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.route, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'Waypoints (${_waypoints.length})',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              if (_waypoints.length > 1)
                TextButton.icon(
                  onPressed: _optimizeRoute,
                  icon: const Icon(Icons.auto_fix_high, size: 16),
                  label: const Text('Optimize'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ReorderableListView.builder(
            itemCount: _waypoints.length,
            onReorder: _reorderWaypoints,
            itemBuilder: (context, index) {
              final waypoint = _waypoints[index];
              return _buildWaypointItem(waypoint, index, key: ValueKey(waypoint.id));
            },
          ),
        ),
      ],
    );
  }
  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add_location_alt,
              size: 48,
              color: AppColors.textSecondary.withOpacity(0.5),
            ),
            const SizedBox(height: 12),
            Text(
              'No waypoints added',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Tap on map to add stops',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildWaypointItem(Waypoint waypoint, int index, {required Key key}) {
    return Dismissible(
      key: key,
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: AppColors.error,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => _removeWaypoint(waypoint.id),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: ListTile(
          leading: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          title: Text(
            waypoint.name ?? 'Waypoint ${index + 1}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          subtitle: Text(
            '${waypoint.location.latitude.toStringAsFixed(4)}, ${waypoint.location.longitude.toStringAsFixed(4)}',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (waypoint.isCompleted)
                const Icon(Icons.check_circle, color: AppColors.success, size: 20),
              const SizedBox(width: 8),
              const Icon(Icons.drag_handle, color: AppColors.textSecondary),
            ],
          ),
          onTap: () {
            widget.onWaypointTap?.call(waypoint.location);
          },
        ),
      ),
    );
  }
}