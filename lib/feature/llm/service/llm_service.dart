import 'dart:async';
import 'package:logger/logger.dart';
import 'model_downloader_service.dart';
import 'llama_cpp_service.dart';
class LLMService {
  static final Logger _logger = Logger();
  final ModelDownloaderService _downloaderService;
  final LlamaCppService _llamaService;
  bool _isInitialized = false;
  String _currentModel = 'tinyllama';
  LLMService({
    ModelDownloaderService? downloaderService,
    LlamaCppService? llamaService,
  })  : _downloaderService = downloaderService ?? ModelDownloaderService(),
        _llamaService = llamaService ?? LlamaCppService();
  bool get isInitialized => _isInitialized;
  String get currentModel => _currentModel;
  Stream<double> initializeModel({String? modelKey}) async* {
    try {
      final selectedModel = modelKey ?? _currentModel;
      yield 0.1;
      _logger.i('Starting LLM initialization for model: $selectedModel');
      final isDownloaded =
          await _downloaderService.isModelDownloaded(selectedModel);
      yield 0.2;
      if (!isDownloaded) {
        _logger.i('Model not found, downloading automatically...');
        _logger.w('NOTE: First-time model download may take several minutes depending on your connection.');
        _logger.w('Please keep your device connected to WiFi and keep the screen on.');
        final progressController = StreamController<double>();
        final downloadFuture = _downloaderService.downloadModel(
          selectedModel,
          onProgress: (progress) {
            progressController.add(0.2 + (progress * 0.5));
            _logger.d(
                'Download progress: ${(progress * 100).toStringAsFixed(1)}%');
          },
          onComplete: () {
            _logger.i('Download completed successfully');
            progressController.close();
          },
          onError: (error) {
            _logger.e('Download error: $error');
            progressController.addError(error);
            progressController.close();
          },
        );
        await for (final progress in progressController.stream) {
          yield progress;
        }
        await downloadFuture;
        yield 0.7;
      } else {
        _logger.i('Model already downloaded');
        yield 0.7;
      }
      _logger.i('Loading model into memory...');
      _logger.i('NOTE: Model loading may take 30-60 seconds on first load.');
      yield 0.75;
      final modelPath = await _downloaderService.getModelPath(selectedModel);
      _logger.i('Model path: $modelPath');
      await _llamaService.loadModel(
        modelPath,
        contextSize: 2048,
        threads: 4,
      );
      yield 0.95;
      _currentModel = selectedModel;
      _isInitialized = true;
      _logger.i(' LLM initialization completed successfully');
      yield 1.0;
    } catch (e) {
      _logger.e(' Failed to initialize LLM: $e');
      _isInitialized = false;
      rethrow;
    }
  }
  Future<String> generateResponse(String prompt) async {
    if (!_isInitialized) {
      throw Exception('LLM not initialized');
    }
    try {
      _logger.d('Generating response...');
      final enhancedPrompt = _enhancePromptForTravel(prompt);
      final response = await _llamaService.generateText(
        enhancedPrompt,
        maxTokens: 512,
        temperature: 0.7,
      );
      _logger.d('Response generated successfully');
      return response;
    } catch (e) {
      _logger.e('Failed to generate response: $e');
      rethrow;
    }
  }
  Stream<String> generateResponseStream(String prompt) async* {
    if (!_isInitialized) {
      throw Exception('LLM not initialized');
    }
    try {
      _logger.d('Generating streaming response...');
      final enhancedPrompt = _enhancePromptForTravel(prompt);
      await for (final chunk in _llamaService.generateTextStream(
        enhancedPrompt,
        maxTokens: 512,
        temperature: 0.7,
      )) {
        yield chunk;
      }
    } catch (e) {
      _logger.e('Failed to generate streaming response: $e');
      rethrow;
    }
  }
  String _enhancePromptForTravel(String originalPrompt) {
    return '''
<|system|>
You are WanderMind, an expert AI travel assistant. You specialize in creating detailed, personalized travel plans and providing helpful travel advice.
Your capabilities include:
- Creating personalized itineraries and travel plans
- Providing navigation and routing advice (how to get from A to B)
- Suggesting transportation options (taxi, metro, bus, walking)
- Estimating travel times and costs
- Recommending places to visit, eat, and stay
- Sharing cultural tips, safety advice, and local customs
- Answering visa, documentation, and travel requirement questions
- Budget planning and cost optimization
When answering routing questions (e.g., "how to get from Dubai Airport to hotel"):
1. Suggest multiple transportation options (taxi, metro, bus, ride-share)
2. Provide estimated time and cost for each option
3. Give step-by-step directions when possible
4. Mention any tips (e.g., "Use the metro during rush hour to avoid traffic")
5. Include a note: "Tap 'Show Route on Map' to see the route visually"
Your responses should be practical, budget-conscious, culturally sensitive, safety-focused, and engaging.
</|system|>
<|user|>
$originalPrompt
</|user>
<|assistant|>
''';
  }
  Future<List<String>> getAvailableModels() async {
    return ModelDownloaderService.availableModels.keys.toList();
  }
  Future<bool> isModelDownloaded(String modelKey) async {
    return await _downloaderService.isModelDownloaded(modelKey);
  }
  Future<ModelInfo> getModelInfo(String modelKey) async {
    return ModelDownloaderService.availableModels[modelKey]!;
  }
  Future<void> changeModel(String modelKey) async {
    if (_isInitialized) {
      await _llamaService.unloadModel();
      _isInitialized = false;
    }
    _currentModel = modelKey;
  }
  Future<void> deleteModel(String modelKey) async {
    if (modelKey == _currentModel && _isInitialized) {
      await _llamaService.unloadModel();
      _isInitialized = false;
    }
    await _downloaderService.deleteModel(modelKey);
  }
  Future<void> dispose() async {
    if (_isInitialized) {
      await _llamaService.unloadModel();
      _isInitialized = false;
    }
    _logger.i('LLM service disposed');
  }
}