import 'dart:core';

class Goal {
  String? id;
  String name;
  String description;
  double targetValue;
  double currentProgress;
  bool isCompleted;
  String parentId;
  DateTime? deadline;
  DateTime? createdAt;

  Goal({
    this.id,
    required this.name,
    this.description = 'Add a description',
    this.targetValue = 0,
    this.currentProgress = 0,
    this.isCompleted = false,
    this.parentId = 'null',
    this.deadline,
    this.createdAt
  });

  // Convert from database row
  factory Goal.fromMap(Map<String, dynamic> map) {
    return Goal(
      id: map['id'],
      name: map['name'],
      description: map['description'] ?? 'Add a description',
      targetValue: (map['target_value'] ?? 0).toDouble(),
      currentProgress: (map['current_progress'] ?? 0).toDouble(),
      isCompleted: map['is_completed'] ?? false,
      parentId: map['parent_id'] ?? 'null',
      deadline: map['deadline'] != null ? DateTime.parse(map['deadline']) : null,
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
    );
  }

  // Convert to database format
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'target_value': targetValue,
      'current_progress': currentProgress,
      'is_completed': isCompleted,
      'parent_id': parentId,
      'deadline': deadline?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
    };
  }
}