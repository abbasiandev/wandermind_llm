import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wandermind_llm/feature/llm/provider/llm_provider.dart';
import 'package:logger/logger.dart';

import '../../../core/model/app_model.dart';
import '../../../core/provider/app_provider.dart';
import '../service/chat_service.dart';

part 'chat_provider.freezed.dart';
part 'chat_provider.g.dart';

final chatServiceProvider = Provider<ChatService>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return ChatService(storageService);
});

@riverpod
class ChatController extends _$ChatController {
  static final Logger _logger = Logger();
  
  @override
  Future<List<ChatMessage>> build() async {
    final service = ref.read(chatServiceProvider);
    return await service.getChatHistory();
  }

  Future<void> sendMessage(String content) async {
    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      isUser: true,
      timestamp: DateTime.now(),
    );

    final currentMessages = await future;
    state = AsyncValue.data([...currentMessages, userMessage]);

    try {
      final service = ref.read(chatServiceProvider);
      await service.saveMessage(userMessage);

      String aiResponse;
      
      // First try to get a complete smart response from knowledge base
      final smartResponse = service.getSmartResponse(content);
      
      if (smartResponse != null) {
        // We can answer completely from offline knowledge base
        _logger.i('Using smart offline response for: $content');
        aiResponse = smartResponse;
      } else {
        // Try to enhance prompt with offline data if available
        final quickInfo = service.getQuickDestinationInfo(content);
        
        if (quickInfo != null) {
          // We have offline data - use it to enhance the LLM prompt
          _logger.i('Enhancing LLM with offline data for: $content');
          final llmController = ref.read(lLMControllerProvider.notifier);
          final enhancedPrompt = '''
$content

Context (offline data):
$quickInfo

Please provide a helpful, conversational response based on this information and your knowledge.
''';
          aiResponse = await llmController.generateResponse(enhancedPrompt);
        } else {
          // No offline data - use pure LLM
          _logger.i('Using LLM for query: $content');
          final llmController = ref.read(lLMControllerProvider.notifier);
          aiResponse = await llmController.generateResponse(content);
        }
      }

      final aiMessage = ChatMessage(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        content: aiResponse,
        isUser: false,
        timestamp: DateTime.now(),
      );

      await service.saveMessage(aiMessage);

      final updatedMessages = await service.getChatHistory();
      state = AsyncValue.data(updatedMessages);

    } catch (e) {
      final errorMessage = ChatMessage(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        content: 'Sorry, I encountered an error: $e',
        isUser: false,
        timestamp: DateTime.now(),
        type: MessageType.error,
      );

      final service = ref.read(chatServiceProvider);
      await service.saveMessage(errorMessage);

      final updatedMessages = await service.getChatHistory();
      state = AsyncValue.data(updatedMessages);
    }
  }

  Future<void> clearChat() async {
    final service = ref.read(chatServiceProvider);
    await service.clearChatHistory();
    state = const AsyncValue.data([]);
  }

  Future<TravelPlan> generateTravelPlanFromChat({
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required double budget,
    required List<String> interests,
    String? additionalContext,
  }) async {
    final llmController = ref.read(lLMControllerProvider.notifier);

    final chatHistory = await future;
    final recentMessages = chatHistory
        .where((msg) => msg.isUser)
        .take(5)
        .map((msg) => msg.content)
        .join('\n');

    final contextualPrompt = '''
Based on our previous conversation:
$recentMessages

${additionalContext ?? ''}
''';

    final plan = await llmController.generateTravelPlan(
      destination: destination,
      startDate: startDate,
      endDate: endDate,
      budget: budget,
      interests: interests,
      additionalRequirements: contextualPrompt,
    );

    final planMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: 'I\'ve created a travel plan for ${plan.destination}!',
      isUser: false,
      timestamp: DateTime.now(),
      type: MessageType.travelPlan,
      metadata: {'planId': plan.id},
    );

    final service = ref.read(chatServiceProvider);
    await service.saveMessage(planMessage);
    ref.invalidateSelf();

    return plan;
  }
}

@riverpod
class ChatInputController extends _$ChatInputController {
  @override
  ChatInputState build() {
    return const ChatInputState();
  }

  void updateMessage(String message) {
    state = state.copyWith(message: message);
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void clearMessage() {
    state = state.copyWith(message: '');
  }
}

@freezed
class ChatInputState with _$ChatInputState {
  const factory ChatInputState({
    @Default('') String message,
    @Default(false) bool isLoading,
  }) = _ChatInputState;
}