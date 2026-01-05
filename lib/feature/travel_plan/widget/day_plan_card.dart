import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/model/app_model.dart';
import '../../../core/theme/app_color.dart';
class DayPlanCard extends StatelessWidget {
  final DayPlan dayPlan;
  final Function(Activity) onActivityTap;
  const DayPlanCard({
    super.key,
    required this.dayPlan,
    required this.onActivityTap,
  });
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEEE, MMM dd');
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Day ${dayPlan.dayNumber}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dateFormat.format(dayPlan.date),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                if (dayPlan.overview.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    dayPlan.overview,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dayPlan.activities.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final activity = dayPlan.activities[index];
              return _ActivityTile(
                activity: activity,
                onTap: () => onActivityTap(activity),
              );
            },
          ),
        ],
      ),
    );
  }
}
class _ActivityTile extends StatelessWidget {
  final Activity activity;
  final VoidCallback onTap;
  const _ActivityTile({
    required this.activity,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat('h:mm a');
    return ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: _getActivityColor(activity.type).withOpacity(0.2),
          child: Icon(
            _getActivityIcon(activity.type),
            color: _getActivityColor(activity.type),
          ),
        ),
        title: Text(activity.title),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const SizedBox(height: 4),
        Row(
            children: [
            Icon(Icons.access_time, size: 14),
        const SizedBox(width: 4),
              Text(
                '${timeFormat.format(activity.timeSlot.startTime)} - ${timeFormat.format(activity.timeSlot.endTime)}',
              ),
            ],
        ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Icon(Icons.location_on, size: 14),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      activity.location,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
        ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${activity.cost.toStringAsFixed(0)}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
  IconData _getActivityIcon(ActivityType type) {
    switch (type) {
      case ActivityType.sightseeing:
        return Icons.camera_alt;
      case ActivityType.food:
        return Icons.restaurant;
      case ActivityType.shopping:
        return Icons.shopping_bag;
      case ActivityType.entertainment:
        return Icons.theater_comedy;
      case ActivityType.transportation:
        return Icons.directions_car;
      case ActivityType.accommodation:
        return Icons.hotel;
      case ActivityType.adventure:
        return Icons.hiking;
      case ActivityType.relaxation:
        return Icons.spa;
      case ActivityType.culture:
        return Icons.museum;
      case ActivityType.nightlife:
        return Icons.nightlife;
    }
  }
  Color _getActivityColor(ActivityType type) {
    switch (type) {
      case ActivityType.sightseeing:
        return AppColors.primary;
      case ActivityType.food:
        return AppColors.food;
      case ActivityType.shopping:
        return AppColors.warning;
      case ActivityType.entertainment:
        return AppColors.secondary;
      case ActivityType.transportation:
        return AppColors.transport;
      case ActivityType.accommodation:
        return AppColors.hotel;
      case ActivityType.adventure:
        return AppColors.activity;
      case ActivityType.relaxation:
        return AppColors.info;
      case ActivityType.culture:
        return AppColors.accent;
      case ActivityType.nightlife:
        return AppColors.transport;
    }
  }
}