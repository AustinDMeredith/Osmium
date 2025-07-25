import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/homepage.dart';
import 'pages/goalsearchpage.dart';
import 'pages/viewgoalpage.dart';
import 'pages/projectsearchpage.dart';
import 'pages/viewprojectpage.dart';
import 'models/goal.dart';
import 'models/taskmanager.dart';
import 'models/project.dart';
import 'events/onTaskCreated.dart';
import 'events/onGoalCreated.dart';
import 'events/onProjectCreated.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
  
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;
  Goal? _selectedGoal;
  Project? _selectedProject;
  
  
  void _setTab(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedGoal = null;
      _selectedProject = null;      
    });
  }

  void _viewGoal(Goal goal) {
    setState(() {
      _selectedGoal = goal;
    });
  }

  void _closeGoalDetails() {
    setState(() {
      _selectedGoal = null;
    });
  }

  void _viewProject(Project project) {
    setState(() {
      _selectedProject = project;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskManager>(context, listen: false).updateAllTaskStatuses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      Homepage(
        onTabChange: _setTab,
        onAddGoal: (goalName) {
          String description = 'Add a description';
          String parentId = 'null';
          onGoalCreated(goalName, description, parentId, context);
        },
        onAddProject: (projectName) {
          onProjectCreated(context, projectName);
        },
        onAddTask: (taskName, deadline) {
          double weight = 0;
          String parentId = 'null';
          String isOf = 'null';
          onTaskCreated(taskName, deadline, weight, parentId, context, isOf);
        },
      ),
      Projectsearchpage(onTabChange: _setTab, onViewProject: _viewProject),
      GoalSearchPage(onTabChange: _setTab, onViewGoal: _viewGoal),
      // main pages go here
    ];

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: true,
            selectedIndex: _selectedIndex,
            onDestinationSelected: _setTab,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bar_chart), 
                label: Text('Projects')
              ),
              NavigationRailDestination(
                icon: Icon(Icons.list),
                label: Text('Goals'),
              ),
            ],
          ),
          Expanded(
            child: _selectedProject != null
                ? Viewprojectpage(
                    project: _selectedProject!,
                    onClose: () {
                      setState(() {
                        _selectedProject = null;
                      });
                    },
                  )
                : _selectedGoal != null
                    ? ViewGoalPage(
                        goal: _selectedGoal!,
                        onClose: _closeGoalDetails, // Add this callback to close details
                      )
                    : pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}