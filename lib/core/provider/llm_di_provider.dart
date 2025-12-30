import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../feature/llm/service/llama_cpp_service.dart';
import '../../feature/llm/service/model_downloader_service.dart';
import '../../feature/llm/service/llm_service.dart';

/// Dependency Injection providers for LLM services
/// This ensures proper memory management and single instance control

/// Singleton provider for LlamaCppService
/// This prevents multiple model instances and manages memory efficiently
final llamaCppServiceProvider = Provider<LlamaCppService>((ref) {
  final service = LlamaCppService();
  
  // Cleanup when provider is disposed
  ref.onDispose(() {
    service.dispose();
  });
  
  return service;
});

/// Provider for ModelDownloaderService
final modelDownloaderServiceProvider = Provider<ModelDownloaderService>((ref) {
  return ModelDownloaderService();
});

/// Provider for LLMService with proper dependency injection
/// This injects the singleton LlamaCppService to prevent memory issues
final llmServiceProvider = Provider<LLMService>((ref) {
  final llamaService = ref.watch(llamaCppServiceProvider);
  final downloaderService = ref.watch(modelDownloaderServiceProvider);
  
  final service = LLMService(
    llamaService: llamaService,
    downloaderService: downloaderService,
  );
  
  // Cleanup when provider is disposed
  ref.onDispose(() {
    service.dispose();
  });
  
  return service;
});

/// Keep alive provider to prevent service from being disposed accidentally
final keepAliveLLMServiceProvider = Provider<LLMService>((ref) {
  final service = ref.watch(llmServiceProvider);
  ref.keepAlive(); // Prevents automatic disposal
  return service;
});
