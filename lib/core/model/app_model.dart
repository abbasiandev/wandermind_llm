import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'app_model.freezed.dart';
part 'app_model.g.dart';
@freezed
class TravelPlan with _$TravelPlan {
  const factory TravelPlan({
    required String id,
    required String title,
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required List<DayPlan> days,
    required double budget,
    required List<String> interests,
    @Default([]) List<String> notes,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _TravelPlan;
  factory TravelPlan.fromJson(Map<String, dynamic> json) =>
      _$TravelPlanFromJson(json);
}
@freezed
class DayPlan with _$DayPlan {
  const factory DayPlan({
    required int dayNumber,
    required DateTime date,
    required List<Activity> activities,
    required String overview,
    @Default(0.0) double estimatedCost,
  }) = _DayPlan;
  factory DayPlan.fromJson(Map<String, dynamic> json) =>
      _$DayPlanFromJson(json);
}
@freezed
class Activity with _$Activity {
  const factory Activity({
    required String id,
    required String title,
    required String description,
    required String location,
    required TimeSlot timeSlot,
    required ActivityType type,
    @Default(0.0) double cost,
    @Default(0.0) double latitude,
    @Default(0.0) double longitude,
    @Default([]) List<String> tips,
  }) = _Activity;
  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
}
@freezed
class TimeSlot with _$TimeSlot {
  const factory TimeSlot({
    required DateTime startTime,
    required DateTime endTime,
  }) = _TimeSlot;
  factory TimeSlot.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotFromJson(json);
}
enum ActivityType {
  sightseeing,
  food,
  shopping,
  entertainment,
  transportation,
  accommodation,
  adventure,
  relaxation,
  culture,
  nightlife,
}
@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required String content,
    required bool isUser,
    required DateTime timestamp,
    @Default(MessageType.text) MessageType type,
    Map<String, dynamic>? metadata,
  }) = _ChatMessage;
  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}
enum MessageType {
  text,
  travelPlan,
  suggestion,
  error,
}
@freezed
class LocationData with _$LocationData {
  const factory LocationData({
    required double latitude,
    required double longitude,
    required String address,
    String? city,
    String? country,
    DateTime? timestamp,
  }) = _LocationData;
  factory LocationData.fromJson(Map<String, dynamic> json) =>
      _$LocationDataFromJson(json);
}
@freezed
class LLMState with _$LLMState {
  const factory LLMState({
    @Default(false) bool isInitialized,
    @Default(false) bool isLoading,
    @Default(false) bool isGenerating,
    String? error,
    String? modelPath,
    @Default(0.0) double initializationProgress,
  }) = _LLMState;
}
@freezed
class AppError with _$AppError {
  const factory AppError({
    required String message,
    String? code,
    dynamic data,
  }) = _AppError;
}