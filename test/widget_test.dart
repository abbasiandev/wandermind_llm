
import 'package:flutter_test/flutter_test.dart';
import 'package:wandermind_llm/core/model/app_model.dart';
import 'package:wandermind_llm/feature/llm/service/model_downloader_service.dart';

void main() {
  group('LLM State Tests', () {
    test('LLMState initial state is correct', () {
      const state = LLMState();

      expect(state.isInitialized, false);
      expect(state.isLoading, false);
      expect(state.isGenerating, false);
      expect(state.initializationProgress, 0.0);
      expect(state.error, null);
      expect(state.modelPath, null);
    });

    test('LLMState progress updates correctly', () {
      const state = LLMState();

      final state1 = state.copyWith(isLoading: true, initializationProgress: 0.1);
      expect(state1.initializationProgress, 0.1);

      final state2 = state1.copyWith(initializationProgress: 0.5);
      expect(state2.initializationProgress, 0.5);

      final state3 = state2.copyWith(
        initializationProgress: 1.0,
        isInitialized: true,
        isLoading: false,
      );
      expect(state3.initializationProgress, 1.0);
      expect(state3.isInitialized, true);
      expect(state3.isLoading, false);
    });
  });

  group('Model Downloader Tests', () {
    test('Available models are defined', () {
      expect(ModelDownloaderService.availableModels.isNotEmpty, true);
      expect(ModelDownloaderService.availableModels.containsKey('tinyllama'), true);
    });

    test('Model info contains required fields', () {
      final modelInfo = ModelDownloaderService.availableModels['tinyllama']!;

      expect(modelInfo.name.isNotEmpty, true);
      expect(modelInfo.fileName.isNotEmpty, true);
      expect(modelInfo.url.isNotEmpty, true);
      expect(modelInfo.sizeInMB, greaterThan(0));
      expect(modelInfo.description.isNotEmpty, true);
    });
  });
}
