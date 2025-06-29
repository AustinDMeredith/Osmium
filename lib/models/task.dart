import 'dart:core';
import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  String name;

  @HiveField(1)
  DateTime? deadline;

  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  String status = 'upcoming';

  @HiveField(4)
  double progressWeight;

  @HiveField(5)
  bool isStarted;

  @HiveField(6)
  String isOf;

  @HiveField(7)
  int parentId;

  Task({
    required this.name,
    required this.deadline,
    required this.progressWeight,
    this.isStarted = false,
    this.isOf = 'null',
    this.parentId = -1,
    this.isCompleted = false,
    this.status = 'upcoming',
  });

  Task copyWith({
    String? name,
    DateTime? deadline,
    bool? isCompleted,
    bool? isStarted,
    String? status,
    double? progressWeight,
    String? isOf,
    // Add other fields as needed
  }) {
    return Task(
      name: name ?? this.name,
      deadline: deadline ?? this.deadline,
      isCompleted: isCompleted ?? this.isCompleted,
      isStarted: isStarted ?? this.isStarted,
      status: status ?? this.status,
      progressWeight: progressWeight ?? this.progressWeight,

      // Add other fields as needed
    );
  }

  void updateStatus() {
    if (isCompleted) {
      status = 'completed';
    } else if (deadline != null) {
      final now = DateTime.now();
      if (deadline!.difference(now).inDays == -1) {
        status = 'late';
      } else if (deadline!.difference(now).inDays == 0) {
        status = 'today';
      } else if (isStarted) {
        status = 'started';
      } else {
        status = 'upcoming';
      }
    } else {
      status = 'upcoming';
    }
  }
}