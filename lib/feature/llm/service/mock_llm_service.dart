import 'dart:async';
import 'package:logger/logger.dart';

class MockLLMService {
  static final Logger _logger = Logger();
  bool _isLoaded = false;

  Future<void> loadModel(
    String modelPath, {
    int contextSize = 2048,
    int threads = 4,
  }) async {
    _logger.i('Mock LLM: Simulating model loading...');
    await Future.delayed(const Duration(seconds: 1));
    _isLoaded = true;
    _logger.i('Mock LLM: Model loaded successfully');
  }

  Future<void> unloadModel() async {
    _logger.i('Mock LLM: Unloading model...');
    _isLoaded = false;
  }

  Future<String> generateText(
    String prompt, {
    int maxTokens = 512,
    double temperature = 0.7,
  }) async {
    if (!_isLoaded) {
      throw Exception('Model not loaded');
    }

    _logger.d('Mock LLM: Generating response for prompt');

    await Future.delayed(const Duration(seconds: 2));

    return _generateMockResponse(prompt);
  }

  Stream<String> generateTextStream(
    String prompt, {
    int maxTokens = 512,
    double temperature = 0.7,
  }) async* {
    if (!_isLoaded) {
      throw Exception('Model not loaded');
    }

    _logger.d('Mock LLM: Streaming response for prompt');

    final response = _generateMockResponse(prompt);
    final words = response.split(' ');

    for (var i = 0; i < words.length; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      yield words[i] + (i < words.length - 1 ? ' ' : '');
    }
  }

  String _generateMockResponse(String prompt) {
    final lowerPrompt = prompt.toLowerCase();

    if (lowerPrompt.contains('travel plan') || lowerPrompt.contains('trip')) {
      return _getTravelPlanResponse(prompt);
    } else if (lowerPrompt.contains('budget')) {
      return _getBudgetResponse(prompt);
    } else if (lowerPrompt.contains('best time') || lowerPrompt.contains('when to visit')) {
      return _getTimingResponse(prompt);
    } else if (lowerPrompt.contains('hotel') || lowerPrompt.contains('accommodation')) {
      return _getAccommodationResponse(prompt);
    } else if (lowerPrompt.contains('food') || lowerPrompt.contains('restaurant')) {
      return _getFoodResponse(prompt);
    } else if (lowerPrompt.contains('activity') || lowerPrompt.contains('things to do')) {
      return _getActivityResponse(prompt);
    } else if (lowerPrompt.contains('transport') || lowerPrompt.contains('getting around')) {
      return _getTransportResponse(prompt);
    } else {
      return _getGeneralTravelResponse(prompt);
    }
  }

  String _getTravelPlanResponse(String prompt) {
    return '''I'd be happy to help you plan your trip! To create the best travel plan for you, I'll need a few details:

1. **Destination**: Where would you like to go?
2. **Duration**: How many days will you be traveling?
3. **Budget**: What's your approximate budget?
4. **Interests**: What activities interest you most? (e.g., culture, adventure, food, relaxation)
5. **Travel Style**: Do you prefer luxury, mid-range, or budget travel?

Once you provide these details, I can create a detailed day-by-day itinerary with recommendations for accommodations, activities, restaurants, and transportation!

You can also use the "Create Plan" feature in the app to input these details, and I'll generate a comprehensive travel plan for you.''';
  }

  String _getBudgetResponse(String prompt) {
    return '''Great question about budgeting! Here's a general breakdown for different budget levels:

**Budget Travel (\$50-80/day)**:
- Hostels or budget hotels
- Street food and local restaurants
- Public transportation
- Free or low-cost activities

**Mid-Range (\$100-200/day)**:
- 3-star hotels or nice Airbnbs
- Mix of local and international cuisine
- Occasional taxis, mostly public transport
- Paid attractions and tours

**Luxury (\$300+/day)**:
- 4-5 star hotels
- Fine dining experiences
- Private transportation
- Premium tours and activities

These are rough estimates and vary greatly by destination. For a more accurate budget plan, tell me your destination and travel style!''';
  }

  String _getTimingResponse(String prompt) {
    return '''Timing is crucial for a great trip! Here are some general considerations:

**High Season** (Peak tourist time):
- Better weather, more activities open
- Higher prices, larger crowds
- Need to book in advance

**Shoulder Season** (Before/after peak):
- Good weather, fewer crowds
- Better prices, easier bookings
- Great balance of pros and cons

**Low Season** (Off-peak):
- Lowest prices, minimal crowds
- Weather may be less ideal
- Some attractions might be closed

To give you specific timing advice, please tell me which destination you're interested in! Different places have different peak seasons based on climate, holidays, and local events.''';
  }

  String _getAccommodationResponse(String prompt) {
    return '''Let me help you find the right accommodation! Here are your main options:

**Hotels**:
- Professional service, amenities
- Good for business or comfort-focused travelers
- Range from budget to luxury

**Hostels**:
- Budget-friendly, social atmosphere
- Great for meeting other travelers
- Shared or private rooms available

**Airbnb/Vacation Rentals**:
- Local experience, more space
- Kitchen access (save money on meals)
- Good for groups or families

**Boutique Hotels**:
- Unique character, personalized service
- Often locally owned
- Mid to high-end pricing

What's your budget and travel style? I can give you more specific recommendations!''';
  }

  String _getFoodResponse(String prompt) {
    return '''Food is one of the best parts of traveling! Here's my advice:

**Must-Try Local Experiences**:
- Visit local markets in the morning
- Try street food (follow the crowds!)
- Ask locals for their favorite spots
- Take a food tour to learn about local cuisine

**Budget Tips**:
- Eat where locals eat
- Look for lunch specials (cheaper than dinner)
- Visit food courts and hawker centers
- Buy snacks at local shops

**Safety Tips**:
- Choose busy food stalls
- Ensure food is freshly cooked
- Drink bottled or filtered water
- Start with mild dishes if you have a sensitive stomach

Which destination are you interested in? I can provide specific food recommendations!''';
  }

  String _getActivityResponse(String prompt) {
    return '''There are so many ways to explore a destination! Here are some popular categories:

**Cultural Activities**:
- Museums and historical sites
- Local festivals and events
- Traditional performances
- Architecture tours

**Adventure Activities**:
- Hiking and trekking
- Water sports
- Rock climbing
- Cycling tours

**Relaxation**:
- Beach time
- Spa and wellness
- Yoga retreats
- Scenic walks

**Food & Social**:
- Cooking classes
- Food tours
- Night markets
- Local bar/café scene

What type of activities interest you most? Tell me about your destination and I can suggest specific things to do!''';
  }

  String _getTransportResponse(String prompt) {
    return '''Getting around efficiently is key to a great trip! Here are your main options:

**Public Transportation**:
- Most economical option
- Experience local life
- Metro, buses, trains
- Get a transit card/pass for savings

**Taxis/Ride-sharing**:
- Convenient for specific trips
- Use official taxis or apps like Uber/Grab
- Negotiate prices or use meter
- Good for groups splitting costs

**Rental Car**:
- Freedom and flexibility
- Good for rural areas
- Check international driving requirements
- Consider parking costs

**Walking/Cycling**:
- Free and healthy
- Best way to discover hidden gems
- Bike-sharing available in many cities
- Check if your accommodation offers bikes

**Tours**:
- Day trips with transportation included
- Good for seeing multiple sights
- No navigation worries
- Social aspect with other travelers

Which destination are you planning to visit? I can give you specific transportation advice!''';
  }

  String _getGeneralTravelResponse(String prompt) {
    return '''Hello! I'm your AI travel assistant, here to help you plan amazing trips!

I can help you with:
- Creating detailed travel itineraries
- Budget planning and cost estimates
- Destination recommendations
- Accommodation suggestions
- Activity planning
- Transportation advice
- Local food recommendations
- Travel tips and safety information

To get started, you can:
1. Ask me specific questions about travel planning
2. Use the "Create Plan" feature to generate a detailed itinerary
3. Tell me about your travel preferences and I'll provide personalized advice

What would you like to know about your next adventure?

**Note**: I'm currently running in demo mode. For full AI-powered responses, the app will need to download a language model. Check the settings to initialize the full AI assistant.''';
  }

  void dispose() {
    _isLoaded = false;
    _logger.i('Mock LLM: Service disposed');
  }
}
