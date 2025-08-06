import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';

class TodoApi {
  final Dio _dio;

  TodoApi(this._dio);

  Future<Response> getTodos() async {
    return await _dio.get(ApiConstants.todosEndpoint);
  }

  Future<Response> createTodo(Map<String, dynamic> data) async {
    return await _dio.post(ApiConstants.todosEndpoint, data: data);
  }

  Future<Response> updateTodo(int id, Map<String, dynamic> data) async {
    final url = '${ApiConstants.todosEndpoint}/$id';
    return await _dio.put(url, data: data);
  }

  Future<Response> deleteTodo(int id) async {
    final url = '${ApiConstants.todosEndpoint}/$id';
    return await _dio.delete(url);
  }
}
