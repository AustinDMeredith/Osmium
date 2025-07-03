import 'package:flutter/material.dart';
import '../../models/goal.dart';
import '../multiUse/viewSummaryBtn.dart';
import '../multiUse/viewTasksBtn.dart';
import '../multiUse/activityBtn.dart';
import '../multiUse/delete.dart';

class GoalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Goal goal;
  final VoidCallback onClose;
  final VoidCallback onViewTasks;
  final VoidCallback onViewActivity;
  final VoidCallback onViewSummary;

  const GoalAppBar({
    super.key,
    required this.goal,
    required this.onClose,
    required this.onViewActivity,
    required this.onViewTasks,
    required this.onViewSummary
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(goal.name,
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: onClose,
      ),
      actions: [
        SummaryBtn(onPressed: onViewSummary),
        Tasks(onPressed:  onViewTasks),
        ActivityBtn(onPressed: onViewActivity),
        delete(),
      ],
    );
  }
}