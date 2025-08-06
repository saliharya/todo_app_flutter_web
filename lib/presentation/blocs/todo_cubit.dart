import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app_web/domain/entities/todo.dart';
import 'package:todo_app_web/domain/usecases/create_todo_usecase.dart';
import 'package:todo_app_web/domain/usecases/delete_todo_usecase.dart';
import 'package:todo_app_web/domain/usecases/get_todos_usecase.dart';
import 'package:todo_app_web/domain/usecases/update_todo_usecase.dart';
import 'package:todo_app_web/presentation/blocs/todo_state.dart';
import 'package:todo_app_web/presentation/enum/todo_filter.dart';

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

  String _query = '';
  TodoFilter _filter = TodoFilter.all;

  Future<void> fetchTodos() async {
    emit(TodoLoading());
    try {
      _allTodos = await getTodosUseCase();
      _emitFilteredTodos();
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
    _query = query;
    _emitFilteredTodos();
  }

  void filterTodos(TodoFilter filter) {
    _filter = filter;
    _emitFilteredTodos();
  }

  void _emitFilteredTodos() {
    List<Todo> filtered = _allTodos;

    if (_query.isNotEmpty) {
      filtered = filtered
          .where(
            (todo) => todo.title.toLowerCase().contains(_query.toLowerCase()),
          )
          .toList();
    }

    if (_filter == TodoFilter.completed) {
      filtered = filtered.where((todo) => todo.completed).toList();
    } else if (_filter == TodoFilter.incompleted) {
      filtered = filtered.where((todo) => !todo.completed).toList();
    }

    emit(TodoLoaded(filtered, _query, _filter));
  }
}
