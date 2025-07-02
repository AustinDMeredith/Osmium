import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/multiUse/displayTasks.dart';
import '../models/taskmanager.dart';

class TasksPage extends StatelessWidget {
  final int projectId; // Pass the project ID you want to filter by

  const TasksPage({
    super.key,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // row 1
        Expanded(
          child: Row(
            children: [
              // late tasks widget
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 8, bottom: 8),
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

              // todays tasks widget
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 8),
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

              // started tasks widget
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 8, right: 16, bottom: 8),
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
            ],
          ),
        ),

        // row 2
        Expanded(
          child: Row(
            children: [
              // upcoming tasks widget
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 16, right: 8, bottom: 16),
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 16, bottom: 16),
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
              ),
            ],
          ),
        )
      ],
    );
  }
}