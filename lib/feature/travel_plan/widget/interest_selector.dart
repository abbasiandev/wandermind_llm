import 'package:flutter/material.dart';
import '../../../core/theme/app_color.dart';

class InterestsSelector extends StatelessWidget {
  final List<String> selectedInterests;
  final Function(List<String>) onChanged;

  const InterestsSelector({
    super.key,
    required this.selectedInterests,
    required this.onChanged,
  });

  static const List<InterestOption> _interestOptions = [
    InterestOption(
      id: 'culture',
      label: 'Culture & History',
      icon: Icons.museum,
      color: AppColors.primary,
    ),
    InterestOption(
      id: 'food',
      label: 'Food & Dining',
      icon: Icons.restaurant,
      color: AppColors.food,
    ),
    InterestOption(
      id: 'adventure',
      label: 'Adventure',
      icon: Icons.hiking,
      color: AppColors.success,
    ),
    InterestOption(
      id: 'relaxation',
      label: 'Relaxation',
      icon: Icons.spa,
      color: AppColors.info,
    ),
    InterestOption(
      id: 'nightlife',
      label: 'Nightlife',
      icon: Icons.nightlife,
      color: AppColors.transport,
    ),
    InterestOption(
      id: 'shopping',
      label: 'Shopping',
      icon: Icons.shopping_bag,
      color: AppColors.warning,
    ),
    InterestOption(
      id: 'nature',
      label: 'Nature & Parks',
      icon: Icons.nature,
      color: AppColors.accent,
    ),
    InterestOption(
      id: 'art',
      label: 'Art & Galleries',
      icon: Icons.palette,
      color: AppColors.secondary,
    ),
    InterestOption(
      id: 'architecture',
      label: 'Architecture',
      icon: Icons.architecture,
      color: AppColors.textSecondary,
    ),
    InterestOption(
      id: 'photography',
      label: 'Photography',
      icon: Icons.camera_alt,
      color: AppColors.primary,
    ),
    InterestOption(
      id: 'sports',
      label: 'Sports & Activities',
      icon: Icons.sports,
      color: AppColors.success,
    ),
    InterestOption(
      id: 'music',
      label: 'Music & Shows',
      icon: Icons.music_note,
      color: AppColors.transport,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select at least 3 interests to get personalized recommendations',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 12),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3.5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _interestOptions.length,
          itemBuilder: (context, index) {
            final option = _interestOptions[index];
            final isSelected = selectedInterests.contains(option.id);

            return InkWell(
              onTap: () => _toggleInterest(option.id),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? option.color
                        : Theme.of(context).colorScheme.outline.withOpacity(0.5),
                    width: isSelected ? 2 : 1,
                  ),
                  color: isSelected
                      ? option.color.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      option.icon,
                      size: 20,
                      color: isSelected
                          ? option.color
                          : Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        option.label,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isSelected
                              ? option.color
                              : Theme.of(context).colorScheme.onBackground,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 12),

        // Selection indicator
        Row(
          children: [
            Icon(
              selectedInterests.length >= 3 ? Icons.check_circle : Icons.info,
              size: 16,
              color: selectedInterests.length >= 3
                  ? AppColors.success
                  : AppColors.warning,
            ),
            const SizedBox(width: 8),
            Text(
              '${selectedInterests.length} selected ${selectedInterests.length >= 3 ? '✓' : '(minimum 3)'}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: selectedInterests.length >= 3
                    ? AppColors.success
                    : AppColors.warning,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _toggleInterest(String interestId) {
    final newInterests = List<String>.from(selectedInterests);

    if (newInterests.contains(interestId)) {
      newInterests.remove(interestId);
    } else {
      newInterests.add(interestId);
    }

    onChanged(newInterests);
  }
}

class InterestOption {
  final String id;
  final String label;
  final IconData icon;
  final Color color;

  const InterestOption({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
  });
}