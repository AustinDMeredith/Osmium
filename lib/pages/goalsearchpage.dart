import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/goal.dart';
import '../models/goalmanager.dart';

class GoalSearchPage extends StatefulWidget {
  final void Function(int) onTabChange;
  final void Function(Goal) onViewGoal;

  const GoalSearchPage({
    required this.onTabChange,
    required this.onViewGoal,
    super.key,
  });

  @override
  State<GoalSearchPage> createState() => _GoalDetailsPageState();
}

class _GoalDetailsPageState extends State<GoalSearchPage> {
  bool _showSearch = false;
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    final goals = Provider.of<GoalManager>(context).goals;
    final filteredGoals = goals.entries.where((entry) {
      final goal = entry.value;
      return goal.parentId == 'null' && goal.name.toLowerCase().contains(_searchText.toLowerCase());
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
                        'Goals',
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


                // The goals list
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: filteredGoals.isEmpty
                          ? const Center(child: Text('No goals found.'))
                          : ListView(
                              children: filteredGoals.map((entry) {
                                final goal = entry.value;
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
                                    title: Text(goal.name),
                                    onTap: () => widget.onViewGoal(goal),
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