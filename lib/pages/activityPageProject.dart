import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/project.dart';
import '../models/projectManager.dart';
import '../models/ProgressLogManager.dart';
import '../widgets/multiUse/progressBar.dart';
import '../widgets/multiUse/progressLogs.dart';
import '../widgets/multiUse/activityGraph.dart';

class ActivityPage extends StatelessWidget {
  final Project project;
  const ActivityPage({
    super.key,
    required this.project
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // progress logs widget
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, bottom: 16, right: 8),
              child: Consumer<ProgressLogManager>(
                builder: (context, logManager, child) {
                  final filteredLogs = logManager.logs.values.where(
                    (log) => log.parentId == project.mapId
                  ).toList();
                  return ProgressLogs(logs: filteredLogs);
                }
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                // Progress bar widget
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, right: 16, left: 8, bottom: 8),
                    child: Consumer<ProjectManager>(
                      builder: (context, projectManager, child) {
                        final thisProject = projectManager.getProject(project.mapId);
                        if(thisProject == null){
                          return const SizedBox();
                        }
                        return ProgressBar(progress: thisProject.currentProgress);
                      }
                    ),
                  ),
                ),

                // Activity graph widget
                Expanded(flex: 5, child: Padding(
                  padding: const EdgeInsets.only(top: 8, right: 16, left: 8, bottom: 16),
                  child: Consumer<ProgressLogManager>(
                    builder: (context, logManager, child) {
                      final filteredLogs = logManager.logs.values.where(
                        (log) => log.parentId == project.mapId
                      ).toList();
                      return ActivityGraph(logs: filteredLogs);
                    }
                  ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}