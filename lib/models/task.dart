import 'package:hive/hive.dart';
import 'dart:core';
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

  @HiveField(8)
  int id;

  Task({
    required this.name,
    required this.deadline,
    this.isCompleted = false,
    this.status = 'upcoming',
    required this.progressWeight,
    this.isStarted = false,
    this.isOf = 'null',
    this.parentId = -1,
    required this.id,
  });

  Task copyWith({
    String? name,
    DateTime? deadline,
    bool? isCompleted,
    String? status,
    double? progressWeight,
    bool? isStarted,
    String? isOf,
    int? parentId,
    int? id,
    // Add other fields as needed
  }) {
    return Task(
      name: name ?? this.name,
      deadline: deadline ?? this.deadline,
      isCompleted: isCompleted ?? this.isCompleted,
      status: status ?? this.status,
      progressWeight: progressWeight ?? this.progressWeight,
      isStarted: isStarted ?? this.isStarted,
      isOf: isOf ?? this.isOf,
      parentId: parentId ?? this.parentId,
      id: id ?? this.id,
      // Add other fields as needed
    );
  }

  void updateStatus() {
    if (isCompleted == true) {
      status = 'completed';
    } else if (deadline != null) {
      final now = DateTime.now();
      if (isStarted) {
        status = 'started';
      } else if (now.isAfter(deadline!)) {
        status = 'late';
      } else if (deadline!.year == now.year &&
        deadline!.month == now.month &&
        deadline!.day == now.day) {
          status = 'today';
      } else {
        status = 'upcoming';
      }
    } else {
      status = 'upcoming';
    }
  }
}