import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/goalmanager.dart';
import '../models/goal.dart';

void onGoalCreated(String name, String description, String parentId, BuildContext context) {
  final goalManager = Provider.of<GoalManager>(context, listen: false);
  String id = goalManager.getNextId();
  final newGoal = Goal(name: name, id: id, description: description, parentId: parentId);
  goalManager.addGoal(id, newGoal);
}