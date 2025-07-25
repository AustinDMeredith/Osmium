import 'dart:core';

class ProgressLog {
  String? id;
  String name;
  int progressMade;
  String description;
  String parentId;      // Can be goal, project, or task ID
  String parentType;    // 'goal', 'project', 'task'
  DateTime? createdAt;

  ProgressLog({
    this.id,
    required this.name,
    required this.progressMade,
    this.description = '',
    required this.parentId,
    required this.parentType,
    this.createdAt,
  });

  factory ProgressLog.fromMap(Map<String, dynamic> map) {
    return ProgressLog(
      id: map['id'],
      name: map['name'],
      progressMade: map['progress_made'],
      description: map['description'] ?? '',
      parentId: map['parent_id'],
      parentType: map['parent_type'],
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'progress_made': progressMade,
      'description': description,
      'parent_id': parentId,
      'parent_type': parentType,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}