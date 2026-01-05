class TravelKnowledgeBase {
  static DestinationInfo? getDestinationInfo(String destination) {
    final normalized = destination.toLowerCase().trim();
    if (_destinations.containsKey(normalized)) {
      return _destinations[normalized];
    }
    for (final entry in _destinations.entries) {
      final cityName = entry.key;
      if (normalized.startsWith(cityName) ||
          normalized.contains(cityName)) {
        return entry.value;
      }
    }
    for (final entry in _destinations.entries) {
      final info = entry.value;
      final fullName = '${info.name.toLowerCase()}, ${info.country.toLowerCase()}';
      if (normalized == fullName ||
          normalized.startsWith(info.name.toLowerCase())) {
        return entry.value;
      }
    }
    return null;
  }
  static TransportationInfo? getTransportationInfo(String destination) {
    final normalized = destination.toLowerCase().trim();
    return _transportation[normalized];
  }
  static String? getRoutingAdvice(String query) {
    final queryLower = query.toLowerCase();
    if (!_isRoutingQuery(queryLower)) return null;
    for (final destination in _transportation.keys) {
      if (queryLower.contains(destination)) {
        final info = _transportation[destination];
        if (info != null) {
          return _buildRoutingResponse(info, queryLower);
        }
      }
    }
    return null;
  }
  static bool _isRoutingQuery(String query) {
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
    ];
    return routingKeywords.any((keyword) => query.contains(keyword));
  }
  static String _buildRoutingResponse(TransportationInfo info, String query) {
    final buffer = StringBuffer();
    if (query.contains('airport')) {
      buffer.writeln(' Transportation from ${info.cityName} Airport:\n');
      for (final option in info.airportTransport) {
        buffer.writeln('${option.icon} ${option.name}');
        buffer.writeln('   Cost: ${option.cost}');
        buffer.writeln('   Time: ${option.duration}');
        buffer.writeln('   Details: ${option.description}');
        if (option.tips.isNotEmpty) {
          buffer.writeln('    Tip: ${option.tips.first}');
        }
        buffer.writeln();
      }
    } else {
      buffer.writeln(' Getting Around ${info.cityName}:\n');
      buffer.writeln(info.generalTransportInfo);
      buffer.writeln();
      buffer.writeln('Public Transport Options:');
      for (final option in info.publicTransport) {
        buffer.writeln('• ${option.name}: ${option.description}');
        buffer.writeln('  Cost: ${option.cost}');
      }
    }
    buffer.writeln('\n Tip: Tap "Show Route on Map" to see the route visually');
    return buffer.toString();
  }
  static List<ActivityTemplate> getActivitiesForDestination(
    String destination,
    List<String> interests,
  ) {
    final info = getDestinationInfo(destination);
    if (info == null) return [];
    return info.activities.where((activity) {
      return interests.any((interest) =>
        activity.categories.contains(interest.toLowerCase())
      );
    }).toList();
  }
  static BudgetEstimate getBudgetEstimate(String destination, int days) {
    final info = getDestinationInfo(destination);
    if (info == null) {
      return BudgetEstimate(
        accommodation: 50.0 * days,
        food: 30.0 * days,
        transport: 20.0 * days,
        activities: 40.0 * days,
        total: 140.0 * days,
      );
    }
    return BudgetEstimate(
      accommodation: info.avgAccommodationPerDay * days,
      food: info.avgFoodPerDay * days,
      transport: info.avgTransportPerDay * days,
      activities: info.avgActivitiesPerDay * days,
      total: (info.avgAccommodationPerDay +
              info.avgFoodPerDay +
              info.avgTransportPerDay +
              info.avgActivitiesPerDay) * days,
    );
  }
  static List<String> getTravelTips(String destination) {
    final info = getDestinationInfo(destination);
    return info?.tips ?? _generalTips;
  }
  static final Map<String, DestinationInfo> _destinations = {
    'paris': DestinationInfo(
      name: 'Paris',
      country: 'France',
      description: 'The City of Light, known for art, fashion, gastronomy and culture',
      avgAccommodationPerDay: 80,
      avgFoodPerDay: 40,
      avgTransportPerDay: 15,
      avgActivitiesPerDay: 35,
      activities: [
        ActivityTemplate(
          title: 'Visit the Eiffel Tower',
          description: 'Iconic iron lattice tower and symbol of Paris',
          duration: 2,
          cost: 25,
          categories: ['sightseeing', 'culture', 'photography'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Louvre Museum',
          description: 'World\'s largest art museum, home to Mona Lisa',
          duration: 3,
          cost: 17,
          categories: ['culture', 'art', 'history'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Seine River Cruise',
          description: 'Scenic boat tour along the Seine River',
          duration: 1,
          cost: 15,
          categories: ['sightseeing', 'relaxation', 'photography'],
          bestTimeOfDay: 'evening',
        ),
        ActivityTemplate(
          title: 'Montmartre Walking Tour',
          description: 'Explore the artistic hilltop neighborhood',
          duration: 2,
          cost: 0,
          categories: ['culture', 'art', 'walking'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'French Cuisine Tasting',
          description: 'Sample authentic French dishes and pastries',
          duration: 2,
          cost: 50,
          categories: ['food', 'culture'],
          bestTimeOfDay: 'lunch',
        ),
      ],
      tips: [
        'Buy a Paris Museum Pass for skip-the-line access',
        'Use the Metro for affordable transport',
        'Learn basic French phrases - locals appreciate the effort',
        'Visit popular sites early morning to avoid crowds',
        'Try local bakeries for affordable authentic meals',
      ],
    ),
    'tokyo': DestinationInfo(
      name: 'Tokyo',
      country: 'Japan',
      description: 'Modern metropolis blending tradition with cutting-edge technology',
      avgAccommodationPerDay: 70,
      avgFoodPerDay: 35,
      avgTransportPerDay: 20,
      avgActivitiesPerDay: 30,
      activities: [
        ActivityTemplate(
          title: 'Senso-ji Temple',
          description: 'Tokyo\'s oldest Buddhist temple in Asakusa',
          duration: 2,
          cost: 0,
          categories: ['culture', 'history', 'sightseeing'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Shibuya Crossing',
          description: 'World\'s busiest pedestrian crossing',
          duration: 1,
          cost: 0,
          categories: ['sightseeing', 'photography', 'culture'],
          bestTimeOfDay: 'evening',
        ),
        ActivityTemplate(
          title: 'Tsukiji Outer Market',
          description: 'Fresh seafood and street food market',
          duration: 2,
          cost: 30,
          categories: ['food', 'culture', 'shopping'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Tokyo Skytree',
          description: 'Tallest tower in Japan with panoramic views',
          duration: 2,
          cost: 20,
          categories: ['sightseeing', 'photography'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Traditional Tea Ceremony',
          description: 'Experience authentic Japanese tea ceremony',
          duration: 1,
          cost: 40,
          categories: ['culture', 'relaxation'],
          bestTimeOfDay: 'afternoon',
        ),
      ],
      tips: [
        'Get a Suica or Pasmo card for easy train travel',
        'Cash is king - many places don\'t accept cards',
        'Remove shoes when entering traditional establishments',
        'Trains are extremely punctual - don\'t be late',
        'Try convenience store food - surprisingly good and cheap',
      ],
    ),
    'new york': DestinationInfo(
      name: 'New York',
      country: 'USA',
      description: 'The city that never sleeps, global hub of culture and commerce',
      avgAccommodationPerDay: 150,
      avgFoodPerDay: 50,
      avgTransportPerDay: 15,
      avgActivitiesPerDay: 45,
      activities: [
        ActivityTemplate(
          title: 'Statue of Liberty',
          description: 'Iconic symbol of freedom and democracy',
          duration: 3,
          cost: 25,
          categories: ['sightseeing', 'history', 'culture'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Central Park',
          description: 'Urban oasis in the heart of Manhattan',
          duration: 2,
          cost: 0,
          categories: ['nature', 'walking', 'relaxation'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Times Square',
          description: 'Bright lights and Broadway shows',
          duration: 2,
          cost: 0,
          categories: ['sightseeing', 'entertainment', 'photography'],
          bestTimeOfDay: 'evening',
        ),
        ActivityTemplate(
          title: 'Brooklyn Bridge Walk',
          description: 'Historic bridge with stunning skyline views',
          duration: 1,
          cost: 0,
          categories: ['walking', 'photography', 'sightseeing'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Metropolitan Museum of Art',
          description: 'One of world\'s finest art museums',
          duration: 3,
          cost: 30,
          categories: ['culture', 'art', 'history'],
          bestTimeOfDay: 'afternoon',
        ),
      ],
      tips: [
        'Get a MetroCard for unlimited subway rides',
        'Walk across Brooklyn Bridge for free skyline views',
        'Many museums have "pay what you wish" hours',
        'Avoid yellow cabs - use Uber/Lyft or subway',
        'Pizza slices and food carts offer affordable eats',
      ],
    ),
    'london': DestinationInfo(
      name: 'London',
      country: 'UK',
      description: 'Historic capital blending royal heritage with modern culture',
      avgAccommodationPerDay: 100,
      avgFoodPerDay: 45,
      avgTransportPerDay: 20,
      avgActivitiesPerDay: 35,
      activities: [
        ActivityTemplate(
          title: 'British Museum',
          description: 'World-famous museum with free admission',
          duration: 3,
          cost: 0,
          categories: ['culture', 'history', 'art'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Tower of London',
          description: 'Historic castle and home to Crown Jewels',
          duration: 2,
          cost: 30,
          categories: ['history', 'culture', 'sightseeing'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Thames River Cruise',
          description: 'See London landmarks from the water',
          duration: 1,
          cost: 20,
          categories: ['sightseeing', 'relaxation'],
          bestTimeOfDay: 'evening',
        ),
        ActivityTemplate(
          title: 'Buckingham Palace',
          description: 'Official residence of the British monarch',
          duration: 2,
          cost: 30,
          categories: ['culture', 'history', 'sightseeing'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Covent Garden',
          description: 'Shopping, street performers, and dining',
          duration: 2,
          cost: 0,
          categories: ['shopping', 'entertainment', 'food'],
          bestTimeOfDay: 'afternoon',
        ),
      ],
      tips: [
        'Get an Oyster Card for cheaper public transport',
        'Many top museums are free to enter',
        'Stand on the right on escalators',
        'Book attractions online in advance for discounts',
        'Pubs offer affordable lunch deals',
      ],
    ),
    'rome': DestinationInfo(
      name: 'Rome',
      country: 'Italy',
      description: 'Eternal city of ancient ruins and Renaissance art',
      avgAccommodationPerDay: 85,
      avgFoodPerDay: 35,
      avgTransportPerDay: 10,
      avgActivitiesPerDay: 30,
      activities: [
        ActivityTemplate(
          title: 'Colosseum',
          description: 'Ancient Roman amphitheater and gladiator arena',
          duration: 2,
          cost: 16,
          categories: ['history', 'culture', 'sightseeing'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Vatican Museums & Sistine Chapel',
          description: 'World-class art collection and Michelangelo\'s masterpiece',
          duration: 3,
          cost: 17,
          categories: ['art', 'culture', 'history'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Trevi Fountain',
          description: 'Baroque fountain where you toss coins for wishes',
          duration: 1,
          cost: 0,
          categories: ['sightseeing', 'culture', 'photography'],
          bestTimeOfDay: 'evening',
        ),
        ActivityTemplate(
          title: 'Roman Forum',
          description: 'Ancient ruins of Rome\'s political center',
          duration: 2,
          cost: 16,
          categories: ['history', 'culture', 'sightseeing'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Italian Cooking Class',
          description: 'Learn to make authentic pasta and pizza',
          duration: 3,
          cost: 65,
          categories: ['food', 'culture'],
          bestTimeOfDay: 'afternoon',
        ),
      ],
      tips: [
        'Book Colosseum and Vatican tickets online to skip lines',
        'Walk everywhere - city is compact and walkable',
        'Avoid restaurants near tourist sites - overpriced',
        'Dress modestly for churches (cover shoulders/knees)',
        'Gelato should cost €2-3 per scoop - avoid tourist traps',
      ],
    ),
    'dubai': DestinationInfo(
      name: 'Dubai',
      country: 'United Arab Emirates',
      description: 'Ultra-modern city of skyscrapers, luxury shopping, and desert adventures',
      avgAccommodationPerDay: 120,
      avgFoodPerDay: 50,
      avgTransportPerDay: 30,
      avgActivitiesPerDay: 60,
      activities: [
        ActivityTemplate(
          title: 'Burj Khalifa',
          description: 'World\'s tallest building with observation deck',
          duration: 2,
          cost: 40,
          categories: ['sightseeing', 'photography', 'architecture'],
          bestTimeOfDay: 'evening',
        ),
        ActivityTemplate(
          title: 'Dubai Mall & Aquarium',
          description: 'Massive shopping mall with indoor aquarium',
          duration: 3,
          cost: 35,
          categories: ['shopping', 'entertainment', 'sightseeing'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Desert Safari',
          description: 'Dune bashing, camel riding, and Bedouin dinner',
          duration: 6,
          cost: 60,
          categories: ['adventure', 'culture', 'nature'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Dubai Marina Walk',
          description: 'Waterfront promenade with restaurants and views',
          duration: 2,
          cost: 0,
          categories: ['walking', 'sightseeing', 'photography'],
          bestTimeOfDay: 'evening',
        ),
        ActivityTemplate(
          title: 'Gold Souk & Spice Souk',
          description: 'Traditional markets in old Dubai',
          duration: 2,
          cost: 0,
          categories: ['shopping', 'culture', 'history'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Jumeirah Beach',
          description: 'Public beach with Burj Al Arab views',
          duration: 3,
          cost: 0,
          categories: ['relaxation', 'nature', 'photography'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Dubai Fountain Show',
          description: 'Spectacular water and light show at Dubai Mall',
          duration: 1,
          cost: 0,
          categories: ['entertainment', 'sightseeing'],
          bestTimeOfDay: 'evening',
        ),
        ActivityTemplate(
          title: 'Abra Boat Ride',
          description: 'Traditional water taxi across Dubai Creek',
          duration: 1,
          cost: 1,
          categories: ['culture', 'sightseeing', 'transportation'],
          bestTimeOfDay: 'afternoon',
        ),
      ],
      tips: [
        'Dress modestly in public - cover shoulders and knees',
        'Metro is efficient and affordable for getting around',
        'Visit malls during hot afternoons - they\'re air-conditioned',
        'Book Burj Khalifa tickets online in advance',
        'Taxis are metered and reliable - use them freely',
        'Friday is prayer day - some places close or have limited hours',
        'Stay hydrated - summers are extremely hot',
      ],
    ),
    'abu dhabi': DestinationInfo(
      name: 'Abu Dhabi',
      country: 'United Arab Emirates',
      description: 'UAE capital blending modern luxury with rich cultural heritage',
      avgAccommodationPerDay: 110,
      avgFoodPerDay: 45,
      avgTransportPerDay: 25,
      avgActivitiesPerDay: 50,
      activities: [
        ActivityTemplate(
          title: 'Sheikh Zayed Grand Mosque',
          description: 'Stunning white marble mosque, one of world\'s largest',
          duration: 2,
          cost: 0,
          categories: ['culture', 'history', 'sightseeing', 'architecture'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Louvre Abu Dhabi',
          description: 'Art and civilization museum under iconic dome',
          duration: 3,
          cost: 17,
          categories: ['art', 'culture', 'history'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Qasr Al Watan',
          description: 'Presidential palace showcasing Arabian heritage',
          duration: 2,
          cost: 18,
          categories: ['culture', 'history', 'architecture'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Corniche Beach',
          description: 'Beautiful waterfront promenade and beach',
          duration: 2,
          cost: 0,
          categories: ['relaxation', 'nature', 'walking'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Ferrari World',
          description: 'Indoor theme park with world\'s fastest roller coaster',
          duration: 4,
          cost: 85,
          categories: ['entertainment', 'adventure'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Heritage Village',
          description: 'Traditional Bedouin village showcasing UAE history',
          duration: 1,
          cost: 0,
          categories: ['culture', 'history'],
          bestTimeOfDay: 'morning',
        ),
      ],
      tips: [
        'Grand Mosque requires modest dress - abayas provided for women',
        'Best visited November to March - cooler weather',
        'Public transport is limited - consider renting a car or using taxis',
        'Book Louvre tickets online to skip queues',
        'Respect local customs and Islamic traditions',
        'Many attractions close during prayer times',
      ],
    ),
    'cairo': DestinationInfo(
      name: 'Cairo',
      country: 'Egypt',
      description: 'Ancient city home to pyramids, pharaohs, and timeless history',
      avgAccommodationPerDay: 50,
      avgFoodPerDay: 20,
      avgTransportPerDay: 10,
      avgActivitiesPerDay: 35,
      activities: [
        ActivityTemplate(
          title: 'Pyramids of Giza & Sphinx',
          description: 'Ancient wonders of the world, 4,500 years old',
          duration: 4,
          cost: 20,
          categories: ['history', 'sightseeing', 'photography', 'culture'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Egyptian Museum',
          description: 'World\'s largest collection of ancient Egyptian artifacts',
          duration: 3,
          cost: 12,
          categories: ['history', 'culture', 'art'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Khan el-Khalili Bazaar',
          description: 'Historic market dating back to 14th century',
          duration: 2,
          cost: 0,
          categories: ['shopping', 'culture', 'history'],
          bestTimeOfDay: 'evening',
        ),
        ActivityTemplate(
          title: 'Nile River Cruise',
          description: 'Dinner cruise with traditional music and dance',
          duration: 3,
          cost: 30,
          categories: ['relaxation', 'entertainment', 'food', 'culture'],
          bestTimeOfDay: 'evening',
        ),
        ActivityTemplate(
          title: 'Citadel of Saladin',
          description: 'Medieval Islamic fortification with panoramic views',
          duration: 2,
          cost: 10,
          categories: ['history', 'culture', 'sightseeing'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Al-Azhar Park',
          description: 'Beautiful green space with city views',
          duration: 1,
          cost: 1,
          categories: ['relaxation', 'nature', 'photography'],
          bestTimeOfDay: 'afternoon',
        ),
      ],
      tips: [
        'Negotiate prices in markets - start at 50% of asking price',
        'Hire a licensed guide for pyramids - avoid touts',
        'Dress modestly, especially at religious sites',
        'Drink only bottled water',
        'Use Uber/Careem for reliable transport',
        'Best time to visit: October to April',
        'Carry small bills - change can be hard to get',
      ],
    ),
    'marrakech': DestinationInfo(
      name: 'Marrakech',
      country: 'Morocco',
      description: 'Red city of souks, palaces, and Arabian nights atmosphere',
      avgAccommodationPerDay: 60,
      avgFoodPerDay: 25,
      avgTransportPerDay: 10,
      avgActivitiesPerDay: 30,
      activities: [
        ActivityTemplate(
          title: 'Jemaa el-Fnaa Square',
          description: 'Vibrant main square with food stalls and entertainers',
          duration: 2,
          cost: 0,
          categories: ['culture', 'food', 'entertainment', 'photography'],
          bestTimeOfDay: 'evening',
        ),
        ActivityTemplate(
          title: 'Bahia Palace',
          description: 'Stunning 19th century palace with intricate tilework',
          duration: 2,
          cost: 7,
          categories: ['history', 'culture', 'architecture'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Majorelle Garden',
          description: 'Botanical garden with vibrant blue buildings',
          duration: 1,
          cost: 10,
          categories: ['nature', 'photography', 'art'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Medina Souks',
          description: 'Maze of traditional markets selling crafts and spices',
          duration: 3,
          cost: 0,
          categories: ['shopping', 'culture', 'history'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Hammam Experience',
          description: 'Traditional Moroccan steam bath and massage',
          duration: 2,
          cost: 25,
          categories: ['relaxation', 'culture'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Koutoubia Mosque',
          description: 'Largest mosque in Marrakech with iconic minaret',
          duration: 1,
          cost: 0,
          categories: ['culture', 'history', 'architecture', 'photography'],
          bestTimeOfDay: 'evening',
        ),
      ],
      tips: [
        'Bargain in souks - aim for 40-50% of initial price',
        'Get lost in the medina - it\'s part of the experience',
        'Try street food at Jemaa el-Fnaa - it\'s safe and delicious',
        'Dress modestly - cover shoulders and knees',
        'Stay in a riad for authentic Moroccan experience',
        'Learn basic French or Arabic phrases - helpful for shopping',
      ],
    ),
    'doha': DestinationInfo(
      name: 'Doha',
      country: 'Qatar',
      description: 'Modern Arabian capital blending tradition with futuristic architecture',
      avgAccommodationPerDay: 100,
      avgFoodPerDay: 40,
      avgTransportPerDay: 20,
      avgActivitiesPerDay: 45,
      activities: [
        ActivityTemplate(
          title: 'Museum of Islamic Art',
          description: 'World-class museum with stunning architecture',
          duration: 2,
          cost: 0,
          categories: ['art', 'culture', 'history', 'architecture'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Souq Waqif',
          description: 'Traditional market with spices, textiles, and handicrafts',
          duration: 2,
          cost: 0,
          categories: ['shopping', 'culture', 'food'],
          bestTimeOfDay: 'evening',
        ),
        ActivityTemplate(
          title: 'The Pearl-Qatar',
          description: 'Artificial island with luxury shopping and dining',
          duration: 2,
          cost: 0,
          categories: ['shopping', 'walking', 'sightseeing'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Desert Safari',
          description: 'Dune bashing and inland sea visit',
          duration: 5,
          cost: 50,
          categories: ['adventure', 'nature'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Katara Cultural Village',
          description: 'Cultural center with amphitheater and galleries',
          duration: 2,
          cost: 0,
          categories: ['culture', 'art', 'entertainment'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Corniche Waterfront',
          description: '7km waterfront promenade with skyline views',
          duration: 1,
          cost: 0,
          categories: ['walking', 'photography', 'relaxation'],
          bestTimeOfDay: 'evening',
        ),
      ],
      tips: [
        'Dress modestly in public areas',
        'Metro is modern and connects major attractions',
        'Visit during winter months (November-March) for pleasant weather',
        'Most museums are free or very affordable',
        'Taxis are metered and reasonable',
        'Friday is weekend - some places have reduced hours',
      ],
    ),
    'amman': DestinationInfo(
      name: 'Amman',
      country: 'Jordan',
      description: 'Ancient city built on seven hills with Roman ruins and modern culture',
      avgAccommodationPerDay: 55,
      avgFoodPerDay: 25,
      avgTransportPerDay: 15,
      avgActivitiesPerDay: 30,
      activities: [
        ActivityTemplate(
          title: 'Roman Theater',
          description: '6,000-seat theater from 2nd century AD',
          duration: 1,
          cost: 3,
          categories: ['history', 'culture', 'sightseeing'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Citadel (Jabal al-Qal\'a)',
          description: 'Ancient hilltop site with Temple of Hercules',
          duration: 2,
          cost: 3,
          categories: ['history', 'sightseeing', 'photography'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Rainbow Street',
          description: 'Trendy area with cafes, restaurants, and galleries',
          duration: 2,
          cost: 0,
          categories: ['food', 'shopping', 'culture'],
          bestTimeOfDay: 'evening',
        ),
        ActivityTemplate(
          title: 'Jordan Museum',
          description: 'National museum with Dead Sea Scrolls',
          duration: 2,
          cost: 5,
          categories: ['history', 'culture', 'art'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Souk Jara (Friday Market)',
          description: 'Weekly arts and crafts market (summer only)',
          duration: 2,
          cost: 0,
          categories: ['shopping', 'culture', 'food'],
          bestTimeOfDay: 'evening',
        ),
        ActivityTemplate(
          title: 'King Abdullah Mosque',
          description: 'Blue-domed mosque open to non-Muslims',
          duration: 1,
          cost: 3,
          categories: ['culture', 'history', 'architecture'],
          bestTimeOfDay: 'morning',
        ),
      ],
      tips: [
        'Use Jordan Pass if visiting Petra - includes visa and entry',
        'Learn basic Arabic phrases - locals appreciate it',
        'Try mansaf (national dish) at local restaurant',
        'Taxis don\'t use meters - agree on price beforehand',
        'Amman is very safe for tourists',
        'Best weather: March-May and September-November',
      ],
    ),
    'barcelona': DestinationInfo(
      name: 'Barcelona',
      country: 'Spain',
      description: 'Vibrant Mediterranean city famous for Gaudí architecture, beaches, and food',
      avgAccommodationPerDay: 90,
      avgFoodPerDay: 40,
      avgTransportPerDay: 15,
      avgActivitiesPerDay: 35,
      activities: [
        ActivityTemplate(
          title: 'Sagrada Familia',
          description: 'Gaudí\'s unfinished masterpiece basilica',
          duration: 2,
          cost: 26,
          categories: ['architecture', 'culture', 'sightseeing', 'art'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Park Güell',
          description: 'Whimsical park with colorful mosaics',
          duration: 2,
          cost: 10,
          categories: ['art', 'nature', 'photography', 'sightseeing'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'La Rambla & Gothic Quarter',
          description: 'Historic medieval streets and bustling boulevard',
          duration: 3,
          cost: 0,
          categories: ['walking', 'culture', 'history', 'shopping'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Barceloneta Beach',
          description: 'Popular city beach with restaurants',
          duration: 3,
          cost: 0,
          categories: ['relaxation', 'nature', 'food'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Tapas Tour',
          description: 'Sample traditional Spanish small plates',
          duration: 3,
          cost: 50,
          categories: ['food', 'culture'],
          bestTimeOfDay: 'evening',
        ),
        ActivityTemplate(
          title: 'Casa Batlló',
          description: 'Gaudí\'s modernist house museum',
          duration: 1,
          cost: 29,
          categories: ['architecture', 'art', 'culture'],
          bestTimeOfDay: 'morning',
        ),
      ],
      tips: [
        'Book Sagrada Familia and Park Güell tickets online in advance',
        'Avoid restaurants on La Rambla - overpriced tourist traps',
        'Use metro - efficient and cheap (€11.35 for 10 journeys)',
        'Siesta time: many shops close 2-5pm',
        'Watch for pickpockets in tourist areas',
        'Try pintxos and vermut at local bars',
      ],
    ),
    'istanbul': DestinationInfo(
      name: 'Istanbul',
      country: 'Turkey',
      description: 'Historic city straddling Europe and Asia with rich Ottoman heritage',
      avgAccommodationPerDay: 65,
      avgFoodPerDay: 30,
      avgTransportPerDay: 10,
      avgActivitiesPerDay: 25,
      activities: [
        ActivityTemplate(
          title: 'Hagia Sophia',
          description: 'Byzantine architectural marvel, now a mosque',
          duration: 2,
          cost: 0,
          categories: ['history', 'architecture', 'culture', 'sightseeing'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Blue Mosque',
          description: 'Stunning Ottoman mosque with blue tiles',
          duration: 1,
          cost: 0,
          categories: ['culture', 'architecture', 'sightseeing'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Grand Bazaar',
          description: 'One of world\'s largest covered markets',
          duration: 2,
          cost: 0,
          categories: ['shopping', 'culture', 'history'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Bosphorus Cruise',
          description: 'Scenic boat ride between Europe and Asia',
          duration: 2,
          cost: 15,
          categories: ['sightseeing', 'relaxation', 'photography'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Topkapi Palace',
          description: 'Ottoman sultans\' palace with treasury',
          duration: 3,
          cost: 20,
          categories: ['history', 'culture', 'art'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Turkish Bath (Hammam)',
          description: 'Traditional steam bath experience',
          duration: 2,
          cost: 40,
          categories: ['relaxation', 'culture'],
          bestTimeOfDay: 'afternoon',
        ),
      ],
      tips: [
        'Get an Istanbulkart for all public transport',
        'Dress modestly for mosques - cover shoulders and knees',
        'Bargain at Grand Bazaar - start at 50% of asking price',
        'Try street food - simit, döner, and balik ekmek',
        'Most museums closed on Mondays',
        'Ramadan affects restaurant and attraction hours',
      ],
    ),
    'singapore': DestinationInfo(
      name: 'Singapore',
      country: 'Singapore',
      description: 'Modern city-state blending cultures with world-class food and attractions',
      avgAccommodationPerDay: 120,
      avgFoodPerDay: 40,
      avgTransportPerDay: 15,
      avgActivitiesPerDay: 40,
      activities: [
        ActivityTemplate(
          title: 'Gardens by the Bay',
          description: 'Futuristic gardens with Supertree Grove',
          duration: 3,
          cost: 28,
          categories: ['nature', 'sightseeing', 'photography'],
          bestTimeOfDay: 'evening',
        ),
        ActivityTemplate(
          title: 'Marina Bay Sands SkyPark',
          description: 'Observation deck with panoramic views',
          duration: 1,
          cost: 26,
          categories: ['sightseeing', 'photography'],
          bestTimeOfDay: 'evening',
        ),
        ActivityTemplate(
          title: 'Hawker Center Food Tour',
          description: 'Sample local dishes at food centers',
          duration: 2,
          cost: 20,
          categories: ['food', 'culture'],
          bestTimeOfDay: 'lunch',
        ),
        ActivityTemplate(
          title: 'Chinatown & Little India',
          description: 'Explore vibrant ethnic neighborhoods',
          duration: 3,
          cost: 0,
          categories: ['culture', 'shopping', 'food'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Sentosa Island',
          description: 'Beach resort island with attractions',
          duration: 5,
          cost: 40,
          categories: ['entertainment', 'relaxation', 'nature'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Night Safari',
          description: 'World\'s first nocturnal wildlife park',
          duration: 3,
          cost: 49,
          categories: ['nature', 'entertainment'],
          bestTimeOfDay: 'evening',
        ),
      ],
      tips: [
        'Get an EZ-Link card for MRT and buses',
        'Hawker centers offer cheap, delicious food',
        'Carry tissues - public toilets may not have paper',
        'No chewing gum - it\'s banned',
        'Stay hydrated - hot and humid year-round',
        'Book attractions online for better deals',
      ],
    ),
    'bangkok': DestinationInfo(
      name: 'Bangkok',
      country: 'Thailand',
      description: 'Bustling capital with golden temples, street food, and vibrant nightlife',
      avgAccommodationPerDay: 45,
      avgFoodPerDay: 20,
      avgTransportPerDay: 10,
      avgActivitiesPerDay: 25,
      activities: [
        ActivityTemplate(
          title: 'Grand Palace & Wat Phra Kaew',
          description: 'Stunning royal palace and Temple of Emerald Buddha',
          duration: 3,
          cost: 17,
          categories: ['history', 'culture', 'architecture', 'sightseeing'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Wat Arun',
          description: 'Temple of Dawn with intricate porcelain details',
          duration: 1,
          cost: 3,
          categories: ['culture', 'architecture', 'photography'],
          bestTimeOfDay: 'afternoon',
        ),
        ActivityTemplate(
          title: 'Floating Market',
          description: 'Traditional market on canals',
          duration: 3,
          cost: 10,
          categories: ['culture', 'food', 'shopping'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Street Food Tour',
          description: 'Sample authentic Thai street food',
          duration: 3,
          cost: 20,
          categories: ['food', 'culture'],
          bestTimeOfDay: 'evening',
        ),
        ActivityTemplate(
          title: 'Chatuchak Weekend Market',
          description: 'Massive market with 15,000 stalls',
          duration: 3,
          cost: 0,
          categories: ['shopping', 'culture', 'food'],
          bestTimeOfDay: 'morning',
        ),
        ActivityTemplate(
          title: 'Thai Cooking Class',
          description: 'Learn to cook traditional Thai dishes',
          duration: 4,
          cost: 35,
          categories: ['food', 'culture'],
          bestTimeOfDay: 'morning',
        ),
      ],
      tips: [
        'Dress modestly at temples - cover shoulders and knees',
        'Use Grab app for taxis - avoid taxi scams',
        'BTS Skytrain and MRT are best for avoiding traffic',
        'Bargain at markets but not in malls',
        'Street food is safe, delicious, and very cheap',
        'Stay near BTS/MRT stations for convenience',
        'Avoid tuk-tuks for long distances - overpriced',
      ],
    ),
  };
  static final Map<String, TransportationInfo> _transportation = {
    'paris': TransportationInfo(
      cityName: 'Paris',
      airportTransport: [
        TransportOption(
          name: 'RER B Train',
          icon: '',
          description: 'Direct train from CDG Airport to city center',
          cost: '€10-11',
          duration: '30-40 minutes',
          tips: [
            'Runs every 10-15 minutes from 5am to midnight',
            'Stops at Gare du Nord, Châtelet-Les Halles, and more',
            'Buy tickets at airport machines'
          ],
        ),
        TransportOption(
          name: 'Roissybus',
          icon: '',
          description: 'Express bus to Opéra',
          cost: '€13.70',
          duration: '60 minutes',
          tips: [
            'Runs every 15-20 minutes',
            'Direct to Opéra Garnier',
            'Good option if staying near Opéra'
          ],
        ),
        TransportOption(
          name: 'Taxi',
          icon: '',
          description: 'Direct door-to-door service',
          cost: '€50-70 (flat rate to city center)',
          duration: '30-50 minutes depending on traffic',
          tips: [
            'Fixed flat rate to Right Bank (€53) or Left Bank (€58)',
            'Available 24/7',
            'Use official taxi stands only'
          ],
        ),
        TransportOption(
          name: 'Uber/Bolt',
          icon: '',
          description: 'Private ride-sharing service',
          cost: '€40-60',
          duration: '30-50 minutes',
          tips: [
            'Book through app before arrival',
            'Meet at designated pickup zones',
            'Price varies with demand'
          ],
        ),
      ],
      publicTransport: [
        TransportOption(
          name: 'Metro',
          icon: '',
          description: 'Extensive subway network covering all Paris',
          cost: '€1.90 per journey, €14.90 for 10 tickets',
          duration: 'Varies by route',
          tips: [
            '16 lines covering the entire city',
            'Runs 5:30am to 1:15am (2:15am on weekends)',
            'Buy a carnet (10 tickets) to save money'
          ],
        ),
        TransportOption(
          name: 'Bus',
          icon: '',
          description: 'Comprehensive bus network',
          cost: '€1.90 per journey',
          duration: 'Varies by route',
          tips: [
            'Same tickets as metro',
            'Good for sightseeing',
            'Night buses (Noctilien) run after metro closes'
          ],
        ),
        TransportOption(
          name: 'Vélib\' (Bike Share)',
          icon: '',
          description: 'Public bike sharing system',
          cost: '€1 for 30 minutes',
          duration: 'Self-paced',
          tips: [
            'Over 20,000 bikes at 1,800 stations',
            'Download Vélib\' app',
            'Great for short trips and sightseeing'
          ],
        ),
      ],
      generalTransportInfo: 'Paris has one of the best public transport systems in the world. The Metro is fast, efficient, and covers the entire city. Consider buying a Paris Visite pass for unlimited travel.',
    ),
    'tokyo': TransportationInfo(
      cityName: 'Tokyo',
      airportTransport: [
        TransportOption(
          name: 'Narita Express (N\'EX)',
          icon: '',
          description: 'Fast train from Narita Airport',
          cost: '¥3,070 (~\$28)',
          duration: '60 minutes to Tokyo Station',
          tips: [
            'Most comfortable option',
            'Reserved seating',
            'Runs every 30 minutes',
            'Foreign tourist discount available'
          ],
        ),
        TransportOption(
          name: 'Keisei Skyliner',
          icon: '',
          description: 'Express train to Ueno',
          cost: '¥2,520 (~\$23)',
          duration: '45 minutes to Ueno',
          tips: [
            'Fastest option to Ueno area',
            'More frequent than N\'EX',
            'Good if staying in north/east Tokyo'
          ],
        ),
        TransportOption(
          name: 'Airport Limousine Bus',
          icon: '',
          description: 'Direct bus to major hotels',
          cost: '¥3,200 (~\$29)',
          duration: '75-120 minutes',
          tips: [
            'Goes to major hotels and districts',
            'Good if carrying lots of luggage',
            'Can be delayed by traffic'
          ],
        ),
        TransportOption(
          name: 'Taxi',
          icon: '',
          description: 'Private taxi service',
          cost: '¥20,000-30,000 (~\$180-270)',
          duration: '60-90 minutes',
          tips: [
            'Very expensive option',
            'Use only if sharing with group',
            'Highway tolls included'
          ],
        ),
      ],
      publicTransport: [
        TransportOption(
          name: 'JR Yamanote Line',
          icon: '',
          description: 'Circular line connecting major stations',
          cost: '¥140-200 per journey',
          duration: 'Loop takes 60 minutes',
          tips: [
            'Most useful line for tourists',
            'Connects Tokyo, Shibuya, Shinjuku, Ikebukuro',
            'Consider JR Pass for multiple days'
          ],
        ),
        TransportOption(
          name: 'Tokyo Metro',
          icon: '',
          description: '9 subway lines across Tokyo',
          cost: '¥170-320 per journey',
          duration: 'Varies by route',
          tips: [
            'Buy IC card (Suica/Pasmo) for convenience',
            'Download Tokyo Metro app',
            'Runs until midnight'
          ],
        ),
        TransportOption(
          name: 'Taxi',
          icon: '',
          description: 'Metered taxi service',
          cost: '¥500 base + distance',
          duration: 'Varies',
          tips: [
            'Clean and safe but expensive',
            'Flag at taxi stands or street',
            'Most drivers don\'t speak English'
          ],
        ),
      ],
      generalTransportInfo: 'Tokyo\'s public transport is incredibly efficient and punctual. Get an IC card (Suica or Pasmo) for seamless travel. The subway can be confusing initially - use Google Maps or Tokyo Metro app.',
    ),
    'london': TransportationInfo(
      cityName: 'London',
      airportTransport: [
        TransportOption(
          name: 'Heathrow Express',
          icon: '',
          description: 'Fast train to Paddington Station',
          cost: '£25-37 (~\$32-47)',
          duration: '15 minutes',
          tips: [
            'Fastest option',
            'Runs every 15 minutes',
            'Book online for cheaper fares',
            'Good for West London hotels'
          ],
        ),
        TransportOption(
          name: 'Piccadilly Line (Tube)',
          icon: '',
          description: 'Underground to central London',
          cost: '£5.50 with Oyster card',
          duration: '45-60 minutes',
          tips: [
            'Most economical option',
            'Direct to many central locations',
            'Can be crowded with luggage',
            'Get Oyster card or use contactless'
          ],
        ),
        TransportOption(
          name: 'National Express Coach',
          icon: '',
          description: 'Budget coach service',
          cost: '£6-10',
          duration: '60-90 minutes',
          tips: [
            'Cheapest option',
            'Book online in advance',
            'Stops at Victoria Coach Station',
            'Can be delayed by traffic'
          ],
        ),
        TransportOption(
          name: 'Black Cab/Taxi',
          icon: '',
          description: 'Licensed London taxi',
          cost: '£50-90',
          duration: '45-75 minutes',
          tips: [
            'Fixed fares available',
            'Available 24/7',
            'Can use taxi apps like Gett',
            'Price includes luggage'
          ],
        ),
      ],
      publicTransport: [
        TransportOption(
          name: 'London Underground (Tube)',
          icon: '',
          description: 'Extensive subway network',
          cost: '£2.50-7 per journey with Oyster/Contactless',
          duration: 'Varies by route',
          tips: [
            '11 lines covering London',
            'Get Oyster card or use contactless payment',
            'Mind the gap!',
            'Cheaper to travel off-peak'
          ],
        ),
        TransportOption(
          name: 'Double-Decker Bus',
          icon: '',
          description: 'Iconic red London buses',
          cost: '£1.65 per journey',
          duration: 'Varies by route',
          tips: [
            'Great for sightseeing',
            'Must use Oyster or contactless (no cash)',
            'Hop-on hop-off within 1 hour',
            'Night buses available'
          ],
        ),
        TransportOption(
          name: 'Santander Cycles',
          icon: '',
          description: 'Public bike hire scheme',
          cost: '£2 for 24 hours',
          duration: 'Self-paced',
          tips: [
            'First 30 minutes free',
            'Over 800 docking stations',
            'Good for short journeys',
            'Use app to find available bikes'
          ],
        ),
      ],
      generalTransportInfo: 'London has excellent public transport. Get an Oyster card or use contactless payment for the best fares. The Tube is fastest but buses offer better views. Download Citymapper app for journey planning.',
    ),
    'new york': TransportationInfo(
      cityName: 'New York',
      airportTransport: [
        TransportOption(
          name: 'JFK AirTrain + Subway',
          icon: '',
          description: 'AirTrain to Jamaica Station, then subway',
          cost: '\$10.75 total',
          duration: '60-90 minutes',
          tips: [
            'Most economical option',
            'Can be complex with luggage',
            'AirTrain \$8 + Subway \$2.75',
            'Runs 24/7'
          ],
        ),
        TransportOption(
          name: 'Express Bus',
          icon: '',
          description: 'NYC Airporter bus to Manhattan',
          cost: '\$19-40',
          duration: '60-90 minutes',
          tips: [
            'Drops at major hotels/locations',
            'More comfortable than subway',
            'Can be delayed by traffic',
            'Book online for discount'
          ],
        ),
        TransportOption(
          name: 'Taxi (Yellow Cab)',
          icon: '',
          description: 'Metered yellow taxi',
          cost: '\$52 flat rate + tolls and tip',
          duration: '45-75 minutes',
          tips: [
            'Flat rate to Manhattan',
            'Add 15-20% tip',
            'Tolls extra (\$6.50-9.50)',
            'Available 24/7'
          ],
        ),
        TransportOption(
          name: 'Uber/Lyft',
          icon: '',
          description: 'Ride-sharing service',
          cost: '\$50-80',
          duration: '45-75 minutes',
          tips: [
            'Price varies with demand',
            'Surge pricing common at peak times',
            'Book through app',
            'Meet at designated pickup area'
          ],
        ),
      ],
      publicTransport: [
        TransportOption(
          name: 'NYC Subway',
          icon: '',
          description: 'Extensive 24/7 subway system',
          cost: '\$2.75 per ride',
          duration: 'Varies by route',
          tips: [
            'Runs 24 hours a day',
            'Get MetroCard or use OMNY contactless',
            'Download MTA app for service updates',
            'Express vs local trains - check before boarding'
          ],
        ),
        TransportOption(
          name: 'Bus',
          icon: '',
          description: 'City bus network',
          cost: '\$2.75 per ride',
          duration: 'Varies by route',
          tips: [
            'Same fare as subway',
            'Free transfer between bus/subway within 2 hours',
            'Select Bus Service (SBS) is faster',
            'Good for crosstown travel'
          ],
        ),
        TransportOption(
          name: 'Citi Bike',
          icon: '',
          description: 'Bike share system',
          cost: '\$3.50 for 30 minutes',
          duration: 'Self-paced',
          tips: [
            'Great for nice weather',
            'Lots of stations in Manhattan',
            'Download Citi Bike app',
            'Bike lanes available on many streets'
          ],
        ),
      ],
      generalTransportInfo: 'NYC subway runs 24/7 and is the fastest way to get around. Get a MetroCard or use OMNY contactless payment. Walking is also great for exploring neighborhoods. Taxis are plentiful but can be expensive.',
    ),
  };
  static final List<String> _generalTips = [
    'Research local customs and etiquette',
    'Download offline maps before traveling',
    'Keep copies of important documents',
    'Learn basic phrases in local language',
    'Use local public transport to save money',
    'Always carry emergency contact information',
    'Inform your bank about travel plans to avoid card blocks',
    'Pack a basic first-aid kit',
    'Keep valuables in hotel safe when not needed',
  ];
  static final Map<String, String> _travelFAQ = {
    'visa': 'Visa requirements vary by country and your nationality. Check with the embassy or consulate of your destination country at least 2-3 months before travel. Many countries offer visa-free entry or visa-on-arrival for tourists. Always ensure your passport is valid for at least 6 months beyond your planned departure date.',
    'insurance': 'Travel insurance is highly recommended and covers medical emergencies, trip cancellations, lost luggage, and other unexpected events. Choose a policy that includes medical coverage (minimum \$50,000), emergency evacuation, trip cancellation/interruption, baggage loss/delay, and 24/7 assistance hotline.',
    'money': 'Always carry multiple payment options: credit cards (Visa/Mastercard widely accepted), debit card for ATM withdrawals, some local currency (exchange at banks), and a backup card kept separately. Notify your bank before traveling, use ATMs inside banks when possible, and avoid airport currency exchanges (poor rates).',
    'safety': 'Essential safety guidelines: Research safe/unsafe areas, keep copies of documents separately, share itinerary with family/friends, use hotel safes for valuables, be aware of common scams, trust your instincts, and have emergency contacts readily available.',
    'packing': 'Smart packing essentials: Roll clothes to save space, pack versatile layerable clothing, bring one extra day\'s medication, keep valuables in carry-on, use packing cubes, bring universal power adapter, download offline maps, pack reusable water bottle, and include photocopies of important documents.',
    'health': 'Stay healthy while traveling: Check required vaccinations 6-8 weeks before departure, bring prescription medications in original containers, pack basic medications, drink bottled water in developing countries, wash hands frequently, use insect repellent in tropical areas, and get travel insurance with medical coverage.',
    'language': 'Communicate effectively: Learn 10-15 basic phrases (hello, thank you, help), download offline translation app (Google Translate), carry hotel business card with address in local language, use translation apps with camera feature for signs/menus, speak slowly and clearly, and use gestures when needed.',
    'customs': 'Respect local cultures: Research dress codes (especially religious sites), learn appropriate greetings, understand tipping customs (varies widely), know photography restrictions, respect personal space norms, learn dining etiquette, and be mindful of religious practices and holidays.',
    'accommodation': 'Choose and book wisely: Read recent reviews on multiple platforms, check location accessibility to attractions, verify cancellation policies, book directly for better rates sometimes, consider neighborhoods carefully, check for hidden fees, and verify included amenities (WiFi, breakfast).',
    'airport': 'Navigate airports smoothly: Arrive 3 hours early for international flights, check in online 24 hours before, have passport and boarding pass easily accessible, pack liquids in clear bag (100ml containers), wear easy-to-remove shoes, download airline app for updates, and have backup plans for delays.',
    'solo travel': 'Solo travel safely: Stay in social accommodations (hostels), join group tours or activities, share location with trusted contacts, trust your instincts, avoid walking alone at night in unfamiliar areas, keep valuable items hidden, make copies of important documents, and stay in well-reviewed accommodations.',
    'budget': 'Travel on a budget: Use public transportation, eat at local markets and street food, book accommodations with kitchen facilities, take advantage of free walking tours, visit free attractions and museums on free days, travel during off-peak seasons, use budget airlines, and cook some meals yourself.',
    'jet lag': 'Minimize jet lag effects: Adjust sleep schedule before departure, stay hydrated during flight, avoid alcohol and caffeine on plane, get sunlight upon arrival, try to stay awake until local bedtime, exercise lightly after arrival, and consider melatonin supplements.',
    'scams': 'Common travel scams to avoid: Overcharging by taxis (use meter or agree price first), fake "closed" attraction scam, fake police asking to see wallet, friendship bracelet trap, street games and betting, "free" tours demanding high tips, restaurant bill padding, and credit card skimming. Always be cautious and verify official services.',
  };
  static String? searchFAQ(String query) {
    final queryLower = query.toLowerCase();
    for (final entry in _travelFAQ.entries) {
      if (queryLower.contains(entry.key)) {
        return entry.value;
      }
    }
    if (queryLower.contains('visa') || queryLower.contains('passport')) {
      return _travelFAQ['visa'];
    }
    if (queryLower.contains('insur')) {
      return _travelFAQ['insurance'];
    }
    if (queryLower.contains('money') || queryLower.contains('currency') || queryLower.contains('cash')) {
      return _travelFAQ['money'];
    }
    if (queryLower.contains('safe') || queryLower.contains('danger')) {
      return _travelFAQ['safety'];
    }
    if (queryLower.contains('pack') || queryLower.contains('luggage') || queryLower.contains('baggage')) {
      return _travelFAQ['packing'];
    }
    if (queryLower.contains('sick') || queryLower.contains('doctor') || queryLower.contains('vaccin') || queryLower.contains('medical')) {
      return _travelFAQ['health'];
    }
    if (queryLower.contains('speak') || queryLower.contains('translate') || queryLower.contains('language barrier')) {
      return _travelFAQ['language'];
    }
    if (queryLower.contains('custom') || queryLower.contains('culture') || queryLower.contains('etiquette')) {
      return _travelFAQ['customs'];
    }
    if (queryLower.contains('hotel') || queryLower.contains('hostel') || queryLower.contains('where to stay')) {
      return _travelFAQ['accommodation'];
    }
    if (queryLower.contains('airport') || queryLower.contains('flight')) {
      return _travelFAQ['airport'];
    }
    if (queryLower.contains('solo') || queryLower.contains('alone') || queryLower.contains('by myself')) {
      return _travelFAQ['solo travel'];
    }
    if (queryLower.contains('budget') || queryLower.contains('cheap') || queryLower.contains('save money')) {
      return _travelFAQ['budget'];
    }
    if (queryLower.contains('jet lag') || queryLower.contains('tired') || queryLower.contains('time zone')) {
      return _travelFAQ['jet lag'];
    }
    if (queryLower.contains('scam') || queryLower.contains('cheat') || queryLower.contains('fraud')) {
      return _travelFAQ['scams'];
    }
    return null;
  }
}
class DestinationInfo {
  final String name;
  final String country;
  final String description;
  final double avgAccommodationPerDay;
  final double avgFoodPerDay;
  final double avgTransportPerDay;
  final double avgActivitiesPerDay;
  final List<ActivityTemplate> activities;
  final List<String> tips;
  DestinationInfo({
    required this.name,
    required this.country,
    required this.description,
    required this.avgAccommodationPerDay,
    required this.avgFoodPerDay,
    required this.avgTransportPerDay,
    required this.avgActivitiesPerDay,
    required this.activities,
    required this.tips,
  });
}
class ActivityTemplate {
  final String title;
  final String description;
  final int duration;
  final double cost;
  final List<String> categories;
  final String bestTimeOfDay;
  ActivityTemplate({
    required this.title,
    required this.description,
    required this.duration,
    required this.cost,
    required this.categories,
    required this.bestTimeOfDay,
  });
}
class BudgetEstimate {
  final double accommodation;
  final double food;
  final double transport;
  final double activities;
  final double total;
  BudgetEstimate({
    required this.accommodation,
    required this.food,
    required this.transport,
    required this.activities,
    required this.total,
  });
}
class TransportOption {
  final String name;
  final String icon;
  final String description;
  final String cost;
  final String duration;
  final List<String> tips;
  TransportOption({
    required this.name,
    required this.icon,
    required this.description,
    required this.cost,
    required this.duration,
    this.tips = const [],
  });
}
class TransportationInfo {
  final String cityName;
  final List<TransportOption> airportTransport;
  final List<TransportOption> publicTransport;
  final String generalTransportInfo;
  TransportationInfo({
    required this.cityName,
    required this.airportTransport,
    required this.publicTransport,
    required this.generalTransportInfo,
  });
}