import 'package:injectable/injectable.dart';
import 'package:todo_app_web/data/models/response/todo_dto.dart';
import 'package:todo_app_web/domain/repositories/todo_repository.dart';

import '../../domain/entities/todo.dart';
import '../datasources/remote/api/todo_api.dart';

@LazySingleton(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  final TodoApi _api;

  TodoRepositoryImpl(this._api);

  @override
  Future<List<Todo>> getTodos() async {
    try {
      final todosResponse = await _api.getTodos();
      return todosResponse.map(_todoEntityMapper).toList();
    } on Exception {
      throw Exception("Failed to fetch todos");
    }
  }

  @override
  Future<Todo> createTodo(Todo todo) async {
    try {
      final todoResponse = await _api.createTodo(_todoDtoMapper(todo).toJson());
      return _todoEntityMapper(todoResponse);
    } on Exception {
      throw Exception("Failed to create todo");
    }
  }

  @override
  Future<Todo> updateTodo(Todo todo) async {
    try {
      final todoResponse = await _api.updateTodo(_todoDtoMapper(todo).toJson());
      return _todoEntityMapper(todoResponse);
    } on Exception {
      throw Exception("Failed to update todo");
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    try {
      await _api.deleteTodo(id);
    } on Exception {
      throw Exception("Failed to delete todo");
    }
  }

  Todo _todoEntityMapper(TodoDto todo) =>
      Todo(id: todo.id, title: todo.title, completed: todo.completed);

  TodoDto _todoDtoMapper(Todo todo) =>
      TodoDto(id: todo.id, title: todo.title, completed: todo.completed);
}
