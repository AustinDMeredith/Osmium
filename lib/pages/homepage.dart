import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ProgressLogManager.dart';
import '../widgets/homePage/addProjectBtn.dart';
import '../widgets/homePage/addGoalBtn.dart';
import '../widgets/homePage/addTaskBtn.dart';
import '../widgets/homePage/weeklyProgressGraph.dart';
import '../widgets/homePage/todaysTasks.dart';

class Homepage extends StatelessWidget {
  final void Function(int) onTabChange;
  final void Function(String) onAddGoal;
  final void Function(String) onAddProject;
  final void Function(String, DateTime?) onAddTask;

  const Homepage({required this.onTabChange, required this.onAddGoal, required this.onAddProject, required this.onAddTask, super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      // main body
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              
                  // weekly progress graph title
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8),
                    child: Text(
                      'Weekly Progress Graph',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface
                      ),
                    ),
                  ), 
              
                  // weekly progress graph

                  Consumer<ProgressLogManager>(
                    builder: (context, logManager, child) {
                      final now = DateTime.now();
                      final oneWeekAgo = now.subtract(const Duration(days: 7));
                      final filteredLogs = logManager.logs.values.where(
                        (log) => log.time.isAfter(oneWeekAgo.subtract(const Duration(seconds: 1))) && log.time.isBefore(now)
                      ).toList();
                      return weeklyProgressGraph(logs: filteredLogs);
                    }
                  ),
                  

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // add project btn
                      addProjectBtn(onAddProject: onAddProject),
                      
                      // add goal btn
                      addGoalBtn(onAddGoal: onAddGoal),

                      // add task btn
                      addTaskBtn(onAddTask: onAddTask),
                    ],
                  )
                ],
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ 

                // Todays Tasks title widget
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8),
                  child: Text('Todays Tasks',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface
                    ),
                  ),
                ),

                // Todays Tasks
                todaysTasks()
              ],
            )
          )
        ],
      ),     
    );
  }
}