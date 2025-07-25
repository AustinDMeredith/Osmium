import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/projectManager.dart';
import '../models/project.dart';

void onProjectCreated(BuildContext context, String projectName) {
    final projectManager = Provider.of<ProjectManager>(context, listen: false);
    String id = projectManager.getNextId();
    projectManager.addProject(id, Project(name: projectName, mapId: id));
  }