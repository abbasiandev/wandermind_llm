import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import '../../../core/model/app_model.dart';
import '../../../core/service/storage_service.dart';
class TravelPlanService {
  static final Logger _logger = Logger();
  final StorageService _storageService;
  static const String _boxName = 'travel_plans';
  TravelPlanService(this._storageService);
  Future<List<TravelPlan>> getAllTravelPlans() async {
    try {
      final box = await _storageService.openBox(_boxName);
      final plans = <TravelPlan>[];
      for (final key in box.keys) {
        try {
          final planData = box.get(key);
          if (planData != null) {
            final Map<String, dynamic> jsonMap;
            if (planData is String) {
              jsonMap = json.decode(planData);
            } else if (planData is Map) {
              jsonMap = Map<String, dynamic>.from(planData);
            } else {
              _logger.w('Unexpected data type for key $key: ${planData.runtimeType}');
              continue;
            }
            final plan = TravelPlan.fromJson(jsonMap);
            plans.add(plan);
          }
        } catch (e) {
          _logger.e('Failed to parse travel plan for key $key: $e');
          continue;
        }
      }
      plans.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _logger.d('Retrieved ${plans.length} travel plans');
      return plans;
    } catch (e) {
      _logger.e('Failed to get travel plans: $e');
      return [];
    }
  }
  Future<TravelPlan?> getTravelPlan(String planId) async {
    try {
      final box = await _storageService.openBox(_boxName);
      final planData = box.get(planId);
      if (planData != null) {
        final Map<String, dynamic> jsonMap;
        if (planData is String) {
          jsonMap = json.decode(planData);
        } else if (planData is Map) {
          jsonMap = Map<String, dynamic>.from(planData);
        } else {
          _logger.w('Unexpected data type for planId $planId: ${planData.runtimeType}');
          return null;
        }
        return TravelPlan.fromJson(jsonMap);
      }
      return null;
    } catch (e) {
      _logger.e('Failed to get travel plan $planId: $e');
      return null;
    }
  }
  Future<void> saveTravelPlan(TravelPlan plan) async {
    try {
      final box = await _storageService.openBox(_boxName);
      final jsonMap = plan.toJson();
      final jsonString = json.encode(jsonMap);
      await box.put(plan.id, jsonString);
      _logger.d('Saved travel plan: ${plan.title}');
    } catch (e, stackTrace) {
      _logger.e('Failed to save travel plan: $e', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
  Future<void> updateTravelPlan(TravelPlan plan) async {
    try {
      final updatedPlan = plan.copyWith(updatedAt: DateTime.now());
      final box = await _storageService.openBox(_boxName);
      final jsonMap = updatedPlan.toJson();
      final jsonString = json.encode(jsonMap);
      await box.put(plan.id, jsonString);
      _logger.d('Updated travel plan: ${plan.title}');
    } catch (e, stackTrace) {
      _logger.e('Failed to update travel plan: $e', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
  Future<void> deleteTravelPlan(String planId) async {
    try {
      final box = await _storageService.openBox(_boxName);
      await box.delete(planId);
      _logger.d('Deleted travel plan: $planId');
    } catch (e) {
      _logger.e('Failed to delete travel plan: $e');
      rethrow;
    }
  }
  Future<List<TravelPlan>> searchTravelPlans(String query) async {
    try {
      final allPlans = await getAllTravelPlans();
      final searchQuery = query.toLowerCase();
      return allPlans.where((plan) {
        return plan.title.toLowerCase().contains(searchQuery) ||
            plan.destination.toLowerCase().contains(searchQuery) ||
            plan.interests.any((interest) =>
                interest.toLowerCase().contains(searchQuery));
      }).toList();
    } catch (e) {
      _logger.e('Failed to search travel plans: $e');
      return [];
    }
  }
  Future<void> exportTravelPlan(TravelPlan plan) async {
    _logger.i('Exporting travel plan: ${plan.title}');
  }
  Future<void> clearAllPlans() async {
    try {
      final box = await _storageService.openBox(_boxName);
      await box.clear();
      _logger.d('Cleared all travel plans');
    } catch (e) {
      _logger.e('Failed to clear travel plans: $e');
      rethrow;
    }
  }
}