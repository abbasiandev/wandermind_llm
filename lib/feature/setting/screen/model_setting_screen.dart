import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wandermind_llm/core/provider/llm_di_provider.dart';

import '../../../core/widget/custom_app_bar.dart';
import '../../../core/theme/app_color.dart';
import '../../llm/service/model_downloader_service.dart';
import '../../llm/provider/llm_provider.dart';

class ModelSettingsScreen extends ConsumerStatefulWidget {
  const ModelSettingsScreen({super.key});

  @override
  ConsumerState<ModelSettingsScreen> createState() =>
      _ModelSettingsScreenState();
}

class _ModelSettingsScreenState extends ConsumerState<ModelSettingsScreen> {
  Map<String, bool> _downloadedModels = {};
  Map<String, double> _downloadProgress = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkDownloadedModels();
  }

  Future<void> _checkDownloadedModels() async {
    setState(() => _isLoading = true);

    final llmService = ref.read(llmServiceProvider);
    final models = await llmService.getAvailableModels();

    for (final model in models) {
      final isDownloaded = await llmService.isModelDownloaded(model);
      _downloadedModels[model] = isDownloaded;
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final llmState = ref.watch(lLMControllerProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'AI Model Settings'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select AI Model',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Choose a model based on your device capability. Smaller models are faster but less capable.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ...ModelDownloaderService.availableModels.entries.map((entry) {
                  return _buildModelCard(
                    context,
                    entry.key,
                    entry.value,
                    _downloadedModels[entry.key] ?? false,
                    llmState.isInitialized,
                  );
                }),
              ],
            ),
    );
  }

  Widget _buildModelCard(
    BuildContext context,
    String modelKey,
    ModelInfo modelInfo,
    bool isDownloaded,
    bool isLLMInitialized,
  ) {
    final isDownloading = _downloadProgress[modelKey] != null;
    final progress = _downloadProgress[modelKey] ?? 0.0;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        modelInfo.name,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${modelInfo.sizeInMB} MB',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                if (isDownloaded)
                  Chip(
                    label: const Text('Downloaded'),
                    backgroundColor: AppColors.success.withOpacity(0.2),
                    labelStyle: const TextStyle(color: AppColors.success),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              modelInfo.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            if (isDownloading)
              Column(
                children: [
                  LinearProgressIndicator(value: progress),
                  const SizedBox(height: 8),
                  Text('Downloading: ${(progress * 100).toStringAsFixed(1)}%'),
                ],
              )
            else
              Row(
                children: [
                  if (!isDownloaded)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _downloadModel(modelKey),
                        icon: const Icon(Icons.download),
                        label: const Text('Download'),
                      ),
                    ),
                  if (isDownloaded) ...[
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed:
                            isLLMInitialized ? null : () => _useModel(modelKey),
                        icon: const Icon(Icons.check_circle),
                        label: const Text('Use This Model'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () => _deleteModel(modelKey),
                      icon: const Icon(Icons.delete, color: Colors.red),
                      tooltip: 'Delete Model',
                    ),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _downloadModel(String modelKey) async {
    setState(() {
      _downloadProgress[modelKey] = 0.0;
    });

    try {
      final llmService = ref.read(llmServiceProvider);
      final downloader = ModelDownloaderService();

      await downloader.downloadModel(
        modelKey,
        onProgress: (progress) {
          setState(() {
            _downloadProgress[modelKey] = progress;
          });
        },
        onComplete: () {
          setState(() {
            _downloadProgress.remove(modelKey);
            _downloadedModels[modelKey] = true;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Model downloaded successfully!')),
          );
        },
        onError: (error) {
          setState(() {
            _downloadProgress.remove(modelKey);
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Download failed: $error')),
          );
        },
      );
    } catch (e) {
      setState(() {
        _downloadProgress.remove(modelKey);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _useModel(String modelKey) async {
    try {
      final llmService = ref.read(llmServiceProvider);
      await llmService.changeModel(modelKey);

      await ref.read(lLMControllerProvider.notifier).initializeLLM();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Now using ${ModelDownloaderService.availableModels[modelKey]!.name}')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to switch model: $e')),
      );
    }
  }

  Future<void> _deleteModel(String modelKey) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Model'),
        content: Text(
            'Are you sure you want to delete ${ModelDownloaderService.availableModels[modelKey]!.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        final llmService = ref.read(llmServiceProvider);
        await llmService.deleteModel(modelKey);

        setState(() {
          _downloadedModels[modelKey] = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Model deleted successfully')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete model: $e')),
        );
      }
    }
  }
}
