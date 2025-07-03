import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/goal.dart';
import '../models/taskmanager.dart';
import '../widgets/multiUse/progressBar.dart';
import '../widgets/multiUse/tasksOverview.dart';
import '../widgets/multiUse/activityGraph.dart';

class GoalSummaryPage extends StatelessWidget {
  final Goal goal;
  const GoalSummaryPage({
    super.key,
    required this.goal
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      // progress bar widget
                      Expanded(flex: 1, 
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8, bottom: 8, left: 16, top: 16),
                          child: ProgressBar(progress: goal.currentProgress),
                        )
                      ),

                      // tasks overview widget
                      Expanded(flex: 3, 
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, right: 8, bottom: 8, left: 16),
                          child: Consumer<TaskManager>(
                            builder: (context, taskManager, child) {
                              // Filter tasks by project
                              final filteredTasks = taskManager.tasks.values.where(
                              (task) => task.parentId == goal.id,
                              ).toList();
                
                              return TasksOverview(tasks: filteredTasks);
                            }
                          )
                        )
                      )
                    ],
                  ),
                ),

                // activity graph widget
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, right: 16, left: 8, bottom: 8),
                          child: ActivityGraph(logs: goal.progressLogs),
                        ),
                      )
                    ],
                  )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}