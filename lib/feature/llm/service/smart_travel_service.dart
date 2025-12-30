import 'package:logger/logger.dart';
import '../../../core/data/travel_knowledge_base.dart';
import '../../../core/model/app_model.dart';
import 'llm_service.dart';

/// Smart travel service that combines offline data with LLM
/// This provides FAST responses by using pre-loaded data + minimal LLM processing
class SmartTravelService {
  static final Logger _logger = Logger();
  final LLMService _llmService;

  SmartTravelService(this._llmService);

  /// Generate travel plan using offline data + LLM for personalization
  /// This is MUCH faster than pure LLM generation (5-10 seconds vs 30-60 seconds)
  Future<TravelPlan> generateSmartTravelPlan({
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required double budget,
    required List<String> interests,
    String? additionalRequirements,
  }) async {
    _logger.i('Generating smart travel plan for $destination');
    
    // Step 1: Get offline data INSTANTLY (no waiting!)
    final destinationInfo = TravelKnowledgeBase.getDestinationInfo(destination);
    final duration = endDate.difference(startDate).inDays + 1;
    
    if (destinationInfo != null) {
      // We have offline data! Use it to build plan quickly
      _logger.i('Found offline data for $destination - building fast plan');
      
      return await _buildPlanWithOfflineData(
        destinationInfo: destinationInfo,
        destination: destination,
        startDate: startDate,
        endDate: endDate,
        duration: duration,
        budget: budget,
        interests: interests,
        additionalRequirements: additionalRequirements,
      );
    } else {
      // No offline data - use LLM (slower but still works)
      _logger.w('No offline data for $destination - using LLM generation');
      
      return await _buildPlanWithLLM(
        destination: destination,
        startDate: startDate,
        endDate: endDate,
        duration: duration,
        budget: budget,
        interests: interests,
        additionalRequirements: additionalRequirements,
      );
    }
  }

  /// Fast plan generation using offline data
  Future<TravelPlan> _buildPlanWithOfflineData({
    required DestinationInfo destinationInfo,
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required int duration,
    required double budget,
    required List<String> interests,
    String? additionalRequirements,
  }) async {
    // Get budget breakdown
    final budgetEstimate = TravelKnowledgeBase.getBudgetEstimate(destination, duration);
    
    // Get relevant activities based on interests
    final relevantActivities = TravelKnowledgeBase.getActivitiesForDestination(
      destination,
      interests,
    );
    
    // Get travel tips
    final tips = TravelKnowledgeBase.getTravelTips(destination);
    
    // Build daily itinerary
    final days = <DayPlan>[];
    final activitiesPerDay = (relevantActivities.length / duration).ceil();
    
    for (int dayIndex = 0; dayIndex < duration; dayIndex++) {
      final dayDate = startDate.add(Duration(days: dayIndex));
      final dayNumber = dayIndex + 1;
      
      // Select activities for this day
      final startActivityIndex = dayIndex * activitiesPerDay;
      final endActivityIndex = ((dayIndex + 1) * activitiesPerDay).clamp(0, relevantActivities.length);
      final dayActivities = relevantActivities.sublist(
        startActivityIndex.clamp(0, relevantActivities.length),
        endActivityIndex,
      );
      
      // Convert templates to actual activities
      final activities = <Activity>[];
      int hourOffset = 9; // Start at 9 AM
      
      for (var template in dayActivities) {
        activities.add(Activity(
          id: 'activity_${dayNumber}_${activities.length + 1}',
          title: template.title,
          description: template.description,
          location: destinationInfo.name,
          timeSlot: TimeSlot(
            startTime: DateTime(dayDate.year, dayDate.month, dayDate.day, hourOffset),
            endTime: DateTime(dayDate.year, dayDate.month, dayDate.day, hourOffset + template.duration),
          ),
          type: _mapCategoryToType(template.categories.first),
          cost: template.cost,
        ));
        
        hourOffset += template.duration + 1; // +1 hour break between activities
      }
      
      // Create day plan
      days.add(DayPlan(
        dayNumber: dayNumber,
        date: dayDate,
        overview: 'Day $dayNumber: ${_generateDayOverview(dayActivities, destinationInfo)}',
        estimatedCost: budgetEstimate.total / duration,
        activities: activities,
      ));
    }
    
    // Optional: Use LLM for minimal personalization if needed
    String? personalizedDescription;
    if (_llmService.isInitialized && additionalRequirements != null && additionalRequirements.isNotEmpty) {
      try {
        _logger.i('Adding LLM personalization...');
        personalizedDescription = await _getLLMPersonalization(
          destinationInfo,
          interests,
          additionalRequirements,
        );
      } catch (e) {
        _logger.w('LLM personalization failed, using offline data only: $e');
      }
    }
    
    return TravelPlan(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: '$destination ${duration}-Day Adventure',
      destination: destinationInfo.name,
      startDate: startDate,
      endDate: endDate,
      days: days,
      budget: budget,
      interests: interests,
      notes: [
        if (personalizedDescription != null) personalizedDescription,
        ...tips,
      ],
      createdAt: DateTime.now(),
    );
  }

  /// Slower plan generation using only LLM
  Future<TravelPlan> _buildPlanWithLLM({
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required int duration,
    required double budget,
    required List<String> interests,
    String? additionalRequirements,
  }) async {
    // Fallback to basic LLM generation
    final prompt = '''
Create a travel plan for $destination for $duration days.
Budget: \$${budget.toStringAsFixed(2)}
Interests: ${interests.join(', ')}
${additionalRequirements != null ? 'Requirements: $additionalRequirements' : ''}

Provide a brief itinerary with 2-3 activities per day.
''';

    final response = await _llmService.generateResponse(prompt);
    
    // Create basic plan from LLM response
    return _createBasicPlan(
      destination: destination,
      startDate: startDate,
      endDate: endDate,
      duration: duration,
      budget: budget,
      interests: interests,
      llmResponse: response,
    );
  }

  /// Get LLM personalization (quick, only ~50 tokens)
  Future<String> _getLLMPersonalization(
    DestinationInfo info,
    List<String> interests,
    String requirements,
  ) async {
    final prompt = '''
Given these interests: ${interests.join(', ')}
And requirements: $requirements
For a trip to ${info.name}

Write one personalized tip (max 30 words):
''';

    return await _llmService.generateResponse(prompt);
  }

  String _generateDayOverview(List<ActivityTemplate> activities, DestinationInfo info) {
    if (activities.isEmpty) return 'Explore ${info.name}';
    
    final mainActivities = activities.take(2).map((a) => a.title).join(' & ');
    return mainActivities;
  }

  ActivityType _mapCategoryToType(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return ActivityType.food;
      case 'sightseeing':
      case 'photography':
        return ActivityType.sightseeing;
      case 'culture':
      case 'art':
      case 'history':
        return ActivityType.culture;
      case 'nature':
      case 'walking':
        return ActivityType.adventure;
      case 'shopping':
        return ActivityType.shopping;
      case 'relaxation':
        return ActivityType.relaxation;
      case 'entertainment':
        return ActivityType.entertainment;
      default:
        return ActivityType.sightseeing;
    }
  }

  TravelPlan _createBasicPlan({
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required int duration,
    required double budget,
    required List<String> interests,
    required String llmResponse,
  }) {
    // Create a basic fallback plan
    final days = <DayPlan>[];
    
    for (int i = 0; i < duration; i++) {
      final dayDate = startDate.add(Duration(days: i));
      days.add(DayPlan(
        dayNumber: i + 1,
        date: dayDate,
        overview: 'Explore $destination - Day ${i + 1}',
        estimatedCost: budget / duration,
        activities: [
          Activity(
            id: 'activity_${i + 1}_1',
            title: 'Morning Activities',
            description: 'Discover local attractions',
            location: destination,
            timeSlot: TimeSlot(
              startTime: DateTime(dayDate.year, dayDate.month, dayDate.day, 9, 0),
              endTime: DateTime(dayDate.year, dayDate.month, dayDate.day, 12, 0),
            ),
            type: ActivityType.sightseeing,
            cost: (budget / duration) * 0.4,
          ),
        ],
      ));
    }
    
    return TravelPlan(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: '$destination Adventure',
      destination: destination,
      startDate: startDate,
      endDate: endDate,
      days: days,
      budget: budget,
      interests: interests,
      notes: [llmResponse],
      createdAt: DateTime.now(),
    );
  }
}
