import 'package:flutter/material.dart';


class Tasks extends StatelessWidget {
  const Tasks({
    super.key,
    required this.onPressed 
  });

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(onPressed: onPressed, child: Text('Tasks')),
    );
  }
}