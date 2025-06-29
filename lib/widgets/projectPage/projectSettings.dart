import 'package:flutter/material.dart';

class projectSettings extends StatelessWidget {
  const projectSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
    );
  }
}