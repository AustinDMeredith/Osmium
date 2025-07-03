import 'package:flutter/material.dart';
import '../../models/goal.dart';

class MilestonesOverview extends StatelessWidget {
  // final List<Goal> milestones;
  const MilestonesOverview({
    super.key,
    // required this.milestones
    });

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
            child: Text('Milestones',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold, 
              ),
            ),
          ),
        
          // further implementation will go here
        ],
      ),
    );
  }
}