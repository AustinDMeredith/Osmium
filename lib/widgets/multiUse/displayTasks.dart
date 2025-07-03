import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../models/task.dart';
import '../../models/taskmanager.dart';
import '../../helpers/onTaskCompleted.dart';

class DisplayTasks extends StatelessWidget {
  final List<Task> tasks;
  final String title;
  const DisplayTasks({
    super.key,
    required this.tasks,
    required this.title
    });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(25)
        ),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16),
              child: Text(title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'No tasks',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      );
    }

    tasks.sort((a, b) {
      final aTime = a.deadline != null ? a.deadline!.hour * 60 + a.deadline!.minute : 0;
      final bTime = b.deadline != null ? b.deadline!.hour * 60 + b.deadline!.minute : 0;
      return aTime.compareTo(bTime);
    });

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(25)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 16),
            child: Text(title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                String name = task.name;
                final timeString = task.deadline != null
                  ? DateFormat('h:mm a').format(task.deadline!)
                  : 'No deadline';
                return ListTile(
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (checked) {
                      onTaskCompleted(task, checked, context);
                    },
                  ),
                  title: Text('$timeString - $name'),
                  trailing: TextButton(
                    onPressed: task.isStarted
                    ? null
                    : () {
                        Provider.of<TaskManager>(context, listen: false).startTask(task);
                      },
                    child: Text(task.isStarted ? 'Started' : 'Start'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}