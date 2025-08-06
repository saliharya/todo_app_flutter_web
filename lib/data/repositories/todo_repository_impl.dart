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
    try {
      final response = await _api.getTodos();
      final raw = response.data;

      final List<TodoResponse> todos = (raw['data'] as List)
          .map((e) => TodoResponse.fromJson(e as Map<String, dynamic>))
          .toList();

      return todos;
    } on DioException catch (e) {
      throw _toReadableError(e);
    }
  }

  @override
  Future<TodoResponse> createTodo(TodoResponse todo) async {
    try {
      final response = await _api.createTodo(todo.toJson());
      final raw = response.data;

      return TodoResponse.fromJson(raw['data']);
    } on DioException catch (e) {
      throw _toReadableError(e);
    }
  }

  @override
  Future<TodoResponse> updateTodo(int id, TodoResponse todo) async {
    try {
      final response = await _api.updateTodo(id, todo.toJson());
      final raw = response.data;

      return TodoResponse.fromJson(raw['data']);
    } on DioException catch (e) {
      throw _toReadableError(e);
    }
  }

  @override
  Future<void> deleteTodo(int id) async {
    try {
      await _api.deleteTodo(id);
    } on DioException catch (e) {
      throw _toReadableError(e);
    }
  }

  Exception _toReadableError(DioException error) {
    final message =
        error.response?.data['error']?['message'] ??
        error.message ??
        'Unknown error';
    return Exception(message);
  }
}
