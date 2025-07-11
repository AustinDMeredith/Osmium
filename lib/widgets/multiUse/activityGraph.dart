import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/progresslog.dart';

class ActivityGraph extends StatelessWidget {
  final List<Progresslog> logs;
  const ActivityGraph({
    super.key,
    required this.logs
  });

  @override
  Widget build(BuildContext context) {
    // Sort logs by date
    final sortedLogs = List<Progresslog>.from(logs)
      ..sort((a, b) => a.time.compareTo(b.time));

    // Convert logs to FlSpot points (x: index, y: progress)
    double overallProgress = 0;
    final List<FlSpot> spots = [FlSpot(0, 0)];
      for (int i = 0; i < sortedLogs.length; i++) {
        overallProgress += sortedLogs[i].progressMade.toDouble();
        spots.add(FlSpot((i + 1).toDouble(), overallProgress));
      }


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
            child: Text('Activity',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold, 
              ),
            ),
          ),
          
          // widget logic
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 30, left: 8, top: 8, bottom: 8),
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: 100,
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: false,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        reservedSize: 30,
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value % 1 == 0) {
                            return Text(value.toInt().toString());
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ), 
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        reservedSize: 30,
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value % 1 == 0) {
                            return Text(value.toInt().toString());
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ), 
                    rightTitles: AxisTitles(sideTitles: SideTitles(reservedSize: 30, showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(reservedSize: 30, showTitles: false))
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: true),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}