import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/project.dart';
import '../models/projectManager.dart';
import '../models/ProgressLogManager.dart';
import '../models/taskmanager.dart';


void onProjectDelete (Project project, BuildContext context) {
  final tasks = Provider.of<TaskManager>(context, listen: false).tasks;
  final logs = Provider.of<ProgressLogManager>(context, listen: false).logs;
  String parentId = project.mapId;
  // go through tasks and remove tasks associated with the project 
  for (var task in tasks.values) {
    if (task.parentId == parentId) {
      Provider.of<TaskManager>(context, listen: false).removeTask(task.id);
    }
  }
  // go through logs and remove logs associated with the project 
  for (var log in logs.values) {
    if (log.parentId == parentId) {
      Provider.of<ProgressLogManager>(context, listen: false).removeLog(log.id);
    }
  }
  // remove project
  Provider.of<ProjectManager>(context, listen: false).removeProject(project.mapId);
}