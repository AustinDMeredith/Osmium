import 'package:flutter/foundation.dart';
import '../repositories/goal_repository.dart';
import 'goal.dart';

class GoalManager extends ChangeNotifier {
  final GoalRepository _repository = GoalRepository();
  List<Goal> _goals = []; // In-memory cache
  bool _isLoading = false; // Loading state

  // Getters expose data to UI
  List<Goal> get goals => _goals;
  bool get isLoading => _isLoading;

  // Load goals from repository
  Future<void> loadGoals() async {
    _isLoading = true;
    notifyListeners();

    try {
      _goals = await _repository.getAll();
    } catch (e) {
      print('Error loading goals: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Add new goal
  Future<void> addGoal(Goal goal) async {
    try {
      final id = await _repository.create(goal);
      goal.id = id;
      _goals.add(goal);
      notifyListeners();
    } catch (e) {
      print('Error adding goal: $e');
    }
  }

  // Update existing goal
  Future<void> updateGoal(Goal goal) async {
    try {
      await _repository.update(goal);
      final index = _goals.indexWhere((g) => g.id == goal.id);
      if (index != -1) {
        _goals[index] = goal;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating goal: $e');
    }
  }

  // Delete goal
  Future<void> deleteGoal(String id) async {
    try {
      await _repository.delete(id);
      _goals.removeWhere((goal) => goal.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting goal: $e');
    }
  }
}