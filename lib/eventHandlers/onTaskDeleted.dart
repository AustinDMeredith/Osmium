import 'package:flutter/material.dart';
import 'package:osmium_flutter/models/goal.dart';
import 'package:provider/provider.dart';
import '../../models/goalmanager.dart';
import '../../models/task.dart';
import '../../models/taskmanager.dart';
import '../../models/ProgressLogManager.dart';
import '../../models/projectManager.dart';
import '../../models/project.dart';


void onTaskDelete(Task task, BuildContext context) {
  final taskManager = Provider.of<TaskManager>(context, listen: false);
  final logs = Provider.of<ProgressLogManager>(context, listen: false);
  

  if (task.isCompleted && task.isOf == 'project') {
    // make it so if the task is completed, the progress gets removed from the parent.
    final projects = Provider.of<ProjectManager>(context, listen: false).projects;
    // finding the project associated with the task
    Project? project = projects[task.parentId];
    if(project != null) {
      project.currentProgress -= task.progressWeight;
      logs.removeLog(task.id);
      Provider.of<ProjectManager>(context, listen: false).addProject(project.mapId, project);
    }
  }
  if (task.isCompleted && task.isOf == 'goal') {
    // make it so if the task is completed, the progress gets removed from the parent.
    final goals = Provider.of<GoalManager>(context, listen: false).goals;
    // finding the project associated with the task
    Goal? goal = goals[task.parentId];
    if(goal != null) {
      goal.currentProgress -= task.progressWeight;
      logs.removeLog(task.id);
      Provider.of<GoalManager>(context, listen: false).addGoal(goal.id, goal);
    }
  }
  taskManager.removeTask(task.id);
  }