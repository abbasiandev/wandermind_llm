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
        final planData = box.get(key);
        if (planData != null) {
          final plan = TravelPlan.fromJson(Map<String, dynamic>.from(planData));
          plans.add(plan);
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
        return TravelPlan.fromJson(Map<String, dynamic>.from(planData));
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
      await box.put(plan.id, plan.toJson());
      _logger.d('Saved travel plan: ${plan.title}');
    } catch (e) {
      _logger.e('Failed to save travel plan: $e');
      rethrow;
    }
  }

  Future<void> updateTravelPlan(TravelPlan plan) async {
    try {
      final updatedPlan = plan.copyWith(updatedAt: DateTime.now());
      final box = await _storageService.openBox(_boxName);
      await box.put(plan.id, updatedPlan.toJson());
      _logger.d('Updated travel plan: ${plan.title}');
    } catch (e) {
      _logger.e('Failed to update travel plan: $e');
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
}