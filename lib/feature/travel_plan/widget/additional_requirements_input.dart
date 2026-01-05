import 'package:flutter/material.dart';
class AdditionalRequirementsInput extends StatefulWidget {
  final String value;
  final Function(String) onChanged;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  const AdditionalRequirementsInput({
    super.key,
    required this.value,
    required this.onChanged,
    this.maxLength = 500,
    this.minLines = 3,
    this.maxLines = 6,
  });
  @override
  State<AdditionalRequirementsInput> createState() =>
      _AdditionalRequirementsInputState();
}
class _AdditionalRequirementsInputState
    extends State<AdditionalRequirementsInput> {
  final TextEditingController _controller = TextEditingController();
  bool _showSuggestions = true;
  final List<String> _quickSuggestions = [
    'Family-friendly activities',
    'Pet-friendly accommodations',
    'Wheelchair accessible',
    'Vegetarian/Vegan dining options',
    'Budget-conscious travel',
    'Off-the-beaten-path experiences',
    'Photography spots',
    'Local authentic experiences',
    'Romantic getaway',
    'Adventure activities',
    'Cultural immersion',
    'Relaxation and spa',
  ];
  @override
  void initState() {
    super.initState();
    _controller.text = widget.value;
  }
  @override
  void didUpdateWidget(AdditionalRequirementsInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _controller.text = widget.value;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _controller,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          decoration: InputDecoration(
            hintText: 'E.g., "I need wheelchair accessible hotels, prefer morning activities, '
                'traveling with kids aged 5 and 8"',
            helperText: 'Be specific to get the best recommendations',
            counterText: '${_controller.text.length}/${widget.maxLength}',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
                widget.onChanged('');
              },
            )
                : null,
          ),
          onChanged: widget.onChanged,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quick Suggestions',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            IconButton(
              icon: Icon(
                _showSuggestions ? Icons.expand_less : Icons.expand_more,
              ),
              onPressed: () {
                setState(() {
                  _showSuggestions = !_showSuggestions;
                });
              },
            ),
          ],
        ),
        if (_showSuggestions) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _quickSuggestions.map((suggestion) {
              final isSelected = _controller.text.contains(suggestion);
              return FilterChip(
                label: Text(suggestion),
                selected: isSelected,
                onSelected: (selected) {
                  String currentText = _controller.text;
                  if (selected) {
                    if (currentText.isNotEmpty) {
                      currentText += currentText.endsWith('.') ? ' ' : '. ';
                    }
                    currentText += suggestion;
                  } else {
                    currentText = currentText.replaceAll(suggestion, '').trim();
                    currentText = currentText.replaceAll(RegExp(r'\s+'), ' ');
                    currentText = currentText.replaceAll(RegExp(r'\.+'), '.');
                    currentText = currentText.replaceAll('. .', '.');
                  }
                  _controller.text = currentText;
                  widget.onChanged(currentText);
                },
              );
            }).toList(),
          ),
        ],
        const SizedBox(height: 12),
        ExpansionTile(
          title: Text(
            'Need inspiration? See examples',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          tilePadding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildExampleItem(
                    ' Accessibility needs',
                    '"Need wheelchair accessible hotels and attractions. Prefer ground floor rooms."',
                  ),
                  const Divider(),
                  _buildExampleItem(
                    '‍‍‍ Family travel',
                    '"Traveling with 2 kids (ages 5 and 8). Need child-friendly activities and restaurants."',
                  ),
                  const Divider(),
                  _buildExampleItem(
                    ' Dietary restrictions',
                    '"Vegetarian diet. Looking for authentic local vegetarian cuisine recommendations."',
                  ),
                  const Divider(),
                  _buildExampleItem(
                    ' Budget-conscious',
                    '"Looking for free or low-cost activities. Prefer public transportation and street food."',
                  ),
                  const Divider(),
                  _buildExampleItem(
                    ' Photography focus',
                    '"Passionate about photography. Interested in sunrise/sunset spots and unique architecture."',
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildExampleItem(String title, String example) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          example,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontStyle: FontStyle.italic,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}