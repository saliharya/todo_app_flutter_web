import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_web/data/models/response/todo_response.dart';
import 'package:todo_app_web/presentation/blocs/todo_state.dart';

import '../../domain/usecases/create_todo_usecase.dart';
import '../../domain/usecases/delete_todo_usecase.dart';
import '../../domain/usecases/get_todos_usecase.dart';
import '../../domain/usecases/update_todo_usecase.dart';

class TodoCubit extends Cubit<TodoState> {
  final GetTodosUseCase getTodosUseCase;
  final CreateTodoUseCase createTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;

  TodoCubit({
    required this.getTodosUseCase,
    required this.createTodoUseCase,
    required this.updateTodoUseCase,
    required this.deleteTodoUseCase,
  }) : super(TodoInitial());

  Future<void> fetchTodos() async {
    emit(TodoLoading());
    final response = await getTodosUseCase();
    if (response.data != null) {
      emit(TodoLoaded(response.data!));
    } else {
      emit(
        TodoError(response.errorDetails?.message ?? 'Failed to fetch todos'),
      );
    }
  }

  Future<void> addTodo(TodoResponse todo) async {
    emit(TodoLoading());
    final response = await createTodoUseCase(todo);
    if (response.data != null) {
      fetchTodos();
    } else {
      emit(TodoError(response.errorDetails?.message ?? 'Failed to add todo'));
    }
  }

  Future<void> updateTodo(int id, TodoResponse todo) async {
    emit(TodoLoading());
    final response = await updateTodoUseCase(id, todo);
    if (response.data != null) {
      fetchTodos();
    } else {
      emit(
        TodoError(response.errorDetails?.message ?? 'Failed to update todo'),
      );
    }
  }

  Future<void> deleteTodo(int id) async {
    emit(TodoLoading());
    final response = await deleteTodoUseCase(id);
    if (response.code == 200) {
      fetchTodos();
    } else {
      emit(
        TodoError(response.errorDetails?.message ?? 'Failed to delete todo'),
      );
    }
  }
}
