import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.progress,
  });

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Widget title
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text('Overall Completion: $progress%',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold, 
              ),
            ),
          ),
      
          // Widget implementation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: SizedBox(
              width: 270,
              child: LinearProgressIndicator(
                value: (progress / 100).clamp(0.0, 1.0), // progress should be 0.0 - 1.0
                minHeight: 12,
                
                backgroundColor: Colors.grey[800],
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}