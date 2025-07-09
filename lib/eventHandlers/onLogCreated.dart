import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/goalmanager.dart';
import '../models/goal.dart';
import '../models/projectManager.dart';
import '../models/project.dart';
import '../models/ProgressLogManager.dart';
import '../models/progresslog.dart';

void onLogCreated(String title, double value, String parentId, String description, BuildContext context, String isOf) {
  // get provider and id
  final logManager = Provider.of<ProgressLogManager>(context, listen: false);
  int id = logManager.getNextId();

  // construct log
  final newLog = Progresslog(
    name: title,
    progressMade: value,
    id: id,
    isOf: isOf,
    parentId: parentId,
    description: description
  );
  
  // add log to manager
  logManager.addLog(id, newLog);

  // update goal or project
  if(isOf == 'project') {
    // find project
    final projects = Provider.of<ProjectManager>(context, listen: false).projects;
    Project? project = projects[parentId];
    if(project != null) {
      // add progress
      project.currentProgress += newLog.progressMade;
      // update project
      Provider.of<ProjectManager>(context, listen: false).addProject(parentId, project);
    }
  } else if(isOf == 'goal') {
    // find goal
    final goals = Provider.of<GoalManager>(context, listen: false).goals;
    Goal? goal = goals[parentId];
    if(goal != null) {
      // add progress
      goal.currentProgress += newLog.progressMade;
      // update goal
      Provider.of<GoalManager>(context, listen: false).addGoal(parentId, goal);
    }
  }
}