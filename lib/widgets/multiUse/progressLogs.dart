import 'package:flutter/material.dart';
import '../../models/progresslog.dart';

class ProgressLogs extends StatelessWidget {
  const ProgressLogs({
    super.key,
    required this.logs,
  });

  final List<Progresslog> logs;

  @override
  Widget build(BuildContext context) {
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
            child: Text('Progress Logs',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold, 
              ),
            ),
          ),
          logs.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(child: Text('No progress logs yet.')),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: logs.length,
                  itemBuilder: (context, index) {
                    final log = logs[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: ListTile(
                        title: Text(
                          log.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Progress: +${log.progressMade}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (log.description.isNotEmpty)
                              Text(log.description),
                            Text(
                              '${log.time.day}/${log.time.month}/${log.time.year} at ${log.time.hour}:${log.time.minute.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    );
                  },
                ),
        ],
      ),
        );
  }
}