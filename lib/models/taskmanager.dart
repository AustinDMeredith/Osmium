import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'task.dart';

class TaskManager extends ChangeNotifier {
  // Get the box when needed, after it's open in main()
  Box<Task> get _taskBox => Hive.box<Task>('tasks');

  // Add a task
  void addTask(int id, Task task) {
    print('addTask called: id=$id, isCompleted=${task.isCompleted}, isStarted=${task.isStarted}, status=${task.status}');
    _taskBox.put(id, task);
    notifyListeners();
  }

  // Get a task by id
  Task? getTask(int id) {
    return _taskBox.get(id);
  }

  // Get all tasks as a map
  Map<dynamic, Task> get tasks => _taskBox.toMap();

  // Remove a task
  void removeTask(int id) {
    _taskBox.delete(id);
    notifyListeners();
  }

  // Get the next available id (simple example)
  int getNextId() {
    if (_taskBox.isEmpty) return 0;
    return _taskBox.keys.cast<int>().reduce((a, b) => a > b ? a : b) + 1;
  }

  void startTask(Task task) {
    final id = task.id;
    final updatedTask = task.copyWith(isStarted: true);
    updatedTask.updateStatus();
    _taskBox.put(id, updatedTask); // Save the updated task to Hive
    notifyListeners();
  }
}