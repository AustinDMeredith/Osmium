import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({
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