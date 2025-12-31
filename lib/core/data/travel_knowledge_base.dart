
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
  };

  static final List<String> _generalTips = [
    'Research local customs and etiquette',
    'Download offline maps before traveling',
    'Keep copies of important documents',
    'Learn basic phrases in local language',
    'Use local public transport to save money',
  ];
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
