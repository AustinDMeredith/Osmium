import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/progresslog.dart';
import 'package:intl/intl.dart';

class weeklyProgressGraph extends StatelessWidget {
  final List<Progresslog> logs;
  const weeklyProgressGraph({
    super.key,
    required this.logs
  });

  @override
  Widget build(BuildContext context) {
    // Prepare data: sum progress for each day of the past week
    final now = DateTime.now();
    // Find the most recent Monday
    final int daysSinceMonday = (now.weekday + 6) % 7;
    final monday = now.subtract(Duration(days: daysSinceMonday));
    // Generate the week starting from Monday
    final days = List.generate(7, (i) => monday.add(Duration(days: i)));
    final progressPerDay = List<double>.filled(7, 0);

    for (var log in logs) {
      for (int i = 0; i < 7; i++) {
        if (log.time.year == days[i].year &&
            log.time.month == days[i].month &&
            log.time.day == days[i].day) {
          progressPerDay[i] += log.progressMade.toDouble();
        }
      }
    }

    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BarChart(
              BarChartData(
                barGroups: List.generate(7, (i) => BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                      toY: progressPerDay[i],
                      color: Colors.blue,
                      width: 18,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ],
                )),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 32),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index > 6) return const SizedBox();
                        final day = days[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            DateFormat.E().format(day), // Mon, Tue, etc.
                            style: const TextStyle(fontSize: 12),
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
              ),
            ),
          ),
        ),
      ),
    );
  }
}