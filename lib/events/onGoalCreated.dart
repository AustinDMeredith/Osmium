import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/goalmanager.dart';
import '../models/goal.dart';

void onGoalCreated(String name, String description, String parentId, BuildContext context) {
  final goalManager = Provider.of<GoalManager>(context, listen: false);
  final newGoal = Goal(name: name, description: description, parentId: parentId);
  goalManager.addGoal(newGoal);
}