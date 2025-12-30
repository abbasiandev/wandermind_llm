import 'package:flutter/material.dart';
import '../../../core/model/app_model.dart';
import '../../../core/theme/app_color.dart';

class BudgetBreakdownCard extends StatelessWidget {
  final TravelPlan plan;

  const BudgetBreakdownCard({
    super.key,
    required this.plan,
  });

  @override
  Widget build(BuildContext context) {
    final totalSpent = plan.days.fold(
      0.0,
          (sum, day) => sum + day.estimatedCost,
    );
    final remaining = plan.budget - totalSpent;
    final percentageUsed = (totalSpent / plan.budget * 100).clamp(0, 100);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Budget Overview',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: percentageUsed / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                percentageUsed > 90 ? Colors.red : AppColors.primary,
              ),
              minHeight: 10,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBudgetItem(
                  context,
                  'Total Budget',
                  '\$${plan.budget.toStringAsFixed(2)}',
                  AppColors.primary,
                ),
                _buildBudgetItem(
                  context,
                  'Spent',
                  '\$${totalSpent.toStringAsFixed(2)}',
                  percentageUsed > 90 ? Colors.red : AppColors.accent,
                ),
                _buildBudgetItem(
                  context,
                  'Remaining',
                  '\$${remaining.toStringAsFixed(2)}',
                  remaining < 0 ? Colors.red : AppColors.success,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetItem(
      BuildContext context,
      String label,
      String amount,
      Color color,
      ) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}