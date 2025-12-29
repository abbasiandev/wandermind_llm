import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:path_provider/path_provider.dart';
import 'package:logger/logger.dart';

class LLMService {
  static final Logger _logger = Logger();
  FlutterGemma? _gemma;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Stream<double> initializeModel() async* {
    try {
      yield 0.1;
      _logger.i('Starting LLM initialization...');

      // Initialize FlutterGemma
      _gemma = FlutterGemma();
      yield 0.2;

      // Check if model exists locally
      final modelPath = await _getModelPath();
      yield 0.3;

      if (!await File(modelPath).exists()) {
        _logger.i('Model not found locally, downloading...');
        await _downloadModel(modelPath);
        yield 0.7;
      } else {
        _logger.i('Model found locally');
        yield 0.7;
      }

      // Load the model
      _logger.i('Loading model...');
      await _gemma!.init(
        modelPath: modelPath,
        maxTokens: 512,
        temperature: 0.7,
        topK: 40,
        topP: 0.95,
      );
      yield 0.9;

      _isInitialized = true;
      _logger.i('LLM initialization completed');
      yield 1.0;

    } catch (e) {
      _logger.e('Failed to initialize LLM: $e');
      rethrow;
    }
  }

  Future<String> generateResponse(String prompt) async {
    if (!_isInitialized || _gemma == null) {
      throw Exception('LLM not initialized');
    }

    try {
      _logger.d('Generating response for prompt: ${prompt.substring(0, 50)}...');

      final enhancedPrompt = _enhancePromptForTravel(prompt);
      final response = await _gemma!.generateResponse(enhancedPrompt);

      _logger.d('Response generated successfully');
      return response;
    } catch (e) {
      _logger.e('Failed to generate response: $e');
      rethrow;
    }
  }

  Future<String> _getModelPath() async {
    final appDir = await getApplicationDocumentsDirectory();
    return '${appDir.path}/models/gemma-2b-it.bin';
  }

  Future<void> _downloadModel(String modelPath) async {
    // In a real implementation, you would download the model from a server
    // For now, we'll simulate the download process
    _logger.i('Simulating model download...');

    final modelDir = Directory('${modelPath.substring(0, modelPath.lastIndexOf('/'))}');
    if (!await modelDir.exists()) {
      await modelDir.create(recursive: true);
    }

    // Create a placeholder file (in real implementation, download actual model)
    final file = File(modelPath);
    await file.writeAsString('placeholder_model_data');

    _logger.i('Model download completed (simulated)');
  }

  String _enhancePromptForTravel(String originalPrompt) {
    return '''
You are WanderMind, an expert AI travel assistant. You specialize in creating detailed, personalized travel plans and providing helpful travel advice. Your responses should be:

1. Detailed and practical
2. Budget-conscious and realistic
3. Culturally sensitive and respectful
4. Safety-focused
5. Engaging and inspiring

User Request: $originalPrompt

Please provide a comprehensive response that addresses the user's travel needs. If creating an itinerary, include specific recommendations for:
- Accommodations
- Transportation
- Activities and attractions
- Local cuisine
- Cultural experiences
- Budget estimates
- Safety tips
- Local customs to be aware of

Response:
''';
  }

  Future<void> dispose() async {
    if (_gemma != null) {
      await _gemma!.dispose();
      _gemma = null;
      _isInitialized = false;
      _logger.i('LLM disposed');
    }
  }
}