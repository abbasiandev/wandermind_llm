import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/model/app_model.dart';
import '../service/llm_service.dart';

part 'llm_provider.g.dart';

// LLM Service
final llmServiceProvider = Provider<LLMService>((ref) {
  return LLMService();
});

// LLM State
@riverpod
class LLMController extends _$LLMController {
  @override
  LLMState build() {
    return const LLMState();
  }

  Future<void> initializeLLM() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final service = ref.read(llmServiceProvider);

      // Update progress during initialization
      await for (final progress in service.initializeModel()) {
        state = state.copyWith(initializationProgress: progress);
      }

      state = state.copyWith(
        isInitialized: true,
        isLoading: false,
        initializationProgress: 1.0,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to initialize LLM: $e',
      );
    }
  }

  Future<String> generateResponse(String prompt) async {
    if (!state.isInitialized) {
      throw Exception('LLM not initialized');
    }

    state = state.copyWith(isGenerating: true, error: null);

    try {
      final service = ref.read(llmServiceProvider);
      final response = await service.generateResponse(prompt);

      state = state.copyWith(isGenerating: false);
      return response;
    } catch (e) {
      state = state.copyWith(
        isGenerating: false,
        error: 'Failed to generate response: $e',
      );
      rethrow;
    }
  }

  Future<TravelPlan> generateTravelPlan({
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required double budget,
    required List<String> interests,
    String? additionalRequirements,
  }) async {
    final prompt = _buildTravelPlanPrompt(
      destination: destination,
      startDate: startDate,
      endDate: endDate,
      budget: budget,
      interests: interests,
      additionalRequirements: additionalRequirements,
    );

    final response = await generateResponse(prompt);
    return _parseTravelPlanResponse(response, destination, startDate, endDate, budget, interests);
  }

  String _buildTravelPlanPrompt({
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required double budget,
    required List<String> interests,
    String? additionalRequirements,
  }) {
    final duration = endDate.difference(startDate).inDays + 1;
    final interestsText = interests.join(', ');

    return '''
Create a detailed travel plan for $destination for $duration days.
Budget: \$${budget.toStringAsFixed(2)}
Interests: $interestsText
Start Date: ${startDate.toIso8601String().split('T')[0]}
End Date: ${endDate.toIso8601String().split('T')[0]}
${additionalRequirements != null ? 'Additional Requirements: $additionalRequirements' : ''}

Please provide a detailed itinerary in JSON format with the following structure:
{
  "title": "Trip title",
  "overview": "Brief overview of the trip",
  "days": [
    {
      "dayNumber": 1,
      "date": "YYYY-MM-DD",
      "overview": "Day overview",
      "estimatedCost": 0.0,
      "activities": [
        {
          "title": "Activity title",
          "description": "Detailed description",
          "location": "Specific location",
          "startTime": "HH:mm",
          "endTime": "HH:mm",
          "type": "sightseeing|food|shopping|entertainment|transportation|accommodation|adventure|relaxation|culture|nightlife",
          "cost": 0.0,
          "tips": ["tip1", "tip2"]
        }
      ]
    }
  ],
  "totalEstimatedCost": 0.0,
  "generalTips": ["tip1", "tip2"],
  "budgetBreakdown": {
    "accommodation": 0.0,
    "food": 0.0,
    "transportation": 0.0,
    "activities": 0.0,
    "miscellaneous": 0.0
  }
}

Make sure the plan is realistic, within budget, and aligns with the specified interests.
''';
  }

  TravelPlan _parseTravelPlanResponse(
      String response,
      String destination,
      DateTime startDate,
      DateTime endDate,
      double budget,
      List<String> interests,
      ) {
    // This is a simplified parser. In a real implementation, you'd use proper JSON parsing
    // and handle various response formats from the LLM

    try {
      // Extract JSON from response if wrapped in markdown or other text
      final jsonStart = response.indexOf('{');
      final jsonEnd = response.lastIndexOf('}');

      if (jsonStart == -1 || jsonEnd == -1) {
        throw Exception('No valid JSON found in response');
      }

      final jsonString = response.substring(jsonStart, jsonEnd + 1);
      // Parse and convert to TravelPlan object
      // This would need proper implementation based on your JSON structure

      return _createFallbackTravelPlan(destination, startDate, endDate, budget, interests);
    } catch (e) {
      // Fallback to a basic plan if parsing fails
      return _createFallbackTravelPlan(destination, startDate, endDate, budget, interests);
    }
  }

  TravelPlan _createFallbackTravelPlan(
      String destination,
      DateTime startDate,
      DateTime endDate,
      double budget,
      List<String> interests,
      ) {
    final duration = endDate.difference(startDate).inDays + 1;
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
            title: 'Morning Exploration',
            description: 'Discover local attractions in $destination',
            location: destination,
            timeSlot: TimeSlot(
              startTime: DateTime(dayDate.year, dayDate.month, dayDate.day, 9, 0),
              endTime: DateTime(dayDate.year, dayDate.month, dayDate.day, 12, 0),
            ),
            type: ActivityType.sightseeing,
            cost: (budget / duration) * 0.4,
          ),
          Activity(
            id: 'activity_${i + 1}_2',
            title: 'Local Cuisine Experience',
            description: 'Try authentic local food in $destination',
            location: destination,
            timeSlot: TimeSlot(
              startTime: DateTime(dayDate.year, dayDate.month, dayDate.day, 12, 30),
              endTime: DateTime(dayDate.year, dayDate.month, dayDate.day, 14, 0),
            ),
            type: ActivityType.food,
            cost: (budget / duration) * 0.3,
          ),
          Activity(
            id: 'activity_${i + 1}_3',
            title: 'Afternoon Activities',
            description: 'Engage in ${interests.isNotEmpty ? interests.first : 'cultural'} activities',
            location: destination,
            timeSlot: TimeSlot(
              startTime: DateTime(dayDate.year, dayDate.month, dayDate.day, 15, 0),
              endTime: DateTime(dayDate.year, dayDate.month, dayDate.day, 18, 0),
            ),
            type: ActivityType.culture,
            cost: (budget / duration) * 0.3,
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
      createdAt: DateTime.now(),
    );
  }
}