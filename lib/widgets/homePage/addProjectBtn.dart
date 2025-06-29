import 'package:flutter/material.dart';

class addProjectBtn extends StatelessWidget {
  const addProjectBtn({
    super.key,
    required this.onAddProject
  });

  final void Function (String p1) onAddProject;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('New Project'),
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
                    String? projectName = await showDialog<String>(
                      context: context,
                      builder: (context) {
                        String tempName = '';
                        return AlertDialog(
                          title: Text('Add New Project'),
                          content: TextField(
                            autofocus: true,
                            decoration: InputDecoration(hintText: 'Project name'),
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
                    
                  if (projectName != null && projectName.isNotEmpty) {
                    onAddProject(projectName);
                  }
                  }, 
                  child: Icon(Icons.add_chart, size: 80)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}