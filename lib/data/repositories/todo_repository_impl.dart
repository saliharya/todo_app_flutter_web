import 'package:dio/dio.dart';
import 'package:todo_app_web/domain/repositories/todo_repository.dart';
import 'package:todo_app_web/utils/base/base_response.dart';
import 'package:todo_app_web/utils/error_details.dart';

import '../datasources/remote/api/todo_api.dart';
import '../models/response/todo_response.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoApi _api;

  TodoRepositoryImpl(this._api);

  @override
  Future<BaseResponse<List<TodoResponse>>> getTodos() async {
    try {
      final response = await _api.getTodos();
      final raw = response.data;

      final List<TodoResponse> todos = (raw['data'] as List)
          .map((e) => TodoResponse.fromJson(e as Map<String, dynamic>))
          .toList();

      return BaseResponse<List<TodoResponse>>(
        data: todos,
        code: raw['code'],
        errorDetails: _parseError(raw),
      );
    } on DioException catch (e) {
      return _handleError<List<TodoResponse>>(e);
    }
  }

  @override
  Future<BaseResponse<TodoResponse>> createTodo(TodoResponse todo) async {
    try {
      final response = await _api.createTodo(todo.toJson());
      final raw = response.data;

      final parsed = TodoResponse.fromJson(raw['data']);

      return BaseResponse<TodoResponse>(
        data: parsed,
        code: raw['code'],
        errorDetails: _parseError(raw),
      );
    } on DioException catch (e) {
      return _handleError<TodoResponse>(e);
    }
  }

  @override
  Future<BaseResponse<TodoResponse>> updateTodo(
    int id,
    TodoResponse todo,
  ) async {
    try {
      final response = await _api.updateTodo(id, todo.toJson());
      final raw = response.data;

      final parsed = TodoResponse.fromJson(raw['data']);

      return BaseResponse<TodoResponse>(
        data: parsed,
        code: raw['code'],
        errorDetails: _parseError(raw),
      );
    } on DioException catch (e) {
      return _handleError<TodoResponse>(e);
    }
  }

  @override
  Future<BaseResponse<void>> deleteTodo(int id) async {
    try {
      final response = await _api.deleteTodo(id);
      final raw = response.data;

      return BaseResponse<void>(
        data: null,
        code: raw['code'],
        errorDetails: _parseError(raw),
      );
    } on DioException catch (e) {
      return _handleError<void>(e);
    }
  }

  BaseResponse<T> _handleError<T>(DioException error) {
    return BaseResponse<T>(
      code: error.response?.statusCode,
      errorDetails: ErrorDetails(
        message: error.message ?? "Unknown error",
        details: error.response?.data.toString(),
      ),
    );
  }

  ErrorDetails? _parseError(Map<String, dynamic> raw) {
    final error = raw['error'];
    if (error == null) return null;

    return ErrorDetails(message: error['message'], details: error['details']);
  }
}
