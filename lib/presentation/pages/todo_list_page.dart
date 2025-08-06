import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app_web/presentation/blocs/todo_cubit.dart';
import 'package:todo_app_web/presentation/blocs/todo_state.dart';
import 'package:todo_app_web/presentation/enum/todo_filter.dart';
import 'package:todo_app_web/presentation/widgets/add_todo_modal.dart';
import 'package:todo_app_web/presentation/widgets/filter_dropdown.dart';
import 'package:todo_app_web/presentation/widgets/search_bar_widget.dart';
import 'package:todo_app_web/presentation/widgets/todo_item.dart';

import '../../domain/entities/todo.dart';
import '../widgets/edit_todo_modal.dart';

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
            if (state.todos.isEmpty &&
                state.query.isEmpty &&
                state.filter == TodoFilter.all) {
              return Column(
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: SvgPicture.asset(
                      "assets/images/Detective-check-footprint 1.svg",
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image);
                      },
                    ),
                  ),
                  const Center(child: Text('Empty...')),
                ],
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 400),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: SearchBarWidget(
                          onChanged: context.read<TodoCubit>().searchTodos,
                        ),
                      ),
                      const SizedBox(width: 12),
                      FilterDropdownWidget(
                        selectedFilter: state.filter,
                        onChanged: context.read<TodoCubit>().filterTodos,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: TodoItem(
                          todo: todo,
                          onEdit: () {
                            showEditTodoModal(context, todo.title, (
                              updatedTitle,
                            ) {
                              final updatedTodo = Todo(
                                id: todo.id,
                                title: updatedTitle,
                                completed: todo.completed,
                              );
                              context.read<TodoCubit>().updateTodo(updatedTodo);
                            });
                          },
                          onDelete: () {
                            context.read<TodoCubit>().deleteTodo(
                              todo.id.toString(),
                            );
                          },
                          onCompleteChange: (newValue) {
                            final updatedTodo = Todo(
                              id: todo.id,
                              title: todo.title,
                              completed: newValue,
                            );
                            context.read<TodoCubit>().updateTodo(updatedTodo);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (state is TodoError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 350.0, vertical: 64),
        child: FloatingActionButton(
          onPressed: () {
            showAddTodoModal(context, (title) {
              context.read<TodoCubit>().addTodo(title);
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void showAddTodoModal(BuildContext context, void Function(String) onSubmit) {
    showDialog(
      context: context,
      builder: (context) => AddTodoModal(onSubmit: onSubmit),
    );
  }

  void showEditTodoModal(
    BuildContext context,
    String initialTitle,
    void Function(String) onSubmit,
  ) {
    showDialog(
      context: context,
      builder: (context) =>
          EditTodoModal(initialTitle: initialTitle, onSubmit: onSubmit),
    );
  }
}
