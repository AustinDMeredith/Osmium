import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../models/taskmanager.dart';

void onTaskCreated(String name, DateTime? deadline, double weight, String parentId, BuildContext context, String isOf) {
  final taskManager = Provider.of<TaskManager>(context, listen: false);
  int id = taskManager.getNextId();
  // construct task
  final newTask = Task(name: name, deadline: deadline, progressWeight: weight, isOf: isOf, parentId: parentId, id: id);
  // update status
  newTask.updateStatus();
  // add to provider
  taskManager.addTask(id, newTask);
}