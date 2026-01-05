import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/model/app_model.dart';
import '../../../core/provider/app_provider.dart';
import '../service/travel_plan_service.dart';
part 'travel_plan_provider.g.dart';
part 'travel_plan_provider.freezed.dart';
final travelPlanServiceProvider = Provider<TravelPlanService>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return TravelPlanService(storageService);
});
@riverpod
class TravelPlansController extends _$TravelPlansController {
  @override
  Future<List<TravelPlan>> build() async {
    final service = ref.read(travelPlanServiceProvider);
    return await service.getAllTravelPlans();
  }
  Future<void> addTravelPlan(TravelPlan plan) async {
    final service = ref.read(travelPlanServiceProvider);
    await service.saveTravelPlan(plan);
    ref.invalidateSelf();
  }
  Future<void> updateTravelPlan(TravelPlan plan) async {
    final service = ref.read(travelPlanServiceProvider);
    await service.updateTravelPlan(plan);
    ref.invalidateSelf();
  }
  Future<void> deleteTravelPlan(String planId) async {
    final service = ref.read(travelPlanServiceProvider);
    await service.deleteTravelPlan(planId);
    ref.invalidateSelf();
  }
}
@riverpod
class CurrentTravelPlanController extends _$CurrentTravelPlanController {
  @override
  TravelPlan? build() {
    return null;
  }
  void setCurrentPlan(TravelPlan plan) {
    state = plan;
  }
  void clearCurrentPlan() {
    state = null;
  }
  void updateCurrentPlan(TravelPlan updatedPlan) {
    state = updatedPlan;
    ref.read(travelPlansControllerProvider.notifier).updateTravelPlan(updatedPlan);
  }
  void addNote(String note) {
    if (state != null) {
      final updatedPlan = state!.copyWith(
        notes: [...state!.notes, note],
        updatedAt: DateTime.now(),
      );
      updateCurrentPlan(updatedPlan);
    }
  }
  void updateActivity(String dayId, Activity updatedActivity) {
    if (state != null) {
      final updatedDays = state!.days.map((day) {
        if (day.dayNumber.toString() == dayId) {
          final updatedActivities = day.activities.map((activity) {
            return activity.id == updatedActivity.id ? updatedActivity : activity;
          }).toList();
          return day.copyWith(activities: updatedActivities);
        }
        return day;
      }).toList();
      final updatedPlan = state!.copyWith(
        days: updatedDays,
        updatedAt: DateTime.now(),
      );
      updateCurrentPlan(updatedPlan);
    }
  }
}
@riverpod
class TravelPlanCreationController extends _$TravelPlanCreationController {
  @override
  TravelPlanCreationState build() {
    return const TravelPlanCreationState();
  }
  void updateDestination(String destination) {
    state = state.copyWith(destination: destination);
  }
  void updateDates(DateTime? startDate, DateTime? endDate) {
    state = state.copyWith(startDate: startDate, endDate: endDate);
  }
  void updateBudget(double budget) {
    state = state.copyWith(budget: budget);
  }
  void updateInterests(List<String> interests) {
    state = state.copyWith(interests: interests);
  }
  void updateAdditionalRequirements(String requirements) {
    state = state.copyWith(additionalRequirements: requirements);
  }
  void reset() {
    state = const TravelPlanCreationState();
  }
  bool get isValid {
    return state.destination.isNotEmpty &&
        state.startDate != null &&
        state.endDate != null &&
        state.budget > 0 &&
        state.interests.isNotEmpty;
  }
}
@freezed
class TravelPlanCreationState with _$TravelPlanCreationState {
  const factory TravelPlanCreationState({
    @Default('') String destination,
    DateTime? startDate,
    DateTime? endDate,
    @Default(0.0) double budget,
    @Default([]) List<String> interests,
    @Default('') String additionalRequirements,
    @Default(false) bool isCreating,
    String? error,
  }) = _TravelPlanCreationState;
}