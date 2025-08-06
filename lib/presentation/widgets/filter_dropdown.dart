import 'package:flutter/material.dart';

import '../enum/todo_filter.dart';

class FilterDropdownWidget extends StatelessWidget {
  final TodoFilter selectedFilter;
  final ValueChanged<TodoFilter> onChanged;

  const FilterDropdownWidget({
    super.key,
    required this.selectedFilter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<TodoFilter>(
      value: selectedFilter,
      onChanged: (TodoFilter? newValue) {
        if (newValue != null) {
          onChanged(newValue);
        }
      },
      underline: Container(),
      borderRadius: BorderRadius.circular(8),
      items: TodoFilter.values.map((filter) {
        final label = switch (filter) {
          TodoFilter.all => 'All',
          TodoFilter.incompleted => 'Incomplete',
          TodoFilter.completed => 'Complete',
        };
        return DropdownMenuItem<TodoFilter>(
          value: filter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(label),
          ),
        );
      }).toList(),
    );
  }
}
