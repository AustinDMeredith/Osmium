import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ProgressLogManager.dart';
import '../models/goalmanager.dart';
import '../models/taskmanager.dart';
import '../models/goal.dart';

void onGoalDelete (Goal goal, BuildContext context) {
  final tasks = Provider.of<TaskManager>(context, listen: false).tasks;
  final logs = Provider.of<ProgressLogManager>(context, listen: false).logs;
  String parentId = goal.id;
  // go through tasks and remove tasks associated with the goal 
  for (var task in tasks.values) {
    if (task.parentId == parentId) {
      Provider.of<TaskManager>(context, listen: false).removeTask(task.id);
    }
  }
  // go through logs and remove logs associated with the goal 
  for (var log in logs.values) {
    if (log.parentId == parentId) {
      Provider.of<ProgressLogManager>(context, listen: false).removeLog(log.id);
    }
  }
  // remove goal
  Provider.of<GoalManager>(context, listen: false).removeGoal(goal.id);
}