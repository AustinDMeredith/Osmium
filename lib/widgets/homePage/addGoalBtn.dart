import 'package:flutter/material.dart';

class addGoalBtn extends StatelessWidget {
  const addGoalBtn({
    super.key,
    required this.onAddGoal,
  });

  final void Function(String p1) onAddGoal;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('New Goal'),
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
                    String? goalName = await showDialog<String>(
                      context: context,
                      builder: (context) {
                        String tempName = '';
                        return AlertDialog(
                          title: Text('Add New Goal'),
                          content: TextField(
                            autofocus: true,
                            decoration: InputDecoration(hintText: 'Goal name'),
                            onChanged: (value) => tempName = value,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context), // Cancel
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
                    if (goalName != null && goalName.isNotEmpty) {
                      onAddGoal(goalName);
                    }
                  }, 
                  child: Icon(Icons.add_box, size: 80)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}