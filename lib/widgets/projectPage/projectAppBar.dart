import 'package:flutter/material.dart';
import '../../models/project.dart';
import '../multiUse/delete.dart';
import '../multiUse/viewTasksBtn.dart';
import '../multiUse/activityBtn.dart';
import '../multiUse/viewSummaryBtn.dart';
// import '../multiUse/settings.dart';
import 'viewMilestonesBtn.dart';
import 'elementSelectProject.dart';
import '../../events/onProjectDelete.dart';

class ProjectAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProjectAppBar({
    super.key,
    required this.project,
    required this.onClose,
    required this.onViewTasks,
    required this.onViewMilestones,
    required this.onViewActivity,
    required this.onViewSummary
  });

  final Project project;
  final VoidCallback onClose;
  final VoidCallback onViewTasks;
  final VoidCallback onViewMilestones;
  final VoidCallback onViewActivity;
  final VoidCallback onViewSummary;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(project.name,
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
        MilestonesBtn(onPressed: onViewMilestones),
        Tasks(onPressed:  onViewTasks),
        ActivityBtn(onPressed: onViewActivity),
        ProjectElementSelect(project: project),
        delete(onPressed: () => onProjectDelete(project, context)),
        // Settings()
      ],
    );
  }
}