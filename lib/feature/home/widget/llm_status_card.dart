import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/model/app_model.dart';
import '../../../core/theme/app_color.dart';

class LLMStatusCard extends StatelessWidget {
  final LLMState llmState;

  const LLMStatusCard({
    super.key,
    required this.llmState,
  });

  @override
  Widget build(BuildContext context) {
    // Show success state
    if (llmState.isInitialized) {
      return Card(
        color: AppColors.success.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: AppColors.success),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Assistant Ready',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.success,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Your travel planning assistant is ready to help!',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Show error state with helpful message
    if (llmState.error != null) {
      final isCorruptedModel = llmState.error?.contains('too small') ?? false;
      
      return Card(
        color: Colors.red.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      isCorruptedModel 
                          ? 'Model File Corrupted'
                          : 'Initialization Failed',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                isCorruptedModel
                    ? 'The model file is incomplete or corrupted. Please delete and re-download.'
                    : 'There was an error initializing the AI assistant',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              Text(
                llmState.error ?? '',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.red[700],
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              if (isCorruptedModel) ...[
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => context.go('/settings'),
                  icon: const Icon(Icons.settings),
                  label: const Text('Go to Settings'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    // Show loading state
    return Card(
      color: AppColors.warning.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.hourglass_empty, color: AppColors.warning),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Initializing AI Assistant...',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.warning,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Please wait while we set up your travel assistant',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (llmState.isLoading && llmState.initializationProgress > 0) ...[
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: llmState.initializationProgress,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.warning),
              ),
              const SizedBox(height: 8),
              Text(
                '${(llmState.initializationProgress * 100).toInt()}% complete',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}