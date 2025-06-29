import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/task.dart';

class TasksOverview extends StatelessWidget {
  final List<Task> tasks;
  const TasksOverview({
    super.key,
    required this.tasks
    });

  @override
  Widget build(BuildContext context) {
    // Filter out completed tasks
    final activeTasks = tasks.where((t) => t.isCompleted == false).toList();

    int late = activeTasks.where((t) => t.status == 'late').length;
    int started = activeTasks.where((t) => t.status == 'started').length;
    int today = activeTasks.where((t) => t.status == 'today').length;
    int upcoming = activeTasks.where((t) => t.status == 'upcoming').length;

    // If all are zero, show a single gray section
    final bool allZero = late + started + today + upcoming == 0;
    final List<PieChartSectionData> sections = allZero
        ? [
            PieChartSectionData(
              value: 1,
              color: Colors.grey[400]!,
              title: '',
            ),
          ]
        : [
            PieChartSectionData(
              value: late.toDouble(),
              color: Colors.red,
              title: ''
            ),
            PieChartSectionData(
              value: started.toDouble(),
              color: Colors.blue,
              title: ''
            ),
            PieChartSectionData(
              value: today.toDouble(),
              color: Colors.green,
              title: ''
            ),
            PieChartSectionData(
              value: upcoming.toDouble(),
              color: Colors.orange,
              title: ''
            ),
          ];

    return Container(
      width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(25),
        ),
      child: Column(
        children: [
          // Widget title
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text('Tasks',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold, 
              ),
            ),
          ),
          
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.red,), child: SizedBox(height: 10, width: 10)),
                        SizedBox(width: 5),
                        Text('Late ($late)', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    Row(
                      children: [
                        Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.blue,), child: SizedBox(height: 10, width: 10)),
                        SizedBox(width: 5),
                        Text('Started ($started)', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    Row(
                      children: [
                        Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.green,), child: SizedBox(height: 10, width: 10)),
                        SizedBox(width: 5),
                        Text('Today ($today)', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    Row(
                      children: [
                        Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.orange,), child: SizedBox(height: 10, width: 10)),
                        SizedBox(width: 5),
                        Text('Upcoming ($upcoming)', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 20),
                // Pie Chart
                SizedBox(
                  width: 200,
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sections: sections,
                      sectionsSpace: 2,
                      centerSpaceRadius: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}