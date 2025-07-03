import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/homepage.dart';
import 'pages/goalsearchpage.dart';
import 'pages/viewgoalpage.dart';
import 'pages/projectsearchpage.dart';
import 'pages/viewprojectpage.dart';
import 'models/goalmanager.dart';
import 'models/goal.dart';
import 'models/taskmanager.dart';
import 'models/task.dart';
import 'models/projectManager.dart';
import 'models/project.dart';

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
  Widget build(BuildContext context) {
    final pages = [
      Homepage(
        onTabChange: _setTab,
        onAddGoal: (goalName) {
          final goalManager = Provider.of<GoalManager>(context, listen: false);
          String id = goalManager.getNextId();
          goalManager.addGoal(id, Goal(name: goalName, id: id));
        },
        onAddProject: (projectName) {
          final projectManager = Provider.of<ProjectManager>(context, listen: false);
          String id = projectManager.getNextId();
          projectManager.addProject(id, Project(name: projectName, mapId: id));
        },
        onAddTask: (taskName, deadline) {
          final taskManager = Provider.of<TaskManager>(context, listen: false);
          int id = taskManager.getNextId();
          taskManager.addTask(id, Task(name: taskName, deadline: deadline, progressWeight: 0, id: id));
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