import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:logger/logger.dart';
class ModelDownloaderService {
  static final Logger _logger = Logger();
  final Dio _dio = Dio();
  static const Map<String, ModelInfo> availableModels = {
    'tinyllama': ModelInfo(
      name: 'TinyLlama 1.1B',
      fileName: 'tinyllama-1.1b-chat-v1.0.Q4_K_M.gguf',
      url: 'https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF/resolve/main/tinyllama-1.1b-chat-v1.0.Q4_K_M.gguf',
      sizeInMB: 669,
      description: 'Smallest model, fastest inference, good for basic tasks',
    ),
    'phi2': ModelInfo(
      name: 'Phi-2 2.7B',
      fileName: 'phi-2.Q4_K_M.gguf',
      url: 'https://huggingface.co/TheBloke/phi-2-GGUF/resolve/main/phi-2.Q4_K_M.gguf',
      sizeInMB: 1560,
      description: 'Microsoft Phi-2, excellent quality for size',
    ),
    'gemma2b': ModelInfo(
      name: 'Gemma 2B',
      fileName: 'gemma-2b-it-q4_k_m.gguf',
      url: 'https://huggingface.co/lmstudio-ai/gemma-2b-it-GGUF/resolve/main/gemma-2b-it-q4_k_m.gguf',
      sizeInMB: 1740,
      description: 'Google Gemma 2B, balanced performance',
    ),
  };
  Future<String> getModelPath(String modelKey) async {
    final appDir = await getApplicationDocumentsDirectory();
    final modelInfo = availableModels[modelKey]!;
    return '${appDir.path}/models/${modelInfo.fileName}';
  }
  Future<bool> isModelDownloaded(String modelKey) async {
    try {
      final modelPath = await getModelPath(modelKey);
      return await File(modelPath).exists();
    } catch (e) {
      _logger.e('Error checking model: $e');
      return false;
    }
  }
  Future<void> downloadModel(
      String modelKey, {
        required Function(double) onProgress,
        required Function() onComplete,
        required Function(String) onError,
      }) async {
    try {
      final modelInfo = availableModels[modelKey]!;
      final modelPath = await getModelPath(modelKey);
      final modelDir = Directory(modelPath.substring(0, modelPath.lastIndexOf('/')));
      if (!await modelDir.exists()) {
        await modelDir.create(recursive: true);
      }
      _logger.i('Downloading model: ${modelInfo.name}');
      double lastReportedProgress = -1.0;
      await _dio.download(
        modelInfo.url,
        modelPath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = received / total;
            if (progress - lastReportedProgress >= 0.01 || progress >= 1.0) {
              onProgress(progress);
              lastReportedProgress = progress;
              _logger.d('Download progress: ${(progress * 100).toStringAsFixed(1)}%');
            }
          }
        },
        options: Options(
          receiveTimeout: const Duration(hours: 2),
          sendTimeout: const Duration(minutes: 5),
        ),
      );
      _logger.i('Model downloaded successfully');
      onComplete();
    } catch (e) {
      _logger.e('Failed to download model: $e');
      onError(e.toString());
      rethrow;
    }
  }
  Future<void> deleteModel(String modelKey) async {
    try {
      final modelPath = await getModelPath(modelKey);
      final file = File(modelPath);
      if (await file.exists()) {
        await file.delete();
        _logger.i('Model deleted: $modelKey');
      }
    } catch (e) {
      _logger.e('Failed to delete model: $e');
      rethrow;
    }
  }
  Future<double> getModelSize(String modelKey) async {
    try {
      final modelPath = await getModelPath(modelKey);
      final file = File(modelPath);
      if (await file.exists()) {
        final size = await file.length();
        return size / (1024 * 1024);
      }
      return 0;
    } catch (e) {
      _logger.e('Failed to get model size: $e');
      return 0;
    }
  }
}
class ModelInfo {
  final String name;
  final String fileName;
  final String url;
  final int sizeInMB;
  final String description;
  const ModelInfo({
    required this.name,
    required this.fileName,
    required this.url,
    required this.sizeInMB,
    required this.description,
  });
}