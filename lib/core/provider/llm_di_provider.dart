import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../feature/llm/service/llama_cpp_service.dart';
import '../../feature/llm/service/model_downloader_service.dart';
import '../../feature/llm/service/llm_service.dart';

final llamaCppServiceProvider = Provider<LlamaCppService>((ref) {
  final service = LlamaCppService();

  ref.onDispose(() {
    service.dispose();
  });

  return service;
});

final modelDownloaderServiceProvider = Provider<ModelDownloaderService>((ref) {
  return ModelDownloaderService();
});

final llmServiceProvider = Provider<LLMService>((ref) {
  final llamaService = ref.watch(llamaCppServiceProvider);
  final downloaderService = ref.watch(modelDownloaderServiceProvider);

  final service = LLMService(
    llamaService: llamaService,
    downloaderService: downloaderService,
  );

  ref.onDispose(() {
    service.dispose();
  });

  return service;
});

final keepAliveLLMServiceProvider = Provider<LLMService>((ref) {
  final service = ref.watch(llmServiceProvider);
  ref.keepAlive();
  return service;
});
