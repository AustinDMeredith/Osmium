import 'package:flutter/material.dart';

class addTaskBtn extends StatelessWidget {
  const addTaskBtn({
    super.key,
    required this.onAddTask,
  });

  final void Function(String p1, DateTime? p2) onAddTask;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('New Task'),
            SizedBox(height: 8),
            SizedBox(
              height: 130,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25), // Match container radius
                    ),
                  ),
                  onPressed: () async {
                    String tempName = '';
                    DateTime? deadline;
                    String? result = await showDialog<String>(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: Text('Add New Task'),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    TextField(
                                      autofocus: true,
                                      decoration: InputDecoration(hintText: 'Task name'),
                                      onChanged: (value) => tempName = value,
                                    ),
                                    SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Text(deadline == null
                                            ? 'No deadline'
                                            : 'Deadline: ${deadline!.toLocal().toString().substring(0, 16)}'),
                                        Spacer(),
                                        TextButton(
                                          onPressed: () async {
                                            DateTime? pickedDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2100),
                                            );
                                            if (pickedDate != null) {
                                              TimeOfDay? pickedTime = await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                              );
                                              setState(() {
                                                if (pickedTime != null) {
                                                  deadline = DateTime(
                                                    pickedDate.year,
                                                    pickedDate.month,
                                                    pickedDate.day,
                                                    pickedTime.hour,
                                                    pickedTime.minute,
                                                  );
                                                } else {
                                                  deadline = DateTime(
                                                    pickedDate.year,
                                                    pickedDate.month,
                                                    pickedDate.day,
                                                  );
                                                }
                                              });
                                            }
                                          },
                                          child: Text('Pick Deadline'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (tempName.trim().isNotEmpty) {
                                      Navigator.pop(context, tempName.trim());
                                    }
                                  },
                                  child: Text('Add'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                    if (result != null && result.isNotEmpty) {
                      // Use tempName and deadline here
                      onAddTask(tempName, deadline);
                    }
                  }, 
                  child: Icon(Icons.add_task, size: 80)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}