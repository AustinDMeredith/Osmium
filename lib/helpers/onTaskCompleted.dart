import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/projectManager.dart';
import '../models/project.dart';
import '../models/goal.dart';
import '../models/goalmanager.dart';
import '../models/taskmanager.dart';
import '../models/progresslog.dart';

void onTaskCompleted(TaskManager taskManager, task, bool? checked, BuildContext context) {
  final taskId = taskManager.tasks.entries
      .firstWhere((entry) => entry.value == task)
      .key;
  // updates task as completed in manager
  taskManager.addTask(taskId, task.copyWith(isCompleted: checked ?? true));
  task.updateStatus();
  
  // updates goals and projects if needed
  if (task.isOf == 'project') {
    final projects = Provider.of<ProjectManager>(context, listen: false).projects;
    // finding the project associated with the task
    Project? project = projects[task.parentId];
    if (project != null) {
      // finding the index of the task in the list of tasks held in the project
      final idx = project.tasks.indexWhere((t) => t.name == task.name);
      if (idx != -1) {
        // updates task as completed in project
        project.tasks[idx] = task.copyWith(isCompleted: checked ?? true);
        // updates overall project progress
        project.currentProgress += task.progressWeight;
        // creates a progresslog for task in project
        String name = task.name;
        project.logs.add(Progresslog(name: 'Task - $name', progressMade: task.progressWeight));
        // Save the updated project back to the manager/box if needed
        Provider.of<ProjectManager>(context, listen: false).addProject(task.parentId, project);
      }
    }
  } else if (task.isOf == 'goal') {
    final goals = Provider.of<GoalManager>(context, listen: false).goals;
    // finding the goal associated with the task
    Goal? goal = goals[task.parentId];
    if(goal != null) {
      final idx = goal.tasks.indexWhere((t) => t.name == task.name);
      if (idx != -1) {
        // updates task as completed in goal
        goal.tasks[idx] = task.copyWith(isCompleted: checked ?? true);
        // updates overall goal progress
        goal.currentProgress += task.progressWeight;
        // creates a progresslog for task in goal
        String name = task.name;
        goal.progressLogs.add(Progresslog(name: 'Task - $name', progressMade: task.progressWeight));
        
        // Save the updated goal back to the manager/box if needed
        Provider.of<GoalManager>(context, listen: false).addGoal(task.parentId, goal);
      }
    }
  }
}