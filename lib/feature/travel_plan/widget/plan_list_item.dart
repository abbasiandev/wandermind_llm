import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/model/app_model.dart';
class PlanListItem extends StatelessWidget {
  final TravelPlan plan;
  final VoidCallback onTap;
  const PlanListItem({
    super.key,
    required this.plan,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final duration = plan.endDate.difference(plan.startDate).inDays + 1;
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      plan.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16),
                  const SizedBox(width: 4),
                  Text(plan.destination),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '${dateFormat.format(plan.startDate)} - ${dateFormat.format(plan.endDate)} ($duration days)',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}