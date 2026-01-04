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
        'paris', 'tokyo', 'new york', 'london', 'rome', 'barcelona',
        'istanbul', 'singapore', 'bangkok'
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

  /// Get transportation/routing information for a query
  String? getTransportationInfo(String query) {
    try {
      final queryLower = query.toLowerCase();
      
      // Check if it's a routing/transportation question
      final routingKeywords = [
        'how to get',
        'how do i get',
        'get from',
        'transport from',
        'travel from',
        'go from',
        'airport to',
        'from airport',
        'transportation',
        'best way to',
        'metro',
        'taxi',
        'bus',
        'train',
        'subway',
        'public transport',
        'getting around',
      ];

      final isRoutingQuery = routingKeywords.any((keyword) => queryLower.contains(keyword));
      if (!isRoutingQuery) return null;

      // Try to identify the city
      final cities = ['paris', 'tokyo', 'london', 'new york'];
      
      for (final city in cities) {
        if (queryLower.contains(city)) {
          final transportInfo = TravelKnowledgeBase.getTransportationInfo(city);
          if (transportInfo != null) {
            return _buildTransportationResponse(transportInfo, queryLower);
          }
        }
      }

      return null;
    } catch (e) {
      _logger.e('Failed to get transportation info: $e');
      return null;
    }
  }

  String _buildTransportationResponse(TransportationInfo info, String query) {
    final buffer = StringBuffer();
    
    if (query.contains('airport')) {
      buffer.writeln('🚖 Transportation from ${info.cityName} Airport to City Center:\n');
      
      for (final option in info.airportTransport) {
        buffer.writeln('${option.icon} ${option.name}');
        buffer.writeln('   ${option.description}');
        buffer.writeln('   💰 Cost: ${option.cost}');
        buffer.writeln('   ⏱️ Time: ${option.duration}');
        if (option.tips.isNotEmpty) {
          buffer.writeln('   💡 Tip: ${option.tips.first}');
        }
        buffer.writeln();
      }
    } else {
      buffer.writeln('🚇 Getting Around ${info.cityName}:\n');
      buffer.writeln(info.generalTransportInfo);
      buffer.writeln();
      
      buffer.writeln('📍 Public Transport Options:\n');
      for (final option in info.publicTransport) {
        buffer.writeln('${option.icon} ${option.name}');
        buffer.writeln('   ${option.description}');
        buffer.writeln('   💰 Cost: ${option.cost}');
        if (option.tips.isNotEmpty) {
          buffer.writeln('   💡 ${option.tips.first}');
        }
        buffer.writeln();
      }
    }
    
    return buffer.toString();
  }

  /// Get general travel FAQ answer
  String? getTravelFAQAnswer(String query) {
    try {
      return TravelKnowledgeBase.searchFAQ(query);
    } catch (e) {
      _logger.e('Failed to get FAQ answer: $e');
      return null;
    }
  }

  /// Determine the type of query and get appropriate response
  String? getSmartResponse(String query) {
    try {
      // First, check for transportation/routing queries
      final transportInfo = getTransportationInfo(query);
      if (transportInfo != null) {
        return transportInfo;
      }

      // Check for destination information queries
      if (isDestinationQuery(query)) {
        final destInfo = getQuickDestinationInfo(query);
        if (destInfo != null) {
          return destInfo;
        }
      }

      // Check for general travel FAQ
      final faqAnswer = getTravelFAQAnswer(query);
      if (faqAnswer != null) {
        return '💡 Travel Tip:\n\n$faqAnswer';
      }

      return null;
    } catch (e) {
      _logger.e('Failed to get smart response: $e');
      return null;
    }
  }

  /// Check if query can be answered with knowledge base
  bool canAnswerWithKnowledgeBase(String query) {
    return getSmartResponse(query) != null;
  }
}
