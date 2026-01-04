import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wandermind_llm/feature/llm/provider/llm_provider.dart';

import '../../../core/theme/app_color.dart';
import '../../../core/widget/custom_app_bar.dart';
import '../../../core/widget/loading_widget.dart';
import '../../location/provider/location_provider.dart';
import '../../travel_plan/provider/travel_plan_provider.dart';
import '../widget/home_header.dart';
import '../widget/llm_status_card.dart';
import '../widget/recent_plan.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeLLM();
    });
  }

  void _initializeLLM() async {
    final llmController = ref.read(lLMControllerProvider.notifier);
    try {
      await llmController.initializeLLM();
    } catch (e) {
      debugPrint('Failed to auto-initialize LLM: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final llmState = ref.watch(lLMControllerProvider);
    final travelPlansAsync = ref.watch(travelPlansControllerProvider);
    final locationAsync = ref.watch(locationControllerProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'WanderMind',
        showBackButton: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(travelPlansControllerProvider);
          ref.read(locationControllerProvider.notifier).getCurrentLocation();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(locationData: locationAsync.value),

              const SizedBox(height: 20),

              LLMStatusCard(llmState: llmState),

              const SizedBox(height: 24),

              Text(
                'Recent Travel Plans',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              travelPlansAsync.when(
                data: (plans) => RecentPlans(
                  plans: plans.take(3).toList(),
                  onViewAll: () => context.go('/plans'),
                  onPlanTap: (plan) => context.go('/plan/${plan.id}'),
                ),
                loading: () => const LoadingWidget(),
                error: (error, stack) => Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Failed to load travel plans',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        error.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: llmState.isInitialized
            ? () => context.go('/create-plan')
            : null,
        icon: const Icon(Icons.add),
        label: const Text('New Plan'),
        backgroundColor: llmState.isInitialized
            ? AppColors.primary
            : Theme.of(context).disabledColor,
      ),
    );
  }
}