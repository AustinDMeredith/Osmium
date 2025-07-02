import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/progresslog.dart';
import '../../models/project.dart';
import '../../models/projectManager.dart';
import '../../models/task.dart';
import '../../models/taskmanager.dart';
import '../../models/ProgressLogManager.dart';
import '../multiUse/addTask.dart';
import '../multiUse/addProgress.dart';

class ProjectElementSelect extends StatelessWidget {
  final Project project;
  const ProjectElementSelect({
    super.key,
    required this.project
  });

  @override
  Widget build(BuildContext context) {
    final taskManager = Provider.of<TaskManager>(context, listen: false);
    final projectManager = Provider.of<ProjectManager>(context, listen: false);
    final logManager = Provider.of<ProgressLogManager>(context, listen: false);
    int projectId = project.mapId;
    return PopupMenuButton<String>(
      icon: Icon(Icons.add),
      onSelected: (value) {
        // Handle selection
        if (value == 'task') {
          showTaskDialog(
            context, onSubmit: (name, deadline, weight) {
              int id = taskManager.getNextId();
              final newTask = Task(name: name, deadline: deadline, progressWeight: weight, isOf: 'project', parentId: projectId, id: id);
              newTask.updateStatus();
              taskManager.addTask(id, newTask);
              project.tasks.add(newTask);
              projectManager.addProject(projectId, project);
              
            });
        } else if (value == 'milestone') {
          // Add milestone logic
        } else if (value == 'progress') {
          showAddProgressDialog(
            context,
            onSubmit: (title, description, value) {
              // Handle the submitted progress value
              final newLog = Progresslog(
                name: title,
                progressMade: value,
              );
              
              newLog.description = description;
              final logId = logManager.getNextId();
              logManager.addLog(logId, newLog);

              // Retrieve the saved log from Hive
              final savedLog = logManager.getLog(logId);
              if (savedLog != null) {
                project.logs.add(savedLog);
                project.currentProgress += value;
                projectManager.addProject(projectId, project);
              }
            },
            initialValue: 0, // optional
            maxValue: 100,   // optional
            label: "Add Progress", // optional
          );
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 'milestone', child: Text('Milestone')),
        PopupMenuItem(value: 'task', child: Text('Task')),
        PopupMenuItem(value: 'progress', child: Text('Progress Log')),
      ],
    );
  }
}