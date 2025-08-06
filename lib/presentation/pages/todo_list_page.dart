import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_web/domain/entities/todo.dart';
import 'package:todo_app_web/presentation/blocs/todo_cubit.dart';
import 'package:todo_app_web/presentation/blocs/todo_state.dart';
import 'package:todo_app_web/presentation/widgets/add_todo_modal.dart';
import 'package:todo_app_web/presentation/widgets/todo_item.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 32.0),
          child: Text('Todo List'),
        ),
        centerTitle: true,
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
                    context.read<TodoCubit>().deleteTodo(todo.id.toString());
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
          showAddTodoModal(context, (title, completed) {
            final todo = Todo(title: title, completed: completed);
            context.read<TodoCubit>().addTodo(todo);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void showAddTodoModal(BuildContext context, void Function(String, bool) onSubmit) {
    showDialog(
      context: context,
      builder: (context) => AddTodoModal(onSubmit: onSubmit),
    );
  }
}
