import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/widget/custom_app_bar.dart';
import '../../../core/widget/loading_widget.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/model/app_model.dart';
import '../provider/travel_plan_provider.dart';
import '../widget/day_plan_card.dart';
import '../widget/plan_overview_card.dart';
import '../widget/budget_breakdown_card.dart';

class PlanDetailScreen extends ConsumerStatefulWidget {
  final String planId;

  const PlanDetailScreen({
    super.key,
    required this.planId,
  });

  @override
  ConsumerState<PlanDetailScreen> createState() => _PlanDetailScreenState();
}

class _PlanDetailScreenState extends ConsumerState<PlanDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TravelPlan? _plan;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadPlan();
  }

  Future<void> _loadPlan() async {
    setState(() => _isLoading = true);

    final service = ref.read(travelPlanServiceProvider);
    final plan = await service.getTravelPlan(widget.planId);

    if (plan != null) {
      ref.read(currentTravelPlanControllerProvider.notifier).setCurrentPlan(plan);
      setState(() {
        _plan = plan;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: LoadingWidget(message: 'Loading travel plan...'),
      );
    }

    if (_plan == null) {
      return Scaffold(
        appBar: const CustomAppBar(title: 'Plan Not Found'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Travel plan not found',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'The requested plan may have been deleted',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: _plan!.title,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.go('/plan/${widget.planId}/edit'),
            tooltip: 'Edit Plan',
          ),
          PopupMenuButton<String>(
            onSelected: (value) => _handleMenuAction(value),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'share',
                child: Row(
                  children: [
                    Icon(Icons.share),
                    SizedBox(width: 8),
                    Text('Share'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'export',
                child: Row(
                  children: [
                    Icon(Icons.download),
                    SizedBox(width: 8),
                    Text('Export PDF'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'duplicate',
                child: Row(
                  children: [
                    Icon(Icons.copy),
                    SizedBox(width: 8),
                    Text('Duplicate'),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Delete', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Overview', icon: Icon(Icons.info_outline)),
            Tab(text: 'Itinerary', icon: Icon(Icons.calendar_today)),
            Tab(text: 'Budget', icon: Icon(Icons.attach_money)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildItineraryTab(),
          _buildBudgetTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddNoteDialog(),
        icon: const Icon(Icons.note_add),
        label: const Text('Add Note'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlanOverviewCard(plan: _plan!),
          const SizedBox(height: 16),
          _buildInfoSection(
            'Interests',
            Icons.favorite,
            _plan!.interests.join(', '),
          ),
          const SizedBox(height: 16),
          _buildNotesSection(),
        ],
      ),
    );
  }

  Widget _buildItineraryTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _plan!.days.length,
      itemBuilder: (context, index) {
        final day = _plan!.days[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: DayPlanCard(
            dayPlan: day,
            onActivityTap: (activity) => _showActivityDetails(activity),
          ),
        );
      },
    );
  }

  Widget _buildBudgetTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          BudgetBreakdownCard(plan: _plan!),
          const SizedBox(height: 16),
          _buildDailyBudgetList(),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, IconData icon, String content) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.notes, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text(
                      'Notes',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: () => _showAddNoteDialog(),
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_plan!.notes.isEmpty)
              Text(
                'No notes yet. Add your first note!',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withOpacity(0.6),
                ),
              )
            else
              ...(_plan!.notes.asMap().entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${entry.key + 1}. ',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                );
              })),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyBudgetList() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Daily Budget Breakdown',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 1),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _plan!.days.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final day = _plan!.days[index];
              final dateFormat = DateFormat('EEE, MMM dd');
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Text(
                    'D${day.dayNumber}',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(dateFormat.format(day.date)),
                trailing: Text(
                  '\$${day.estimatedCost.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showActivityDetails(Activity activity) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _getActivityIcon(activity.type),
                      color: AppColors.primary,
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        activity.title,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildDetailRow(Icons.location_on, activity.location),
                const SizedBox(height: 8),
                _buildDetailRow(
                  Icons.access_time,
                  '${DateFormat('h:mm a').format(activity.timeSlot.startTime)} - ${DateFormat('h:mm a').format(activity.timeSlot.endTime)}',
                ),
                const SizedBox(height: 8),
                _buildDetailRow(
                  Icons.attach_money,
                  '\$${activity.cost.toStringAsFixed(2)}',
                ),
                const SizedBox(height: 16),
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  activity.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                if (activity.tips.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Tips',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...activity.tips.map((tip) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.lightbulb_outline, size: 16),
                        const SizedBox(width: 8),
                        Expanded(child: Text(tip)),
                      ],
                    ),
                  )),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    );
  }

  IconData _getActivityIcon(ActivityType type) {
    switch (type) {
      case ActivityType.sightseeing:
        return Icons.camera_alt;
      case ActivityType.food:
        return Icons.restaurant;
      case ActivityType.shopping:
        return Icons.shopping_bag;
      case ActivityType.entertainment:
        return Icons.theater_comedy;
      case ActivityType.transportation:
        return Icons.directions_car;
      case ActivityType.accommodation:
        return Icons.hotel;
      case ActivityType.adventure:
        return Icons.hiking;
      case ActivityType.relaxation:
        return Icons.spa;
      case ActivityType.culture:
        return Icons.museum;
      case ActivityType.nightlife:
        return Icons.nightlife;
    }
  }

  void _showAddNoteDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Note'),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Enter your note...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                ref
                    .read(currentTravelPlanControllerProvider.notifier)
                    .addNote(controller.text.trim());
                Navigator.pop(context);
                _loadPlan(); // Reload to show the new note
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Note added successfully')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'share':
        _sharePlan();
        break;
      case 'export':
        _exportPlan();
        break;
      case 'duplicate':
        _duplicatePlan();
        break;
      case 'delete':
        _showDeleteConfirmation();
        break;
    }
  }

  void _sharePlan() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share feature coming soon!')),
    );
  }

  void _exportPlan() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Export feature coming soon!')),
    );
  }

  void _duplicatePlan() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Duplicate feature coming soon!')),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Travel Plan'),
        content: Text(
          'Are you sure you want to delete "${_plan!.title}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref
                  .read(travelPlansControllerProvider.notifier)
                  .deleteTravelPlan(widget.planId);
              if (mounted) {
                context.go('/');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Plan deleted successfully')),
                );
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}