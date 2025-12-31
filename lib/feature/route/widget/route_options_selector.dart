import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_color.dart';
import '../model/route_models.dart';

/// Widget to select between multiple route options
class RouteOptionsSelector extends ConsumerStatefulWidget {
  final List<RouteResult> routes;
  final RouteResult? selectedRoute;
  final Function(RouteResult) onRouteSelected;

  const RouteOptionsSelector({
    super.key,
    required this.routes,
    this.selectedRoute,
    required this.onRouteSelected,
  });

  @override
  ConsumerState<RouteOptionsSelector> createState() =>
      _RouteOptionsSelectorState();
}

class _RouteOptionsSelectorState extends ConsumerState<RouteOptionsSelector> {
  @override
  Widget build(BuildContext context) {
    if (widget.routes.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 140,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: widget.routes.length,
        itemBuilder: (context, index) {
          final route = widget.routes[index];
          final isSelected = widget.selectedRoute?.type == route.type;
          
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _buildRouteCard(route, isSelected),
          );
        },
      ),
    );
  }

  Widget _buildRouteCard(RouteResult route, bool isSelected) {
    final distanceKm = (route.distanceMeters / 1000).toStringAsFixed(1);
    final durationMin = (route.durationSeconds / 60).ceil();
    
    IconData icon;
    Color color;
    
    switch (route.type) {
      case RouteType.fastest:
        icon = Icons.speed;
        color = Colors.blue;
        break;
      case RouteType.shortest:
        icon = Icons.straighten;
        color = Colors.green;
        break;
      case RouteType.balanced:
        icon = Icons.balance;
        color = Colors.orange;
        break;
    }

    return GestureDetector(
      onTap: () => widget.onRouteSelected(route),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  icon,
                  color: isSelected ? color : AppColors.textSecondary,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    route.name ?? _getRouteName(route.type),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: isSelected ? color : AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: color,
                    size: 16,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Distance
            Row(
              children: [
                Icon(
                  Icons.route,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  '$distanceKm km',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            
            // Duration
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  _formatDuration(durationMin),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getRouteName(RouteType type) {
    switch (type) {
      case RouteType.fastest:
        return 'Fastest';
      case RouteType.shortest:
        return 'Shortest';
      case RouteType.balanced:
        return 'Balanced';
    }
  }

  String _getRouteBadge(RouteType type) {
    switch (type) {
      case RouteType.fastest:
        return 'Quick';
      case RouteType.shortest:
        return 'Less distance';
      case RouteType.balanced:
        return 'Recommended';
    }
  }

  String _formatDuration(int minutes) {
    if (minutes < 60) {
      return '$minutes min';
    } else {
      final hours = minutes ~/ 60;
      final mins = minutes % 60;
      return '${hours}h ${mins}m';
    }
  }
}
