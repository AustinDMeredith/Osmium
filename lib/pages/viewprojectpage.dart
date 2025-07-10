import 'package:flutter/material.dart';
import 'milestonesPage.dart';
import 'projectSummaryPage.dart';
import 'activityPageProject.dart';
import 'tasksPage.dart';
import '../models/project.dart';
import '../widgets/projectPage/projectAppBar.dart';

class Viewprojectpage extends StatefulWidget {
  final Project project;
  final VoidCallback onClose;

  const Viewprojectpage({
    required this.project, 
    required this.onClose, 
    super.key});

  @override
  State<Viewprojectpage> createState() => _ViewprojectpageState();
}

class _ViewprojectpageState extends State<Viewprojectpage> {
  String _currentPage = 'summary';

  void _viewPages(String page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProjectAppBar(
        project: widget.project,
        onClose: widget.onClose,
        onViewTasks: () => _viewPages('tasks'),
        onViewMilestones: () => _viewPages('milestones'),
        onViewActivity: () => _viewPages('activity'),
        onViewSummary: () => _viewPages('summary'),
      ),

      body: _buildBody()

    );
  }

  Widget _buildBody() {
    if (_currentPage == 'summary') {
      return ProjectSummaryPage(project: widget.project);
    } else if (_currentPage == 'tasks') {
      return TasksPage(projectId: widget.project.mapId);
    } else if (_currentPage == 'milestones') {
      return MilestonesPage(project: widget.project);
    } else if (_currentPage == 'activity') {
      return ActivityPage(project: widget.project);
    }
    return Center(child: Text('Unknown Page'));
  }
}