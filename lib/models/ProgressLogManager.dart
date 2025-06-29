import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'progresslog.dart';

class ProgressLogManager extends ChangeNotifier {
// Get the box when needed, after it's open in main()
  Box<Progresslog> get _logBox => Hive.box<Progresslog>('progresslogs');

  // Add a log
  void addLog(int id, Progresslog log) {
    _logBox.put(id, log);
    notifyListeners();
  }

  // Get a log by id
  Progresslog? getLog(int id) {
    return _logBox.get(id);
  }

  // Get all logs as a map
  Map<dynamic, Progresslog> get logs => _logBox.toMap();

  // Remove a log
  void removeLog(int id) {
    _logBox.delete(id);
    notifyListeners();
  }

  // Get the next available id (simple example)
  int getNextId() {
    if (_logBox.isEmpty) return 0;
    return _logBox.keys.cast<int>().reduce((a, b) => a > b ? a : b) + 1;
  }
}