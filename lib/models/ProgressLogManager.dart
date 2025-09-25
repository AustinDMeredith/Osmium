import 'package:flutter/foundation.dart';
import '../repositories/progressLog_repository.dart';
import 'progressLog.dart';

class ProgressLogManager extends ChangeNotifier {
  final ProgressLogRepository _repository = ProgressLogRepository();
  List<ProgressLog> _logs = [];
  bool _isLoading = false;

  List<ProgressLog> get logs => _logs;
  bool get isLoading => _isLoading;

  Future<void> loadLogs() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _logs = await _repository.getAll();
    } catch (e) {
      print('Error leading progressLogs: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addLog(ProgressLog log) async {
    try {
      final id = await _repository.create(log);
      log.id = id;
      _logs.add(log);
      notifyListeners();
    } catch (e) {
      print('Error adding log $e');
    }
  }

  Future<void> updateLog(ProgressLog log) async {
    try {
      await _repository.update(log);
      final index = _logs.indexWhere((g) => g.id == log.id);
      if (index != -1) {
        _logs[index] = log;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating goal: $e');
    }
  }
}