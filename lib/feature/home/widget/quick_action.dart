import 'package:flutter/material.dart';
import '../../../core/theme/app_color.dart';

class QuickActions extends StatelessWidget {
  final VoidCallback onCreatePlan;
  final VoidCallback onChat;
  final VoidCallback onExplore;
  final VoidCallback onSettings;

  const QuickActions({
    super.key,
    required this.onCreatePlan,
    required this.onChat,
    required this.onExplore,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickActionCard(
            icon: Icons.add_circle_outline,
            label: 'Create Plan',
            color: AppColors.primary,
            onTap: onCreatePlan,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickActionCard(
            icon: Icons.chat_bubble_outline,
            label: 'Chat',
            color: AppColors.accent,
            onTap: onChat,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickActionCard(
            icon: Icons.explore_outlined,
            label: 'Explore',
            color: AppColors.secondary,
            onTap: onExplore,
          ),
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.3),
          ),
          color: color.withOpacity(0.1),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}