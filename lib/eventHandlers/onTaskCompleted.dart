import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/projectManager.dart';
import '../models/project.dart';
import '../models/goal.dart';
import '../models/goalmanager.dart';
import '../models/taskmanager.dart';
import '../models/progresslog.dart';
import '../models/ProgressLogManager.dart';

void onTaskCompleted(task, BuildContext context) {
  final taskManager = Provider.of<TaskManager>(context, listen: false);
  final logs = Provider.of<ProgressLogManager>(context, listen: false);
  final taskId = task.id;
  // updates task as completed in manager
  task.isCompleted = true;
  task.updateStatus();
  taskManager.addTask(taskId, task.copyWith());
  
  // updates goals and projects if needed
  if (task.isOf == 'project') {
    final projects = Provider.of<ProjectManager>(context, listen: false).projects;
    // finding the project associated with the task
    Project? project = projects[task.parentId];
    if (project != null) {
      // updates overall project progress
      project.currentProgress += task.progressWeight;
      // creates a progresslog for task in project
      String name = task.name;
      int id = logs.getNextId();
      Progresslog newLog = Progresslog(name: 'Task - $name', progressMade: task.progressWeight, id: taskId, isOf: 'project', parentId: task.parentId);
      // Save the updated project back to the manager/box if needed
      Provider.of<ProjectManager>(context, listen: false).addProject(task.parentId, project);
      logs.addLog(id, newLog);
    }
  } else if (task.isOf == 'goal') {
    final goals = Provider.of<GoalManager>(context, listen: false).goals;
    // finding the goal associated with the task
    Goal? goal = goals[task.parentId];
    if(goal != null) {
      // updates overall goal progress
      goal.currentProgress += task.progressWeight;
      // creates a progresslog for task in goal
      String name = task.name;
      int id = logs.getNextId();
      Progresslog newLog = Progresslog(name: 'Task - $name', progressMade: task.progressWeight, id: taskId, isOf: 'goal', parentId: task.parentId);
      // Save the updated goal back to the manager/box if needed
      Provider.of<GoalManager>(context, listen: false).addGoal(task.parentId, goal);
      logs.addLog(id, newLog);
    }
  }
}