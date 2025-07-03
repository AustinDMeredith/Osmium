import 'package:flutter/material.dart';
import '../models/goal.dart';
import 'activityPageGoal.dart';
import '../pages/tasksPage.dart';
import '../widgets/goalPage/goalAppBar.dart';


class ViewGoalPage extends StatefulWidget {
  final Goal goal;
  final VoidCallback onClose;
  const ViewGoalPage({
    super.key,
    required this.goal,
    required this.onClose
    });

  @override
  State<ViewGoalPage> createState() => _ViewGoalPageState();
}

class _ViewGoalPageState extends State<ViewGoalPage> {
  String _currentPage = 'summary';

  void _viewPages(String page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoalAppBar(
        goal: widget.goal, 
        onClose: widget.onClose, 
        onViewActivity: () => _viewPages('activity'),
        onViewTasks: () => _viewPages('tasks'), 
        onViewSummary: () => _viewPages('summary')
      ),

      body: _buildBody()
    );
  }

  Widget _buildBody() {
    if (_currentPage == 'summary') {
      return Center(child: Text('Summary Page'));
    } else if (_currentPage == 'tasks') {
      return TasksPage(projectId: widget.goal.id);
    } else if (_currentPage == 'activity') {
      return ActivityPage(goal: widget.goal);
    }
    return Center(child: Text('Unknown Page'));
  }
}