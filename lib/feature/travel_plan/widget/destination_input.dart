import 'package:flutter/material.dart';
import '../../../core/model/app_model.dart';
class DestinationInput extends StatefulWidget {
  final String value;
  final Function(String) onChanged;
  final LocationData? currentLocation;
  const DestinationInput({
    super.key,
    required this.value,
    required this.onChanged,
    this.currentLocation,
  });
  @override
  State<DestinationInput> createState() => _DestinationInputState();
}
class _DestinationInputState extends State<DestinationInput> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _popularDestinations = [
    'Tokyo, Japan',
    'Paris, France',
    'New York, USA',
    'London, UK',
    'Rome, Italy',
    'Dubai, UAE',
    'Barcelona, Spain',
    'Bangkok, Thailand',
    'Sydney, Australia',
    'Amsterdam, Netherlands',
  ];
  @override
  void initState() {
    super.initState();
    _controller.text = widget.value;
  }
  @override
  void didUpdateWidget(DestinationInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && widget.value != _controller.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _controller.value = _controller.value.copyWith(
            text: widget.value,
            selection: TextSelection.collapsed(offset: widget.value.length),
          );
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Enter destination (e.g., Tokyo, Japan)',
            prefixIcon: const Icon(Icons.location_on),
            suffixIcon: widget.currentLocation != null
                ? IconButton(
              icon: const Icon(Icons.my_location),
              onPressed: () => _useCurrentLocation(),
              tooltip: 'Use current location',
            )
                : null,
          ),
          textInputAction: TextInputAction.done,
          onChanged: widget.onChanged,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter a destination';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        Text(
          'Popular Destinations',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _popularDestinations.map((destination) {
            return ActionChip(
              label: Text(destination),
              onPressed: () {
                _controller.text = destination;
                widget.onChanged(destination);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
  void _useCurrentLocation() {
    if (widget.currentLocation != null) {
      final location = widget.currentLocation!;
      final locationText = location.city ?? location.address;
      _controller.text = locationText;
      widget.onChanged(locationText);
    }
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}