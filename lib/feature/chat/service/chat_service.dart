import 'package:logger/logger.dart';

import '../../../core/model/app_model.dart';
import '../../../core/service/storage_service.dart';

class ChatService {
  static final Logger _logger = Logger();
  final StorageService _storageService;
  static const String _boxName = 'chat_history';

  ChatService(this._storageService);

  Future<List<ChatMessage>> getChatHistory() async {
    try {
      final box = await _storageService.openBox(_boxName);
      final messages = <ChatMessage>[];

      for (final key in box.keys) {
        final messageData = box.get(key);
        if (messageData != null) {
          final message = ChatMessage.fromJson(Map<String, dynamic>.from(messageData));
          messages.add(message);
        }
      }

      // Sort by timestamp
      messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));

      _logger.d('Retrieved ${messages.length} chat messages');
      return messages;
    } catch (e) {
      _logger.e('Failed to get chat history: $e');
      return [];
    }
  }

  Future<void> saveMessage(ChatMessage message) async {
    try {
      final box = await _storageService.openBox(_boxName);
      await box.put(message.id, message.toJson());
      _logger.d('Saved chat message: ${message.id}');
    } catch (e) {
      _logger.e('Failed to save chat message: $e');
      rethrow;
    }
  }

  Future<void> clearChatHistory() async {
    try {
      final box = await _storageService.openBox(_boxName);
      await box.clear();
      _logger.d('Cleared chat history');
    } catch (e) {
      _logger.e('Failed to clear chat history: $e');
      rethrow;
    }
  }

  Future<List<ChatMessage>> searchMessages(String query) async {
    try {
      final allMessages = await getChatHistory();
      final searchQuery = query.toLowerCase();

      return allMessages.where((message) {
        return message.content.toLowerCase().contains(searchQuery);
      }).toList();
    } catch (e) {
      _logger.e('Failed to search messages: $e');
      return [];
    }
  }
}