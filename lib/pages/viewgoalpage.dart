import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/goal.dart';
import '../models/goalmanager.dart';
import '../models/progresslog.dart';
import '../widgets/multiUse/progressBar.dart';
import '../widgets/multiUse/progressLogs.dart';

class GoalDetailsPage extends StatefulWidget {
  final Goal goal;
  final VoidCallback onClose;
  const GoalDetailsPage({required this.goal, required this.onClose, super.key});

  @override
  State<GoalDetailsPage> createState() => _GoalDetailsPageState();
}

class _GoalDetailsPageState extends State<GoalDetailsPage> {
  bool _isEditingDescription = false;
  late TextEditingController _descriptionController;
  late List<Progresslog> logs;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController(text: widget.goal.description);
    logs = widget.goal.progressLogs; 
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = widget.goal.currentProgress;
    


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.goal.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: widget.onClose,
        ),
        actions: [
          IconButton(onPressed: () {_showEditDialog(context);}, icon: Icon(Icons.edit)),
          IconButton(onPressed: () {_deleteGoal();}, icon: Icon(Icons.delete))
        ],
      ),
      body: Row(
        children: [
          Expanded(child: 
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16, right: 8, bottom: 16),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          // progress bar
                          ProgressBar(progress: progress),

                          // description title
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0, left: 16,),
                                child: Text('Description: ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold, 
                                  ),
                                ),
                              ),

                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0, right: 16),
                                child: IconButton(
                                  icon: Icon(_isEditingDescription ? Icons.check : Icons.edit),
                                  onPressed: () {
                                    setState(() {
                                      if (_isEditingDescription) {
                                        // Save the description
                                        // You'll need to implement the save logic here
                                        _saveDescription();
                                      }
                                      _isEditingDescription = !_isEditingDescription;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          // description
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: _isEditingDescription
                            ? TextField(
                              controller: _descriptionController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                hintText: 'Enter goal description...',
                                border: OutlineInputBorder(),
                              ),
                            )
                            : Text(
                              widget.goal.description,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ),

          // progress logs
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Your Progress Logs',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold, 
                        ),
                      ),
                    ),

                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => _showAddProgressDialog(context),
                      ),
                    ),
                  ],
                ),

                ProgressLogs(logs: logs),
              ]
            ),
          )
        ],
      )
    );
  }

  void _showEditDialog(BuildContext context) async {
    String? newName = await showDialog<String>(
      context: context,
      builder: (context) {
        String tempName = widget.goal.name;
        return AlertDialog(
          title: Text('Edit Goal'),
          content: TextField(
            controller: TextEditingController(text: widget.goal.name),
            decoration: InputDecoration(hintText: 'Goal name'),
            onChanged: (value) => tempName = value,
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
              child: Text('Save'),
            ),
          ],
        );
      },
    );
    
    if (newName != null) { 
      final goalManager = Provider.of<GoalManager>(context, listen: false);
      widget.goal.name = newName;
    
      // Find the goal ID by searching through the goals map
      int? goalId;
      goalManager.goals.forEach((id, goal) {
        if (goal == widget.goal) {
          goalId = id;
        } 
      });
  
      if (goalId != null) {
        goalManager.addGoal(goalId!, widget.goal);
      }
      setState(() {});
    }
  }

  void _saveDescription() {
    final goalManager = Provider.of<GoalManager>(context, listen: false);
    widget.goal.description = _descriptionController.text;
    
    // Find the goal ID by searching through the goals map
    int? goalId;
    goalManager.goals.forEach((id, goal) {
      if (goal == widget.goal) {
        goalId = id;
      }
    });
  
    if (goalId != null) {
      goalManager.addGoal(goalId!, widget.goal);
    }
  }

  void _showAddProgressDialog(BuildContext context) async {
  String progressName = '';
  double progressAmount = 0.0;
  String progressDescription = '';
  
  final result = await showDialog<Map<String, dynamic>>(
    context: context,
    builder: (context) {
      final nameController = TextEditingController();
      final amountController = TextEditingController();
      final descriptionController = TextEditingController();
      
      return AlertDialog(
        title: Text('Add Progress Log'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Progress Name',
                  hintText: 'Enter progress name',
                ),
                onChanged: (value) => progressName = value,
              ),
              SizedBox(height: 16),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: 'Progress Amount',
                  hintText: 'Enter amount of progress made',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  progressAmount = double.tryParse(value) ?? 0.0;
                },
              ),
              SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'What did you do?',
                ),
                maxLines: 3,
                onChanged: (value) => progressDescription = value,
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
              if (progressName.trim().isNotEmpty && progressAmount > 0) {
                Navigator.pop(context, {
                  'name': progressName.trim(),
                  'amount': progressAmount,
                  'description': progressDescription.trim(),
                });
              }
            },
            child: Text('Add'),
          ),
        ],
      );
    },
  );

  if (result != null) {
    _addProgressLog(result);
  }
}

  void _addProgressLog(Map<String, dynamic> progressData) {
    // Create a new progress log using Progresslog model
    final newProgressLog = Progresslog(
      name: progressData['name'],
      progressMade: progressData['amount'],
      description: progressData['description'],
    );

    // Add the progress log to goal
    widget.goal.progressLogs.add(newProgressLog);

    // Update the goal's current progress
    widget.goal.currentProgress += progressData['amount'];

    // Save to goal manager
    final goalManager = Provider.of<GoalManager>(context, listen: false);
    int? goalId;
    goalManager.goals.forEach((id, goal) {
      if (goal == widget.goal) {
        goalId = id;
      }
    });

    if (goalId != null) {
      goalManager.addGoal(goalId!, widget.goal);
    }

    // Refresh the UI
    setState(() {});
  }

  void _deleteGoal() {
    final goalManager = Provider.of<GoalManager>(context, listen: false);
    int? goalId;
    goalManager.goals.forEach((id, goal) {
    if (goal == widget.goal) {
      goalId = id;
    }
    });

    // When using goalId:
    if (goalId != null) {
      // safe to use goalId
      goalManager.removeGoal(goalId!);
      widget.onClose();
    }
  }
}