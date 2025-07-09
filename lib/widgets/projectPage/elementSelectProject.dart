import 'package:flutter/material.dart';
import '../../models/project.dart';
import '../../eventHandlers/onGoalCreated.dart';
import '../../eventHandlers/onTaskCreated.dart';
import '../../eventHandlers/onLogCreated.dart';
import '../multiUse/addTask.dart';
import '../multiUse/addProgress.dart';
import 'addMilestone.dart';

class ProjectElementSelect extends StatelessWidget {
  final Project project;
  const ProjectElementSelect({
    super.key,
    required this.project
  });

  @override
  Widget build(BuildContext context) {
    String projectId = project.mapId;
    String isOf = 'project';
    return PopupMenuButton<String>(
      icon: Icon(Icons.add),
      onSelected: (value) {
        // Handle selection
        if (value == 'task') {
          showTaskDialog(
            context, onSubmit: (name, deadline, weight) {
              // pass entered values to event handler
              onTaskCreated(name, deadline, weight, projectId, context, isOf);
            });
        } else if (value == 'milestone') {
          showDialog(
            context: context,
            builder: (context) => AddMilestoneDialog(
              onAdd: (name, description) {
                // Handle adding milestone here
                onGoalCreated(name, description, projectId, context);
              },
            ),
          );
        } else if (value == 'progress') {
          showAddProgressDialog(
            context,
            onSubmit: (title, description, value) {
              // Handle the submitted progress value
              onLogCreated(title, value, projectId, description, context, isOf);
            },
            initialValue: 0, // optional
            maxValue: 100,   // optional
            label: "Add Progress", // optional
          );
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 'milestone', child: Text('Milestone')),
        PopupMenuItem(value: 'task', child: Text('Task')),
        PopupMenuItem(value: 'progress', child: Text('Progress Log')),
      ],
    );
  }
}