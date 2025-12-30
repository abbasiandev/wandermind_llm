import 'dart:io';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

/// Real LlamaCpp service implementation using native Android/iOS platform channels
/// This provides true offline LLM inference using llama.cpp native libraries
class LlamaCppService {
  static final Logger _logger = Logger();

  // Platform channels
  static const MethodChannel _methodChannel = 
      MethodChannel('dev.abbasian.wandermind/llama_cpp');
  static const EventChannel _eventChannel = 
      EventChannel('dev.abbasian.wandermind/llama_cpp_stream');

  // Singleton instance for memory management
  static LlamaCppService? _instance;
  
  String? _modelPath;
  bool _isLoaded = false;

  // Model configuration
  int _contextSize = 2048;
  int _threads = 4;

  bool get isLoaded => _isLoaded;
  String? get modelPath => _modelPath;
  bool get isMockMode => false; // Always use native implementation

  // Private constructor for singleton
  LlamaCppService._internal();

  // Factory constructor to return singleton instance
  factory LlamaCppService() {
    _instance ??= LlamaCppService._internal();
    return _instance!;
  }

  /// Load a GGUF model file for inference
  Future<void> loadModel(
    String modelPath, {
    int contextSize = 2048,
    int threads = 4,
    int? seed,
    bool useMlock = false,
    bool useMmap = true,
  }) async {
    try {
      _logger.i('Loading model from: $modelPath');

      // Check if model file exists
      final file = File(modelPath);
      if (!await file.exists()) {
        throw Exception('Model file not found: $modelPath');
      }

      // Unload existing model if loaded
      if (_isLoaded) {
        await unloadModel();
      }

      _modelPath = modelPath;
      _contextSize = contextSize;
      _threads = threads;

      // Call native method to load model
      final result = await _methodChannel.invokeMethod<bool>('loadModel', {
        'modelPath': modelPath,
        'contextSize': contextSize,
        'threads': threads,
      });

      if (result != true) {
        throw Exception('Failed to load model in native code');
      }

      _isLoaded = true;
      _logger.i('Model loaded successfully with native llama.cpp: $_modelPath');
      _logger.i('Context size: $contextSize, Threads: $threads');
    } catch (e, stackTrace) {
      _logger.e('Failed to load model: $e', error: e, stackTrace: stackTrace);
      _isLoaded = false;
      _modelPath = null;
      rethrow;
    }
  }

  /// Generate text response (non-streaming)
  Future<String> generateText(
    String prompt, {
    int maxTokens = 512,
    double temperature = 0.7,
    double topP = 0.9,
    int topK = 40,
    double repeatPenalty = 1.1,
    String stopSequence = '</s>',
  }) async {
    if (!_isLoaded) {
      throw Exception('Model not loaded. Call loadModel() first.');
    }

    try {
      _logger.d('Generating text for prompt length: ${prompt.length}');

      // Call native method to generate text
      final response = await _methodChannel.invokeMethod<String>('generateText', {
        'prompt': prompt,
        'maxTokens': maxTokens,
        'temperature': temperature,
      });

      if (response == null) {
        throw Exception('Failed to generate text in native code');
      }

      // Clean up response
      final cleanedResponse = response
          .replaceAll(stopSequence, '')
          .replaceAll('<|assistant|>', '')
          .replaceAll('<|system|>', '')
          .replaceAll('<|user|>', '')
          .trim();

      _logger.d('Generated response length: ${cleanedResponse.length}');
      return cleanedResponse;
    } catch (e, stackTrace) {
      _logger.e('Failed to generate text: $e', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Generate text response with streaming (token by token)
  Stream<String> generateTextStream(
    String prompt, {
    int maxTokens = 512,
    double temperature = 0.7,
    double topP = 0.9,
    int topK = 40,
    double repeatPenalty = 1.1,
    String stopSequence = '</s>',
  }) async* {
    if (!_isLoaded) {
      throw Exception('Model not loaded. Call loadModel() first.');
    }

    try {
      _logger.d('Generating streaming text for prompt length: ${prompt.length}');

      // Create event channel stream with parameters
      final stream = _eventChannel.receiveBroadcastStream({
        'prompt': prompt,
        'maxTokens': maxTokens,
        'temperature': temperature,
      });

      // Listen to stream and yield tokens
      await for (final token in stream) {
        if (token is String) {
          // Clean chunk and yield
          final cleanedChunk = token
              .replaceAll(stopSequence, '')
              .replaceAll('<|assistant|>', '')
              .replaceAll('<|system|>', '')
              .replaceAll('<|user|>', '');
          
          if (cleanedChunk.isNotEmpty) {
            yield cleanedChunk;
          }

          // Check for stop sequence
          if (token.contains(stopSequence)) {
            break;
          }
        }
      }

      _logger.d('Streaming generation completed');
    } catch (e, stackTrace) {
      _logger.e('Failed to generate streaming text: $e', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Get model information
  Future<Map<String, dynamic>> getModelInfo() async {
    if (!_isLoaded) {
      throw Exception('Model not loaded');
    }

    try {
      final isLoaded = await _methodChannel.invokeMethod<bool>('isModelLoaded');
      return {
        'modelPath': _modelPath,
        'contextSize': _contextSize,
        'threads': _threads,
        'isLoaded': isLoaded ?? false,
      };
    } catch (e) {
      _logger.e('Failed to get model info: $e');
      rethrow;
    }
  }

  /// Unload the current model and free memory
  Future<void> unloadModel() async {
    if (_isLoaded) {
      _logger.i('Unloading model...');

      try {
        await _methodChannel.invokeMethod('unloadModel');
        _isLoaded = false;
        _modelPath = null;
        
        _logger.i('Model unloaded successfully');
      } catch (e, stackTrace) {
        _logger.e('Error unloading model: $e', error: e, stackTrace: stackTrace);
        // Force cleanup even if error occurs
        _isLoaded = false;
        _modelPath = null;
      }
    }
  }

  /// Dispose and cleanup all resources
  Future<void> dispose() async {
    await unloadModel();
    _instance = null;
    _logger.i('LlamaCppService disposed');
  }

  /// Reset singleton instance (useful for testing)
  static void resetInstance() {
    _instance = null;
  }
}
