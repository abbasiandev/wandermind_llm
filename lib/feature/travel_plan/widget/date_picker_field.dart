import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final Function(DateTime?) onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? hintText;
  final String? errorText;

  const DatePickerField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.firstDate,
    this.lastDate,
    this.hintText,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _selectDate(context),
          borderRadius: BorderRadius.circular(8),
          child: InputDecorator(
            decoration: InputDecoration(
              hintText: hintText ?? 'Select $label',
              prefixIcon: const Icon(Icons.calendar_today),
              suffixIcon: value != null
                  ? IconButton(
                icon: const Icon(Icons.clear, size: 20),
                onPressed: () => onChanged(null),
              )
                  : null,
              errorText: errorText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              value != null ? dateFormat.format(value!) : hintText ?? 'Select $label',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: value != null
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final effectiveFirstDate = firstDate ?? now;
    final effectiveLastDate = lastDate ?? now.add(const Duration(days: 365 * 2));

    DateTime initialDate;
    if (value != null &&
        !value!.isBefore(effectiveFirstDate) &&
        !value!.isAfter(effectiveLastDate)) {
      initialDate = value!;
    } else if (firstDate != null && !firstDate!.isBefore(effectiveFirstDate)) {
      initialDate = firstDate!;
    } else {
      initialDate = now.isAfter(effectiveFirstDate) ? now : effectiveFirstDate;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: effectiveFirstDate,
      lastDate: effectiveLastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != value) {
      onChanged(picked);
    }
  }
}

class DateRangePicker extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTime?) onStartDateChanged;
  final Function(DateTime?) onEndDateChanged;

  const DateRangePicker({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DatePickerField(
          label: 'Start Date',
          value: startDate,
          onChanged: onStartDateChanged,
        ),
        const SizedBox(height: 16),
        DatePickerField(
          label: 'End Date',
          value: endDate,
          onChanged: onEndDateChanged,
          firstDate: startDate ?? DateTime.now(),
        ),
      ],
    );
  }
}