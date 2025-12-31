import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widget/custom_app_bar.dart';
import '../../../core/theme/app_color.dart';
import '../provider/travel_plan_provider.dart';
import '../../llm/provider/llm_provider.dart';
import '../../location/provider/location_provider.dart';
import '../widget/destination_input.dart';
import '../widget/date_picker_field.dart';
import '../widget/budget_input.dart';
import '../widget/interest_selector.dart';
import '../widget/additional_requirements_input.dart';

class CreatePlanScreen extends ConsumerStatefulWidget {
  final String? planId;

  const CreatePlanScreen({
    super.key,
    this.planId,
  });

  @override
  ConsumerState<CreatePlanScreen> createState() => _CreatePlanScreenState();
}

class _CreatePlanScreenState extends ConsumerState<CreatePlanScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isCreating = false;

  @override
  void initState() {
    super.initState();
    if (widget.planId != null) {
      _loadExistingPlan();
    }
  }

  void _loadExistingPlan() {

  }

  @override
  Widget build(BuildContext context) {
    final creationState = ref.watch(travelPlanCreationControllerProvider);
    final llmState = ref.watch(lLMControllerProvider);
    final locationAsync = ref.watch(locationControllerProvider);

    final isEditing = widget.planId != null;
    final title = isEditing ? 'Edit Travel Plan' : 'Create Travel Plan';

    return Scaffold(
      appBar: CustomAppBar(
        title: title,
        actions: [
          if (creationState.destination.isNotEmpty ||
              creationState.startDate != null ||
              creationState.endDate != null ||
              creationState.budget > 0)
            TextButton(
              onPressed: () => _showResetDialog(),
              child: const Text('Reset'),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!llmState.isInitialized)
                Card(
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning,
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'AI Assistant Initializing',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onErrorContainer,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Please wait while we set up your AI travel assistant.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onErrorContainer,
                                    ),
                              ),
                              if (llmState.isLoading &&
                                  llmState.initializationProgress > 0)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: LinearProgressIndicator(
                                    value: llmState.initializationProgress,
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .onErrorContainer
                                        .withOpacity(0.3),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context)
                                          .colorScheme
                                          .onErrorContainer,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                'Where do you want to go?',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              DestinationInput(
                value: creationState.destination,
                onChanged: (destination) {
                  ref
                      .read(travelPlanCreationControllerProvider.notifier)
                      .updateDestination(destination);
                },
                currentLocation: locationAsync.value,
              ),
              const SizedBox(height: 24),
              Text(
                'When are you traveling?',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: DatePickerField(
                      label: 'Start Date',
                      value: creationState.startDate,
                      onChanged: (date) {
                        if (date != null) {
                          final endDate = creationState.endDate;
                          if (endDate != null && date.isAfter(endDate)) {

                            ref
                                .read(travelPlanCreationControllerProvider
                                    .notifier)
                                .updateDates(
                                    date, date.add(const Duration(days: 1)));
                          } else {
                            ref
                                .read(travelPlanCreationControllerProvider
                                    .notifier)
                                .updateDates(date, endDate);
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DatePickerField(
                      label: 'End Date',
                      value: creationState.endDate,
                      firstDate: creationState.startDate ?? DateTime.now(),
                      onChanged: (date) {
                        if (date != null) {
                          ref
                              .read(
                                  travelPlanCreationControllerProvider.notifier)
                              .updateDates(creationState.startDate, date);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'What\'s your budget?',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              BudgetInput(
                value: creationState.budget,
                onChanged: (budget) {
                  ref
                      .read(travelPlanCreationControllerProvider.notifier)
                      .updateBudget(budget);
                },
              ),
              const SizedBox(height: 24),
              Text(
                'What are your interests?',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              InterestsSelector(
                selectedInterests: creationState.interests,
                onChanged: (interests) {
                  ref
                      .read(travelPlanCreationControllerProvider.notifier)
                      .updateInterests(interests);
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Any special requirements?',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tell us about any specific needs, preferences, or constraints',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.7),
                    ),
              ),
              const SizedBox(height: 12),
              AdditionalRequirementsInput(
                value: creationState.additionalRequirements,
                onChanged: (requirements) {
                  ref
                      .read(travelPlanCreationControllerProvider.notifier)
                      .updateAdditionalRequirements(requirements);
                },
              ),
              const SizedBox(height: 32),
              if (creationState.error != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          creationState.error!,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onErrorContainer,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isFormValid())
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trip Summary',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                      ),
                      const SizedBox(height: 8),
                      _buildSummaryRow(
                          'Destination', creationState.destination),
                      if (creationState.startDate != null &&
                          creationState.endDate != null)
                        _buildSummaryRow(
                          'Duration',
                          '${creationState.endDate!.difference(creationState.startDate!).inDays + 1} days',
                        ),
                      _buildSummaryRow('Budget',
                          '\$${creationState.budget.toStringAsFixed(0)}'),
                      _buildSummaryRow(
                          'Interests', creationState.interests.join(', ')),
                    ],
                  ),
                ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _canCreatePlan() ? _createTravelPlan : null,
                  icon: _isCreating
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Icon(isEditing ? Icons.save : Icons.create),
                  label: Text(
                    _isCreating
                        ? ref.watch(lLMControllerProvider).isGenerating
                            ? 'AI is generating your plan...'
                            : 'Preparing your trip...'
                        : (isEditing ? 'Update Plan' : 'Create Travel Plan'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  bool _isFormValid() {
    return ref.read(travelPlanCreationControllerProvider.notifier).isValid;
  }

  bool _canCreatePlan() {
    final llmState = ref.read(lLMControllerProvider);
    return _isFormValid() &&
        llmState.isInitialized &&
        !_isCreating &&
        !llmState.isGenerating;
  }

  Future<void> _createTravelPlan() async {
    if (!_canCreatePlan()) return;

    setState(() {
      _isCreating = true;
    });

    await Future.delayed(Duration(milliseconds: 100));

    try {
      final creationState = ref.read(travelPlanCreationControllerProvider);
      final llmController = ref.read(lLMControllerProvider.notifier);

      final plan = await llmController.generateTravelPlan(
        destination: creationState.destination,
        startDate: creationState.startDate!,
        endDate: creationState.endDate!,
        budget: creationState.budget,
        interests: creationState.interests,
        additionalRequirements: creationState.additionalRequirements.isNotEmpty
            ? creationState.additionalRequirements
            : null,
      );

      await ref
          .read(travelPlansControllerProvider.notifier)
          .addTravelPlan(plan);

      ref.read(travelPlanCreationControllerProvider.notifier).reset();

      if (mounted) {
        final planId = plan.id;
        final destination = plan.destination;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Travel plan for $destination created successfully!'),
            backgroundColor: AppColors.success,
            action: SnackBarAction(
              label: 'View',
              textColor: Colors.white,
              onPressed: () {

                Navigator.of(context).pushReplacementNamed('/plan/$planId');
              },
            ),
          ),
        );

        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            context.go('/plan/$planId');
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create travel plan: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCreating = false;
        });
      }
    }
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Form'),
        content: const Text(
            'Are you sure you want to reset all form data? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(travelPlanCreationControllerProvider.notifier).reset();
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
