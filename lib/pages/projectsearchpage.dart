import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/project.dart';
import '../models/projectManager.dart';

class Projectsearchpage extends StatefulWidget {
  final void Function(int) onTabChange;
  final void Function(Project) onViewProject;
  const Projectsearchpage({
    required this.onTabChange,
    required this.onViewProject,
    super.key});

  @override
  State<Projectsearchpage> createState() => _ProjectsearchpageState();
}

class _ProjectsearchpageState extends State<Projectsearchpage> {
  bool _showSearch = false;
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    final projects = Provider.of<ProjectManager>(context).projects;
    final filteredProjects = projects.entries.where((entry) {
      final project = entry.value;
      return project.name.toLowerCase().contains(_searchText.toLowerCase());
    }).toList();

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                // Toggle button for search bar
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16, right: 8),
                  child: Row(
                    children: [
                      Text(
                        'Projects',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(_showSearch ? Icons.close : Icons.search),
                        onPressed: () {
                          setState(() {
                            _showSearch = !_showSearch;
                            if (!_showSearch) _searchText = '';
                          });
                        },
                      ),
                    ],
                  ),
                ),
                // Animated search bar
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 200),
                  crossFadeState: _showSearch
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Search goals...',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchText = value;
                        });
                      },
                    ),
                  ),
                  secondChild: const SizedBox.shrink(),
                ),


                // The projects list
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: filteredProjects.isEmpty
                          ? const Center(child: Text('No projects found.'))
                          : ListView(
                              children: filteredProjects.map((entry) {
                                final project = entry.value;
                                return Container(
                                  margin: const EdgeInsets.symmetric(vertical: 6),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.onSurface,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    color: Theme.of(context).colorScheme.surface,
                                  ),
                                  child: ListTile(
                                    title: Text(project.name),
                                    onTap: () => widget.onViewProject(project),
                                  ),
                                );
                              }).toList(),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}