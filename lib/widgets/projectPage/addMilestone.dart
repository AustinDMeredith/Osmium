import 'package:flutter/material.dart';

class AddMilestoneDialog extends StatefulWidget {
  final void Function(String name, String description) onAdd;

  const AddMilestoneDialog({super.key, required this.onAdd});

  @override
  State<AddMilestoneDialog> createState() => _AddMilestoneDialogState();
}

class _AddMilestoneDialogState extends State<AddMilestoneDialog> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Milestone'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Milestone Name'),
              validator: (value) =>
                  value == null || value.trim().isEmpty ? 'Enter a name' : null,
              onChanged: (value) => setState(() => _name = value),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description (optional)'),
              onChanged: (value) => setState(() => _description = value),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onAdd(_name.trim(), _description.trim());
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}