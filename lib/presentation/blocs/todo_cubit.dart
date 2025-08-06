import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app_web/domain/entities/todo.dart';
import 'package:todo_app_web/presentation/blocs/todo_state.dart';

import '../../domain/usecases/create_todo_usecase.dart';
import '../../domain/usecases/delete_todo_usecase.dart';
import '../../domain/usecases/get_todos_usecase.dart';
import '../../domain/usecases/update_todo_usecase.dart';

@injectable
class TodoCubit extends Cubit<TodoState> {
  final GetTodosUseCase getTodosUseCase;
  final CreateTodoUseCase createTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;

  List<Todo> _allTodos = [];

  TodoCubit({
    required this.getTodosUseCase,
    required this.createTodoUseCase,
    required this.updateTodoUseCase,
    required this.deleteTodoUseCase,
  }) : super(TodoInitial());

  Future<void> fetchTodos() async {
    emit(TodoLoading());
    try {
      final todos = await getTodosUseCase();
      _allTodos = todos;
      emit(TodoLoaded(todos, ""));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> addTodo(String title) async {
    emit(TodoLoading());
    try {
      await createTodoUseCase(title);
      await fetchTodos();
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> updateTodo(Todo todo) async {
    emit(TodoLoading());
    try {
      await updateTodoUseCase(todo);
      await fetchTodos();
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> deleteTodo(String id) async {
    emit(TodoLoading());
    try {
      await deleteTodoUseCase(id);
      await fetchTodos();
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  void searchTodos(String query) {
    final filtered = _allTodos
        .where((todo) => todo.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(TodoLoaded(filtered, query));
  }
}
