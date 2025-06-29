import 'package:flutter/material.dart';

class ActivityBtn extends StatelessWidget {
  const ActivityBtn({
    super.key,
    required this.onPressed
    });

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(onPressed: onPressed, child: Text('Activity')),
    );
  }
}