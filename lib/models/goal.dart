import 'dart:core';
import 'package:hive/hive.dart';
import '../models/task.dart';
import '../models/progresslog.dart';
part 'goal.g.dart';

@HiveType(typeId: 0)
class Goal {
  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  @HiveField(2)
  double targetValue;

  @HiveField(3)
  double currentProgress;

  @HiveField(4)
  DateTime? deadline;

  @HiveField(5)
  bool isCompleted;
  
  @HiveField(6)
  List<Progresslog> progressLogs;

  @HiveField(7)
  List<Task> tasks;

  Goal({
    required this.name,
    this.description = 'Add a description',
    this.targetValue = 0,
    this.currentProgress = 0,
    this.isCompleted = false,
    List<Progresslog>? progressLogs,
    List<Task>? tasks
  }) : progressLogs = progressLogs ?? [], tasks = tasks ?? [];
}