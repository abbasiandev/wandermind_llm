import 'package:flutter/material.dart';
import '../../../core/theme/app_color.dart';
import '../model/scenic_route_preferences.dart';

class ScenicRouteSelector extends StatelessWidget {
  final ScenicMode selectedMode;
  final Function(ScenicMode) onModeChanged;

  const ScenicRouteSelector({
    super.key,
    required this.selectedMode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Route Style',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...ScenicMode.values.map((mode) {
          final isSelected = mode == selectedMode;
          return ListTile(
            leading: Radio<ScenicMode>(
              value: mode,
              groupValue: selectedMode,
              onChanged: (value) {
                if (value != null) onModeChanged(value);
              },
            ),
            title: Row(
              children: [
                Icon(_getModeIcon(mode), size: 20),
                const SizedBox(width: 8),
                Text(
                  mode.displayName,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
            subtitle: Text(mode.description),
            selected: isSelected,
            selectedTileColor: AppColors.primary.withOpacity(0.1),
            onTap: () => onModeChanged(mode),
          );
        }),
      ],
    );
  }

  IconData _getModeIcon(ScenicMode mode) {
    switch (mode) {
      case ScenicMode.direct:
        return Icons.arrow_forward;
      case ScenicMode.balanced:
        return Icons.balance;
      case ScenicMode.scenic:
        return Icons.landscape;
      case ScenicMode.exploration:
        return Icons.explore;
      case ScenicMode.spiral:
        return Icons.all_inclusive;
    }
  }
}

class ScenicRouteSelectorSheet extends StatefulWidget {
  final ScenicMode initialMode;
  final Function(ScenicMode) onModeSelected;

  const ScenicRouteSelectorSheet({
    super.key,
    required this.initialMode,
    required this.onModeSelected,
  });

  @override
  State<ScenicRouteSelectorSheet> createState() => _ScenicRouteSelectorSheetState();
}

class _ScenicRouteSelectorSheetState extends State<ScenicRouteSelectorSheet> {
  late ScenicMode _selectedMode;

  @override
  void initState() {
    super.initState();
    _selectedMode = widget.initialMode;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          ScenicRouteSelector(
            selectedMode: _selectedMode,
            onModeChanged: (mode) {
              setState(() => _selectedMode = mode);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onModeSelected(_selectedMode);
                      Navigator.pop(context);
                    },
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
