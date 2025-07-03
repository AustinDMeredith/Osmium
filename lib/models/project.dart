import 'package:hive/hive.dart';
import 'dart:core';
import '../models/goal.dart';
import '../models/task.dart';
import '../models/progresslog.dart';
part 'project.g.dart';

@HiveType(typeId: 3)
class Project {
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
  List<Goal> goals;

  @HiveField(7)
  List<Progresslog> logs;

  @HiveField(8)
  List<Task> tasks;

  @HiveField(9)
  String mapId;

  Project({
    required this.name,
    required this.mapId,
    this.description = 'Add a description',
    this.targetValue = 0,
    this.currentProgress = 0,
    this.isCompleted = false,
    List<Progresslog>? logs,
    List<Task>? tasks,
    List<Goal>? goals
  }) : logs = logs ?? [], tasks = tasks ?? [], goals = goals ?? [];
}