import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_color.dart';
class BudgetInput extends StatefulWidget {
  final double value;
  final Function(double) onChanged;
  final String? currency;
  final double? minBudget;
  final double? maxBudget;
  const BudgetInput({
    super.key,
    required this.value,
    required this.onChanged,
    this.currency = 'USD',
    this.minBudget,
    this.maxBudget,
  });
  @override
  State<BudgetInput> createState() => _BudgetInputState();
}
class _BudgetInputState extends State<BudgetInput> {
  final TextEditingController _controller = TextEditingController();
  String _selectedCurrency = 'USD';
  final List<String> _currencies = [
    'USD', 'EUR', 'GBP', 'JPY', 'AUD', 'CAD', 'CHF', 'CNY', 'INR', 'MXN'
  ];
  final Map<String, String> _currencySymbols = {
    'USD': '\$',
    'EUR': '€',
    'GBP': '£',
    'JPY': '¥',
    'AUD': 'A\$',
    'CAD': 'C\$',
    'CHF': 'Fr',
    'CNY': '¥',
    'INR': '₹',
    'MXN': '\$',
  };
  final List<BudgetPreset> _budgetPresets = [
    BudgetPreset(label: 'Budget', amount: 1000, icon: Icons.savings),
    BudgetPreset(label: 'Moderate', amount: 3000, icon: Icons.account_balance_wallet),
    BudgetPreset(label: 'Comfortable', amount: 5000, icon: Icons.card_travel),
    BudgetPreset(label: 'Luxury', amount: 10000, icon: Icons.diamond),
  ];
  @override
  void initState() {
    super.initState();
    _selectedCurrency = widget.currency ?? 'USD';
    if (widget.value > 0) {
      _controller.text = widget.value.toStringAsFixed(0);
    }
  }
  @override
  void didUpdateWidget(BudgetInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && widget.value > 0) {
      _controller.text = widget.value.toStringAsFixed(0);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: _controller,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  hintText: 'Enter budget amount',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      _currencySymbols[_selectedCurrency] ?? '\$',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  suffixIcon: _controller.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                      widget.onChanged(0);
                    },
                  )
                      : null,
                ),
                onChanged: (value) {
                  final budget = double.tryParse(value) ?? 0;
                  widget.onChanged(budget);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a budget';
                  }
                  final budget = double.tryParse(value);
                  if (budget == null || budget <= 0) {
                    return 'Please enter a valid budget';
                  }
                  if (widget.minBudget != null && budget < widget.minBudget!) {
                    return 'Minimum budget is ${_currencySymbols[_selectedCurrency]}${widget.minBudget}';
                  }
                  if (widget.maxBudget != null && budget > widget.maxBudget!) {
                    return 'Maximum budget is ${_currencySymbols[_selectedCurrency]}${widget.maxBudget}';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 90,
              child: DropdownButtonFormField<String>(
                value: _selectedCurrency,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  isDense: true,
                ),
                isExpanded: true,
                items: _currencies.map((currency) {
                  return DropdownMenuItem(
                    value: currency,
                    child: Text(
                      currency,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCurrency = value;
                    });
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Quick Select',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: _budgetPresets.map((preset) {
            final isSelected = widget.value == preset.amount;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                  onTap: () {
                    _controller.text = preset.amount.toStringAsFixed(0);
                    widget.onChanged(preset.amount);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : Theme.of(context).colorScheme.outline.withOpacity(0.5),
                        width: isSelected ? 2 : 1,
                      ),
                      color: isSelected
                          ? AppColors.primary.withOpacity(0.1)
                          : Colors.transparent,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          preset.icon,
                          color: isSelected
                              ? AppColors.primary
                              : Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          preset.label,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isSelected
                                ? AppColors.primary
                                : Theme.of(context).colorScheme.onBackground,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                        Text(
                          '${_currencySymbols[_selectedCurrency]}${preset.amount.toStringAsFixed(0)}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isSelected
                                ? AppColors.primary
                                : Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        if (widget.value > 0)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.info.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.info.withOpacity(0.3),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, size: 16, color: AppColors.info),
                    const SizedBox(width: 8),
                    Text(
                      'Estimated Breakdown',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.info,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildBreakdownRow('Accommodation', 0.35),
                _buildBreakdownRow('Food & Dining', 0.25),
                _buildBreakdownRow('Activities', 0.20),
                _buildBreakdownRow('Transportation', 0.15),
                _buildBreakdownRow('Miscellaneous', 0.05),
              ],
            ),
          ),
      ],
    );
  }
  Widget _buildBreakdownRow(String category, double percentage) {
    final amount = widget.value * percentage;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            category,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            '${_currencySymbols[_selectedCurrency]}${amount.toStringAsFixed(0)} (${(percentage * 100).toInt()}%)',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
class BudgetPreset {
  final String label;
  final double amount;
  final IconData icon;
  const BudgetPreset({
    required this.label,
    required this.amount,
    required this.icon,
  });
}