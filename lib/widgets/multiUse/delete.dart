import 'package:flutter/material.dart';

class delete extends StatelessWidget {
    final VoidCallback onPressed;
  const delete({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, icon: Icon(Icons.delete));
  }
}