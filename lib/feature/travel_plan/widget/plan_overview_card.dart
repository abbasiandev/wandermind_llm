import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/model/app_model.dart';
import '../../../core/theme/app_color.dart';
class PlanOverviewCard extends StatelessWidget {
  final TravelPlan plan;
  const PlanOverviewCard({
    super.key,
    required this.plan,
  });
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final duration = plan.endDate.difference(plan.startDate).inDays + 1;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trip Overview',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              context,
              Icons.location_on,
              'Destination',
              plan.destination,
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              Icons.calendar_today,
              'Dates',
              '${dateFormat.format(plan.startDate)} - ${dateFormat.format(plan.endDate)}',
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              Icons.access_time,
              'Duration',
              '$duration ${duration == 1 ? 'day' : 'days'}',
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              Icons.attach_money,
              'Budget',
              '\$${plan.budget.toStringAsFixed(2)}',
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              Icons.event,
              'Activities',
              '${plan.days.fold(0, (sum, day) => sum + day.activities.length)} planned',
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildInfoRow(
      BuildContext context,
      IconData icon,
      String label,
      String value,
      ) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withOpacity(0.7),
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}