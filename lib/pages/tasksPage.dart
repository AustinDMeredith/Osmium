import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/taskmanager.dart';
import '../widgets/multiUse/displayTasks.dart';

class TasksPage extends StatelessWidget {
  final int projectId; // Pass the project ID you want to filter by

  const TasksPage({
    super.key,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // todays tasks widget
          SizedBox(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 8, bottom: 16),
              child: Consumer<TaskManager>(
                builder: (context, taskManager, child) {
                  // Filter tasks by project and status
                  final filteredTasks = taskManager.tasks.values.where(
                    (task) => task.parentId == projectId && task.status == 'today',
                  ).toList();
                  return DisplayTasks(tasks: filteredTasks, title: 'Today',);
                },
              ),
            ),
          ),
      
          // late tasks widget
          SizedBox(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 16),
              child: Consumer<TaskManager>(
                builder: (context, taskManager, child) {
                  // Filter tasks by project and status
                  final filteredTasks = taskManager.tasks.values.where(
                    (task) => task.parentId == projectId && task.status == 'late',
                  ).toList();
                  return DisplayTasks(tasks: filteredTasks, title: 'Late',);
                },
              ),
            ),
          ),
                    
          // started tasks widget
          SizedBox(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 16),
              child: Consumer<TaskManager>(
                builder: (context, taskManager, child) {
                  // Filter tasks by project and status
                  final filteredTasks = taskManager.tasks.values.where(
                    (task) => task.parentId == projectId && task.status == 'started',
                  ).toList();
                  return DisplayTasks(tasks: filteredTasks, title: 'Started',);
                },
              ),
            ),
          ),
      
          // upcoming tasks widget
          SizedBox(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 16),
              child: Consumer<TaskManager>(
                builder: (context, taskManager, child) {
                  // Filter tasks by project and status
                  final filteredTasks = taskManager.tasks.values.where(
                    (task) => task.parentId == projectId && task.status == 'upcoming',
                  ).toList();
                  return DisplayTasks(tasks: filteredTasks, title: 'Upcoming',);
                },
              ),
            ),
          ),
                  
          // completed tasks widget
          SizedBox(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 8, right: 16, bottom: 16),
              child: Consumer<TaskManager>(
                builder: (context, taskManager, child) {
                  // Filter tasks by project and status
                  final filteredTasks = taskManager.tasks.values.where(
                    (task) => task.parentId == projectId && task.status == 'completed',
                  ).toList();                 
                  return DisplayTasks(tasks: filteredTasks, title: 'Completed',);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}