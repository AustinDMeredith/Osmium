import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/project.dart';
import '../models/taskmanager.dart';
import '../widgets/multiUse/progressBar.dart';
import '../widgets/multiUse/tasksOverview.dart';
import '../widgets/multiUse/activityGraph.dart';
import '../widgets/projectPage/milestonesOverview.dart';

class ProjectSummaryPage extends StatelessWidget {
  final Project project;

  const ProjectSummaryPage({
    super.key,
    required this.project
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      // Progress bar Widget
                      Expanded(flex: 1, 
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8, bottom: 8, left: 16, top: 16),
                          child: ProgressBar(progress: project.currentProgress),
                        )
                      ),
                  
                      // Task Overview Widget
                      Expanded(flex: 3, 
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, right: 8, bottom: 8, left: 16),
                          child: Consumer<TaskManager>(
                            builder: (context, taskManager, child) {
                              // Filter tasks by project
                              final filteredTasks = taskManager.tasks.values.where(
                              (task) => task.parentId == project.mapId,
                              ).toList();
                
                              return TasksOverview(tasks: filteredTasks);
                            }
                          )
                        )
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, right: 16, left: 8, bottom: 8),
                          child: ActivityGraph(logs: project.logs),
                        ),
                      )
                    ],
                  )
                ),
              ],
            ),
          ),

          // Milestones Overview Widget
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 16),
              child: MilestonesOverview(milestones: project.goals),
            ),
          )
        ],
      ),
    );
  }
}