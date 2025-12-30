// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TravelPlanImpl _$$TravelPlanImplFromJson(Map<String, dynamic> json) =>
    _$TravelPlanImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      destination: json['destination'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      days: (json['days'] as List<dynamic>)
          .map((e) => DayPlan.fromJson(e as Map<String, dynamic>))
          .toList(),
      budget: (json['budget'] as num).toDouble(),
      interests:
          (json['interests'] as List<dynamic>).map((e) => e as String).toList(),
      notes:
          (json['notes'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$TravelPlanImplToJson(_$TravelPlanImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'destination': instance.destination,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'days': instance.days,
      'budget': instance.budget,
      'interests': instance.interests,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$DayPlanImpl _$$DayPlanImplFromJson(Map<String, dynamic> json) =>
    _$DayPlanImpl(
      dayNumber: (json['dayNumber'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      activities: (json['activities'] as List<dynamic>)
          .map((e) => Activity.fromJson(e as Map<String, dynamic>))
          .toList(),
      overview: json['overview'] as String,
      estimatedCost: (json['estimatedCost'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$DayPlanImplToJson(_$DayPlanImpl instance) =>
    <String, dynamic>{
      'dayNumber': instance.dayNumber,
      'date': instance.date.toIso8601String(),
      'activities': instance.activities,
      'overview': instance.overview,
      'estimatedCost': instance.estimatedCost,
    };

_$ActivityImpl _$$ActivityImplFromJson(Map<String, dynamic> json) =>
    _$ActivityImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      timeSlot: TimeSlot.fromJson(json['timeSlot'] as Map<String, dynamic>),
      type: $enumDecode(_$ActivityTypeEnumMap, json['type']),
      cost: (json['cost'] as num?)?.toDouble() ?? 0.0,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      tips:
          (json['tips'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$$ActivityImplToJson(_$ActivityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'timeSlot': instance.timeSlot,
      'type': _$ActivityTypeEnumMap[instance.type]!,
      'cost': instance.cost,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'tips': instance.tips,
    };

const _$ActivityTypeEnumMap = {
  ActivityType.sightseeing: 'sightseeing',
  ActivityType.food: 'food',
  ActivityType.shopping: 'shopping',
  ActivityType.entertainment: 'entertainment',
  ActivityType.transportation: 'transportation',
  ActivityType.accommodation: 'accommodation',
  ActivityType.adventure: 'adventure',
  ActivityType.relaxation: 'relaxation',
  ActivityType.culture: 'culture',
  ActivityType.nightlife: 'nightlife',
};

_$TimeSlotImpl _$$TimeSlotImplFromJson(Map<String, dynamic> json) =>
    _$TimeSlotImpl(
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
    );

Map<String, dynamic> _$$TimeSlotImplToJson(_$TimeSlotImpl instance) =>
    <String, dynamic>{
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
    };

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      id: json['id'] as String,
      content: json['content'] as String,
      isUser: json['isUser'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']) ??
          MessageType.text,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'isUser': instance.isUser,
      'timestamp': instance.timestamp.toIso8601String(),
      'type': _$MessageTypeEnumMap[instance.type]!,
      'metadata': instance.metadata,
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.travelPlan: 'travelPlan',
  MessageType.suggestion: 'suggestion',
  MessageType.error: 'error',
};

_$LocationDataImpl _$$LocationDataImplFromJson(Map<String, dynamic> json) =>
    _$LocationDataImpl(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String,
      city: json['city'] as String?,
      country: json['country'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$LocationDataImplToJson(_$LocationDataImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'city': instance.city,
      'country': instance.country,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
