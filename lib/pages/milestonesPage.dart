import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/project.dart';
import '../models/goal.dart';
import '../models/goalmanager.dart';
import '../models/taskmanager.dart';
import '../pages/viewgoalpage.dart';

class MilestonesPage extends StatelessWidget {
  final Project project;
  const MilestonesPage({super.key, required this.project});
  

  @override
  Widget build(BuildContext context) {
    final goalManager = Provider.of<GoalManager>(context);
    final taskManager = Provider.of<TaskManager>(context);

    // Find all goals where parentId matches this project's id
    final milestones = goalManager.goals.values
        .where((goal) => goal.parentId == project.mapId)
        .toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(25),
          ),
          child: milestones.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Text('No milestones for this project.'),
                  ),
                )
              : ListView.builder(
                  itemCount: milestones.length,
                  itemBuilder: (context, index) {
                    final milestone = milestones[index];
                    // Get tasks for this milestone
                    final tasks = taskManager.tasks.values
                        .where((task) => task.parentId == milestone.id)
                        .toList();
                    final completedTasks =
                        tasks.where((task) => task.isCompleted).length;
                    final completion = tasks.isEmpty
                        ? 0
                        : (completedTasks / tasks.length * 100).round();
        
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(milestone.name),
                        subtitle: Text(
                            'Completion: $completion% • ${tasks.length} task${tasks.length == 1 ? '' : 's'}'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ViewGoalPage(goal: milestone, onClose: () {
                                Navigator.of(context).pop();
                              },),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}