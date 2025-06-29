import 'package:flutter/material.dart';

class weeklyProgressGraph extends StatelessWidget {
  const weeklyProgressGraph({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
        child: 
        Container( 
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(25), 
          ),
          
          // weekly progress graph implementation                        
          
        ),
      ),
    );
  }
}