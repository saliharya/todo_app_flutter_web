import 'package:dio/dio.dart';
import 'package:todo_app_web/data/models/response/todo_dto.dart';

import '../../../../core/constants/api_constants.dart';

class TodoApi {
  final Dio _dio;

  TodoApi(this._dio);

  Future<List<TodoDto>> getTodos() async {
    final response = await _dio.get(ApiConstants.todosEndpoint);

    final todos = (response.data as List)
        .map((e) => TodoDto.fromJson(e as Map<String, dynamic>))
        .toList();

    return todos;
  }

  Future<TodoDto> createTodo(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiConstants.todosEndpoint);
    return TodoDto.fromJson(response.data);
  }

  Future<TodoDto> updateTodo(Map<String, dynamic> data) async {
    final response = await _dio.put(ApiConstants.todosEndpoint);
    return TodoDto.fromJson(response.data);
  }

  Future<TodoDto> deleteTodo(String id) async {
    final response = await _dio.delete(ApiConstants.todosEndpoint);
    return TodoDto.fromJson(response.data);
  }
}
