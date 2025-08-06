import 'package:dio/dio.dart';
import 'package:todo_app_web/data/models/response/todo_response.dart';

import '../../../../core/constants/api_constants.dart';

class TodoApi {
  final Dio _dio;

  TodoApi(this._dio);

  Future<List<TodoResponse>> getTodos() async {
    final response = await _dio.get(ApiConstants.todosEndpoint);

    final todos = (response.data as List)
        .map((e) => TodoResponse.fromJson(e as Map<String, dynamic>))
        .toList();

    return todos;
  }

  Future<TodoResponse> createTodo(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiConstants.todosEndpoint);
    return TodoResponse.fromJson(response.data);
  }

  Future<TodoResponse> updateTodo(String id, Map<String, dynamic> data) async {
    final response = await _dio.put(ApiConstants.todosEndpoint);
    return TodoResponse.fromJson(response.data);
  }

  Future<TodoResponse> deleteTodo(String id) async {
    final response = await _dio.delete(ApiConstants.todosEndpoint);
    return TodoResponse.fromJson(response.data);
  }
}
