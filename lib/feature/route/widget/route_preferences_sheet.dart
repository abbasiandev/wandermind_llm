import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_color.dart';
import '../model/route_models.dart';

class RoutePreferencesSheet extends ConsumerStatefulWidget {
  final RoutePreferences initialPreferences;
  final Function(RoutePreferences) onApply;

  const RoutePreferencesSheet({
    super.key,
    required this.initialPreferences,
    required this.onApply,
  });

  @override
  ConsumerState<RoutePreferencesSheet> createState() =>
      _RoutePreferencesSheetState();
}

class _RoutePreferencesSheetState
    extends ConsumerState<RoutePreferencesSheet> {
  late RoutePreferences _preferences;

  @override
  void initState() {
    super.initState();
    _preferences = widget.initialPreferences;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final surfaceColor = isDark ? const Color(0xFF2C2C2C) : Colors.grey[100]!;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              const Icon(Icons.tune, color: AppColors.primary),
              const SizedBox(width: 12),
              Text(
                'Route Preferences',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 24),

          Text(
            'Route Type',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          _buildRouteTypeSelector(),

          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 24),

          Text(
            'Avoid',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),

          _buildAvoidOption(
            icon: Icons.traffic,
            title: 'Highways',
            subtitle: 'Use local roads instead',
            value: _preferences.avoidHighways,
            onChanged: (value) {
              setState(() {
                _preferences = _preferences.copyWith(avoidHighways: value);
              });
            },
          ),

          _buildAvoidOption(
            icon: Icons.toll,
            title: 'Tolls',
            subtitle: 'Avoid toll roads',
            value: _preferences.avoidTolls,
            onChanged: (value) {
              setState(() {
                _preferences = _preferences.copyWith(avoidTolls: value);
              });
            },
          ),

          _buildAvoidOption(
            icon: Icons.directions_boat,
            title: 'Ferries',
            subtitle: 'Avoid ferry crossings',
            value: _preferences.avoidFerries,
            onChanged: (value) {
              setState(() {
                _preferences = _preferences.copyWith(avoidFerries: value);
              });
            },
          ),

          _buildAvoidOption(
            icon: Icons.terrain,
            title: 'Unpaved Roads',
            subtitle: 'Stick to paved roads',
            value: _preferences.avoidUnpaved,
            onChanged: (value) {
              setState(() {
                _preferences = _preferences.copyWith(avoidUnpaved: value);
              });
            },
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onApply(_preferences);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: AppColors.primary,
              ),
              child: const Text('Apply Preferences'),
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildRouteTypeSelector() {
    return Row(
      children: [
        Expanded(
          child: _buildRouteTypeChip(
            type: RouteType.fastest,
            icon: Icons.speed,
            label: 'Fastest',
            description: 'Quickest time',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildRouteTypeChip(
            type: RouteType.shortest,
            icon: Icons.straighten,
            label: 'Shortest',
            description: 'Less distance',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildRouteTypeChip(
            type: RouteType.balanced,
            icon: Icons.balance,
            label: 'Balanced',
            description: 'Mix of both',
          ),
        ),
      ],
    );
  }

  Widget _buildRouteTypeChip({
    required RouteType type,
    required IconData icon,
    required String label,
    required String description,
  }) {
    final isSelected = _preferences.preferredType == type;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final unselectedBg = isDark ? const Color(0xFF2C2C2C) : Colors.grey[100]!;
    final unselectedBorder = isDark ? Colors.grey[700]! : Colors.grey[300]!;

    return GestureDetector(
      onTap: () {
        setState(() {
          _preferences = _preferences.copyWith(preferredType: type);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : unselectedBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : unselectedBorder,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : AppColors.textSecondary,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                color: isSelected ? Colors.white70 : AppColors.textSecondary,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvoidOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(isDark ? 0.2 : 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
