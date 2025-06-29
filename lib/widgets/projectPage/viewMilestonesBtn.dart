import 'package:flutter/material.dart';


class MilestonesBtn extends StatelessWidget {
  const MilestonesBtn({
    required this.onPressed,
    super.key
    });

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(onPressed: onPressed, child: Text('Milestones')),
    );
  }
}