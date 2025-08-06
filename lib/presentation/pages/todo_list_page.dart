import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_web/presentation/blocs/todo_cubit.dart';
import 'package:todo_app_web/presentation/blocs/todo_state.dart';
import 'package:todo_app_web/presentation/widgets/todo_item.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            if (state.todos.isEmpty) {
              return const Center(child: Text('No todos found.'));
            }
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return TodoItem(
                  todo: todo,
                  onEdit: () {
                    // TODO: Navigate to edit screen or open dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Edit tapped')),
                    );
                  },
                  onDelete: () {
                    context.read<TodoCubit>().deleteTodo(todo.id);
                  },
                );
              },
            );
          } else if (state is TodoError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Open create todo form
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add new todo')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
