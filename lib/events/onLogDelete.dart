import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ProgressLogManager.dart';
import '../models/progresslog.dart';
import '../models/goalmanager.dart';
import '../models/goal.dart';
import '../models/projectManager.dart';
import '../models/project.dart';

void onLogDelete (Progresslog log, BuildContext context) {
  final projects = Provider.of<ProjectManager>(context, listen: false).projects;
  final goals = Provider.of<GoalManager>(context, listen: false).goals;
  // check if log is of goal or project
  if (log.isOf == 'project') {
    // find project
    Project? project = projects[log.parentId];

    if (project != null) {
      // remove progress and update project
      project.currentProgress -= log.progressMade;
      Provider.of<ProjectManager>(context, listen: false).addProject(project.mapId, project);
    }
  } else if (log.isOf == 'goal') {
    // find goal
    Goal? goal = goals[log.parentId];

    if (goal != null) {
      // remove progress and update goal
      goal.currentProgress -= log.progressMade;
      Provider.of<GoalManager>(context, listen: false).addGoal(goal.id, goal);
    }
  }
  // remove log from manager
  Provider.of<ProgressLogManager>(context, listen: false).removeLog(log.id);
}