import 'dart:core';
import 'package:hive/hive.dart';
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
  String id;

  Goal({
    required this.name,
    required this.id,
    this.description = 'Add a description',
    this.targetValue = 0,
    this.currentProgress = 0,
    this.isCompleted = false,
  });
}