import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'project.dart';

class ProjectManager extends ChangeNotifier {
  // Get the box when needed, after it's open in main()
  Box<Project> get _projectBox => Hive.box('projects');

  // add a project
  void addProject(int id, Project project) {
    _projectBox.put(id, project);
    notifyListeners();
  }

  // get a project by id
  Project? getProject(int id) {
    return _projectBox.get(id);
  }

  // get all projects as a map
  Map<dynamic, Project> get projects => _projectBox.toMap();

  // remove project by id
  void removeProject(int id) {
    _projectBox.delete(id);
    notifyListeners();
  }

  // get next available id
  int getNextId() {
    if(_projectBox.isEmpty) return 0;
    return _projectBox.keys.cast<int>().reduce((a, b) => a > b ? a : b) + 1;
  }
}