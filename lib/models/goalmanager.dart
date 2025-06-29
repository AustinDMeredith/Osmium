import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'goal.dart';

class GoalManager extends ChangeNotifier {
  // Get the box when needed, after it's open in main()
  Box<Goal> get _goalBox => Hive.box<Goal>('goals');

  // Add a goal
  void addGoal(int id, Goal goal) {
    _goalBox.put(id, goal);
    notifyListeners();
  }

  // Get a goal by id
  Goal? getGoal(int id) {
    return _goalBox.get(id);
  }

  // Get all goals as a map
  Map<dynamic, Goal> get goals => _goalBox.toMap();

  // Remove a goal
  void removeGoal(int id) {
    _goalBox.delete(id);
    notifyListeners();
  }

  // Get the next available id (simple example)
  int getNextId() {
    if (_goalBox.isEmpty) return 0;
    return _goalBox.keys.cast<int>().reduce((a, b) => a > b ? a : b) + 1;
  }
}