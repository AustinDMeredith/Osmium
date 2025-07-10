import 'package:flutter/material.dart';
import 'package:osmium_flutter/models/project.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/goalmanager.dart';

class MilestonesOverview extends StatelessWidget {
  final Project project;
  const MilestonesOverview({
    super.key,
    required this.project
  });

  @override
  Widget build(BuildContext context) {
    final goalManager = Provider.of<GoalManager>(context);

    // Get all milestones (goals with a parentId that is not null)
    final milestones = goalManager.goals.values
        .where((goal) => goal.parentId == project.mapId)
        .toList();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Milestones',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (milestones.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text('No milestones found.'),
            )
          else
            SizedBox(
              height: 120, // Set a fixed height for the horizontal list
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: milestones.length,
                itemBuilder: (context, index) {
                  final milestone = milestones[index];

                  // Use project.currentProgress for completion (assuming 0-100 scale)
                  final completion = (milestone.currentProgress.clamp(0, 100)) / 100.0;

                  return SizedBox(
                    width: 200, // Set a fixed width for each card
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      child: ListTile(
                        leading: SizedBox(
                          width: 48,
                          height: 48,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              PieChart(
                                PieChartData(
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 18,
                                  startDegreeOffset: -90,
                                  sections: [
                                    PieChartSectionData(
                                      value: completion * 100,
                                      color: Colors.blue,
                                      radius: 22,
                                      showTitle: false,
                                    ),
                                    PieChartSectionData(
                                      value: (1 - completion) * 100,
                                      color: Colors.grey.shade300,
                                      radius: 22,
                                      showTitle: false,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${(completion * 100).round()}%',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(milestone.name),
                        ),
                      ),
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