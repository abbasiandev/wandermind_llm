import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/map_config.dart';
import '../../../core/theme/app_color.dart';

class MapProviderSelector extends ConsumerStatefulWidget {
  final Function()? onProviderChanged;

  const MapProviderSelector({
    super.key,
    this.onProviderChanged,
  });

  @override
  ConsumerState<MapProviderSelector> createState() =>
      _MapProviderSelectorState();
}

class _MapProviderSelectorState extends ConsumerState<MapProviderSelector> {
  MapProvider _selectedProvider = MapConfig.preferredProvider;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Container(
      padding: const EdgeInsets.all(16),
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
              const Icon(Icons.map, color: AppColors.primary),
              const SizedBox(width: 12),
              Text(
                'Map Provider',
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
          const SizedBox(height: 8),
          Text(
            'Current: ${MapConfig.providerName}',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),

          ...MapConfig.availableProviders.map((provider) {
            return _buildProviderOption(provider);
          }).toList(),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(isDark ? 0.15 : 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Map will reload after changing provider',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white70 : AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _applySelection,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: AppColors.primary,
              ),
              child: const Text('Apply'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProviderOption(MapProvider provider) {
    final isSelected = _selectedProvider == provider;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDisabled = provider == MapProvider.mapbox && !MapConfig.isMapboxAvailable;

    IconData icon;
    String subtitle;

    switch (provider) {
      case MapProvider.mapbox:
        icon = Icons.layers;
        subtitle = isDisabled
            ? 'Requires token in .env file'
            : 'Beautiful, detailed maps';
        break;
      case MapProvider.openStreetMap:
        icon = Icons.public;
        subtitle = 'Free, community-driven';
        break;
      case MapProvider.auto:
        icon = Icons.auto_awesome;
        subtitle = 'Uses Mapbox if available, else OSM';
        break;
    }

    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: InkWell(
          onTap: isDisabled ? null : () {
            setState(() {
              _selectedProvider = provider;
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary.withOpacity(isDark ? 0.2 : 0.1)
                  : (isDark ? const Color(0xFF2C2C2C) : Colors.grey[100]),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.transparent,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : (isDark ? Colors.grey[800] : Colors.grey[300]),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        MapConfig.getProviderDisplayName(provider),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isSelected ? AppColors.primary : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.primary,
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _applySelection() async {
    await MapConfig.setPreferredProvider(_selectedProvider);

    if (mounted) {
      Navigator.pop(context);
      widget.onProviderChanged?.call();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Switched to ${MapConfig.getProviderDisplayName(_selectedProvider)}',
          ),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
