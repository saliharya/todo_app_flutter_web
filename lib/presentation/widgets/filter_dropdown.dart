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
      items: [
        const DropdownMenuItem(
          value: TodoFilter.all,
          child: Text('All'),
        ),
        DropdownMenuItem(
          value: TodoFilter.incompleted,
          child: const Text('Incomplete'),
        ),
        DropdownMenuItem(
          value: TodoFilter.completed,
          child: const Text('Complete'),
        ),
      ],
    );
  }
}
