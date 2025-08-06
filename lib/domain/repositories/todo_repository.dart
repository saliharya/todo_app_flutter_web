import 'package:todo_app_web/data/models/response/todo_response.dart';
import 'package:todo_app_web/utils/base/base_response.dart';

abstract class TodoRepository {
  Future<BaseResponse<List<TodoResponse>>> getTodos();
  Future<BaseResponse<TodoResponse>> createTodo(TodoResponse todo);
  Future<BaseResponse<TodoResponse>> updateTodo(int id, TodoResponse todo);
  Future<BaseResponse<void>> deleteTodo(int id);
}
