import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widget/custom_app_bar.dart';
import '../../../core/widget/loading_widget.dart';
import '../provider/travel_plan_provider.dart';
import '../widget/plan_list_item.dart';

class TravelPlanScreen extends ConsumerWidget {
  const TravelPlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(travelPlansControllerProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'My Travel Plans'),
      body: plansAsync.when(
        data: (plans) {
          if (plans.isEmpty) {
            return _buildEmptyState(context);
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: plans.length,
            itemBuilder: (context, index) {
              final plan = plans[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: PlanListItem(
                  plan: plan,
                  onTap: () => context.go('/plan/${plan.id}'),
                ),
              );
            },
          );
        },
        loading: () => const LoadingWidget(message: 'Loading plans...'),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/create-plan'),
        icon: const Icon(Icons.add),
        label: const Text('Create Plan'),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.map_outlined, size: 64),
          const SizedBox(height: 16),
          const Text('No travel plans yet'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go('/create-plan'),
            child: const Text('Create Your First Plan'),
          ),
        ],
      ),
    );
  }
}