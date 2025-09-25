import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../models/taskmanager.dart';
import '../../events/onTaskCompleted.dart';

class todaysTasks extends StatelessWidget {
  const todaysTasks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 16, bottom: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(25)
          ),
    
          child: Consumer<TaskManager>(
            builder: (context, taskManager, child) {
              final today = DateTime.now();
              final todaysTasks = taskManager.tasks.values.where((task) {
                if (task.deadline == null) return false;
                return task.deadline!.year == today.year &&
                       task.deadline!.month == today.month &&
                       task.deadline!.day == today.day;
              }).toList();
    
              // Sort tasks by time of day (hour and minute)
              todaysTasks.sort((a, b) {
                final aTime = a.deadline != null ? a.deadline!.hour * 60 + a.deadline!.minute : 0;
                final bTime = b.deadline != null ? b.deadline!.hour * 60 + b.deadline!.minute : 0;
                return aTime.compareTo(bTime);
              });
    
              if (todaysTasks.isEmpty) {
                return Center(child: Text('No tasks for today.'));
              }
    
              // Group tasks by time subdivision
              Map<String, List<dynamic>> groupedTasks = {
                'Morning': [],
                'Afternoon': [],
                'Evening': [],
                'Night': [],
              };
    
              for (var task in todaysTasks) {
                if (task.deadline == null) continue;
                final hour = task.deadline!.hour;
                if (hour >= 5 && hour < 12) {
                  groupedTasks['Morning']!.add(task);
                } else if (hour >= 12 && hour < 17) {
                  groupedTasks['Afternoon']!.add(task);
                } else if (hour >= 17 && hour < 21) {
                  groupedTasks['Evening']!.add(task);
                } else {
                  groupedTasks['Night']!.add(task);
                }
              }
    
              // Build the list with subdivisions
              List<Widget> children = [];
              groupedTasks.forEach((period, tasks) {
                if (tasks.isNotEmpty) {
                  children.add(
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                      child: Text(
                        period,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  );
                  for (var task in tasks) {
                    final now = DateTime.now();
                    final isOverdue = task.deadline != null && now.isAfter(task.deadline!);
                    final timeString = DateFormat('h:mm a').format(task.deadline);
                    String name = task.name;
                    children.add(
                      ListTile(
                        leading: Checkbox(
                          value: task.isCompleted,
                          onChanged: (checked) {
                            onTaskCompleted(task,context);
                          },
                        ),
                        title: Text(
                          '$timeString - $name',
                          style: TextStyle(
                            color: isOverdue ? Colors.red : null,
                          ),
                        ),
                        trailing: TextButton(
                          onPressed: task.isStarted
                              ? null
                              : () {
                                  taskManager.startTask(task);
                                },
                          child: Text(task.isStarted ? 'Started' : 'Start'),
                        ),
                      ),
                    );
                  }
                }
              });
    
              return ListView(
                children: children,
              );
            },
          ),
        ),
      ),
    );
  }
}