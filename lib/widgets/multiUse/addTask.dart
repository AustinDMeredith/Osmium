import 'package:flutter/material.dart';

void showTaskDialog(BuildContext context, {void Function(String name, DateTime? deadline, double progressWeight)? onSubmit}) {
  final _formKey = GlobalKey<FormState>();
  String taskName = '';
  DateTime? deadline;
  double progressWeight = 1.0;
  TimeOfDay? deadlineTime; // Add this line

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder( // Use StatefulBuilder for local state
        builder: (context, setState) {
          String deadlineText;
          if (deadline == null) {
            deadlineText = 'No deadline';
          } else {
            final dateStr = deadline!.toLocal().toString().split(' ')[0];
            final timeStr = deadlineTime != null
                ? deadlineTime!.format(context)
                : (deadline!.hour != 0 || deadline!.minute != 0
                    ? '${deadline!.hour.toString().padLeft(2, '0')}:${deadline!.minute.toString().padLeft(2, '0')}'
                    : '');
            deadlineText = 'Deadline: $dateStr${timeStr.isNotEmpty ? ' $timeStr' : ''}';
          }

          return AlertDialog(
            title: Text('Add Task'),
            content: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Task Name'),
                      validator: (value) => value == null || value.isEmpty ? 'Enter a name' : null,
                      onChanged: (value) => taskName = value,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Progress Weight'),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      initialValue: '1',
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Enter a weight';
                        final num? parsed = num.tryParse(value);
                        if (parsed == null || parsed <= 0) return 'Enter a valid number';
                        return null;
                      },
                      onChanged: (value) => progressWeight = double.tryParse(value) ?? 1.0,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: Text(deadlineText)),
                        TextButton(
                          child: Text('Pick Date'),
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: deadline ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              setState(() {
                                deadline = DateTime(
                                  picked.year,
                                  picked.month,
                                  picked.day,
                                  deadlineTime?.hour ?? 0,
                                  deadlineTime?.minute ?? 0,
                                );
                              });
                            }
                          },
                        ),
                        TextButton(
                          child: Text('Pick Time'),
                          onPressed: () async {
                            final picked = await showTimePicker(
                              context: context,
                              initialTime: deadlineTime ?? TimeOfDay.now(),
                            );
                            if (picked != null) {
                              setState(() {
                                deadlineTime = picked;
                                if (deadline != null) {
                                  deadline = DateTime(
                                    deadline!.year,
                                    deadline!.month,
                                    deadline!.day,
                                    picked.hour,
                                    picked.minute,
                                  );
                                }
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                child: Text('Add'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (onSubmit != null) {
                      onSubmit(taskName, deadline, progressWeight);
                    }
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        },
      );
    },
  );
}