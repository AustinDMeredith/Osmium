import 'package:flutter/material.dart';
import '../../eventHandlers/onTaskCreated.dart';
import '../../eventHandlers/onLogCreated.dart';
import '../../models/goal.dart';
import '../multiUse/addTask.dart';
import '../multiUse/addProgress.dart';

class GoalElementSelect extends StatelessWidget {
  final Goal goal;
  const GoalElementSelect({
    super.key,
    required this.goal
  });

  @override
  Widget build(BuildContext context) {
    String goalId = goal.id;
    String isOf = 'goal';
    return PopupMenuButton<String>(
      icon: Icon(Icons.add),
      onSelected: (value) {
        // Handle selection
        if (value == 'task') {
          showTaskDialog(
            context, onSubmit: (name, deadline, weight) {
              onTaskCreated(name, deadline, weight, goalId, context, isOf);
            });
        } else if (value == 'progress') {
          showAddProgressDialog(
            context,
            onSubmit: (title, description, value) {
              // Handle the submitted progress value
              onLogCreated(title, value, goalId, description, context, isOf);
            },
            initialValue: 0, // optional
            maxValue: 100,   // optional
            label: "Add Progress", // optional
          );
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 'task', child: Text('Task')),
        PopupMenuItem(value: 'progress', child: Text('Progress Log')),
      ],
    );
  }
}