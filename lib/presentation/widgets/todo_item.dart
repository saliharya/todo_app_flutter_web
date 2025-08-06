import 'package:flutter/material.dart';
import 'package:todo_app_web/domain/entities/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TodoItem({super.key, required this.todo, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(
          todo.completed ? Icons.check_circle : Icons.circle_outlined,
          color: todo.completed ? Colors.green : Colors.grey,
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: todo.completed ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
              tooltip: 'Edit',
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
              tooltip: 'Delete',
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
