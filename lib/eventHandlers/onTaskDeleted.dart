import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/goalmanager.dart';
import '../../models/goal.dart';
import '../../models/task.dart';
import '../../models/taskmanager.dart';
import '../../models/ProgressLogManager.dart';
import '../../models/projectManager.dart';
import '../../models/project.dart';

void onTaskDelete(Task task, BuildContext context) {
  final taskManager = Provider.of<TaskManager>(context, listen: false);
  final logs = Provider.of<ProgressLogManager>(context, listen: false);
  
  // check if completed and if of project or goal
  if (task.isCompleted && task.isOf == 'project') {
    final projects = Provider.of<ProjectManager>(context, listen: false).projects;
    // finding the project associated with the task
    Project? project = projects[task.parentId];
    if(project != null) {
      // removes progress from project
      project.currentProgress -= task.progressWeight;
      // deletes log
      logs.removeLog(task.id);
      // updates project
      Provider.of<ProjectManager>(context, listen: false).addProject(project.mapId, project);
    }
  }
  if (task.isCompleted && task.isOf == 'goal') {
    final goals = Provider.of<GoalManager>(context, listen: false).goals;
    // finding the project associated with the task
    Goal? goal = goals[task.parentId];
    if(goal != null) {
      // removes progress from goal
      goal.currentProgress -= task.progressWeight;
      // removes log
      logs.removeLog(task.id);
      // updates goal
      Provider.of<GoalManager>(context, listen: false).addGoal(goal.id, goal);
    }
  }
  // removes task
  taskManager.removeTask(task.id);
}