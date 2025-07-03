import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'project.dart';

class ProjectManager extends ChangeNotifier {
  // Get the box when needed, after it's open in main()
  Box<Project> get _projectBox => Hive.box('projects');

  // add a project
  void addProject(String id, Project project) {
    _projectBox.put(id, project);
    notifyListeners();
  }

  // get a project by id
  Project? getProject(String id) {
    return _projectBox.get(id);
  }

  // get all projects as a map
  Map<dynamic, Project> get projects => _projectBox.toMap();

  // remove project by id
  void removeProject(String id) {
    _projectBox.delete(id);
    notifyListeners();
  }

  final Uuid uuid = Uuid();
  // get next available id
  String getNextId() {
    String id = uuid.v4();
    return id;
  }
}