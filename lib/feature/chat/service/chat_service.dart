import 'package:logger/logger.dart';

import '../../../core/model/app_model.dart';
import '../../../core/service/storage_service.dart';
import '../../../core/data/travel_knowledge_base.dart';

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

  String? getQuickDestinationInfo(String query) {
    try {

      final destinations = [
        'dubai', 'abu dhabi', 'cairo', 'marrakech', 'doha', 'amman',
        'paris', 'tokyo', 'new york', 'london', 'rome'
      ];

      final queryLower = query.toLowerCase();

      for (final destination in destinations) {
        if (queryLower.contains(destination)) {
          final info = TravelKnowledgeBase.getDestinationInfo(destination);
          if (info != null) {

            final buffer = StringBuffer();
            buffer.writeln('${info.name}, ${info.country}');
            buffer.writeln();
            buffer.writeln(info.description);
            buffer.writeln();
            buffer.writeln(' Estimated daily costs:');
            buffer.writeln('• Accommodation: \$${info.avgAccommodationPerDay.toInt()}');
            buffer.writeln('• Food: \$${info.avgFoodPerDay.toInt()}');
            buffer.writeln('• Transport: \$${info.avgTransportPerDay.toInt()}');
            buffer.writeln('• Activities: \$${info.avgActivitiesPerDay.toInt()}');
            buffer.writeln();
            buffer.writeln(' Top activities:');
            final topActivities = info.activities.take(3);
            for (final activity in topActivities) {
              buffer.writeln('• ${activity.title} (\$${activity.cost.toInt()})');
            }
            buffer.writeln();
            buffer.writeln(' Pro tip: ${info.tips.first}');

            return buffer.toString();
          }
        }
      }

      return null;
    } catch (e) {
      _logger.e('Failed to get quick destination info: $e');
      return null;
    }
  }

  bool isDestinationQuery(String query) {
    final queryLower = query.toLowerCase();
    final destinationKeywords = [
      'tell me about',
      'what about',
      'information about',
      'info about',
      'plan a trip to',
      'plan a trip',
      'plan to',
      'plan trip to',
      'planning to',
      'visit',
      'travel to',
      'traveling to',
      'going to',
      'trip to',
      'about',
    ];

    return destinationKeywords.any((keyword) => queryLower.contains(keyword));
  }
}
