import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/progresslog.dart';
import '../../models/task.dart';
import '../../models/taskmanager.dart';
import '../../models/ProgressLogManager.dart';
import '../multiUse/addTask.dart';
import '../multiUse/addProgress.dart';
import '../../models/goal.dart';
import '../../models/goalmanager.dart';

class GoalElementSelect extends StatelessWidget {
  final Goal goal;
  const GoalElementSelect({
    super.key,
    required this.goal
  });

  @override
  Widget build(BuildContext context) {
    final taskManager = Provider.of<TaskManager>(context, listen: false);
    final goalManager = Provider.of<GoalManager>(context, listen: false);
    final logManager = Provider.of<ProgressLogManager>(context, listen: false);
    String goalId = goal.id;
    return PopupMenuButton<String>(
      icon: Icon(Icons.add),
      onSelected: (value) {
        // Handle selection
        if (value == 'task') {
          showTaskDialog(
            context, onSubmit: (name, deadline, weight) {
              int id = taskManager.getNextId();
              final newTask = Task(name: name, deadline: deadline, progressWeight: weight, isOf: 'goal', parentId: goalId, id: id);
              newTask.updateStatus();
              taskManager.addTask(id, newTask);
              goalManager.addGoal(goalId, goal);
            });
        } else if (value == 'progress') {
          showAddProgressDialog(
            context,
            onSubmit: (title, description, value) {
              // Handle the submitted progress value
              final newLog = Progresslog(
                name: title,
                progressMade: value,
                id: logManager.getNextId(),
                isOf: 'goal',
                parentId: goalId
              );
              
              newLog.description = description;
              final logId = logManager.getNextId();
              logManager.addLog(logId, newLog);
              goal.currentProgress += value;
              goalManager.addGoal(goalId, goal);
              
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