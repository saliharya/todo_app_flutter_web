import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app_web/domain/repositories/todo_repository.dart';

import '../datasources/remote/api/todo_api.dart';
import '../models/response/todo_response.dart';

@LazySingleton(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  final TodoApi _api;

  TodoRepositoryImpl(this._api);

  @override
  Future<List<TodoResponse>> getTodos() async {
    return _api.getTodos();
  }

  @override
  Future<TodoResponse> createTodo(TodoResponse todo) async {
    return _api.createTodo(todo.toJson());
  }

  @override
  Future<TodoResponse> updateTodo(String id, TodoResponse todo) async {
    return _api.updateTodo(id, todo.toJson());
  }

  @override
  Future<TodoResponse> deleteTodo(String id) async {
    return _api.deleteTodo(id);
  }

  Exception _toReadableError(DioException error) {
    final message =
        error.response?.data['error']?['message'] ??
        error.message ??
        'Unknown error';
    return Exception(message);
  }
}
