import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'goal.dart';

class GoalManager extends ChangeNotifier {
  // Get the box when needed, after it's open in main()
  Box<Goal> get _goalBox => Hive.box<Goal>('goals');

  // Add a goal
  void addGoal(String id, Goal goal) {
    _goalBox.put(id, goal);
    notifyListeners();
  }

  // Get a goal by id
  Goal? getGoal(String id) {
    return _goalBox.get(id);
  }

  // Get all goals as a map
  Map<dynamic, Goal> get goals => _goalBox.toMap();

  // Remove a goal
  void removeGoal(String id) {
    _goalBox.delete(id);
    notifyListeners();
  }

  final Uuid uuid = Uuid();
  // Get the next available id (simple example)
  String getNextId() {
    String id = uuid.v4();
    return id;
  }
}