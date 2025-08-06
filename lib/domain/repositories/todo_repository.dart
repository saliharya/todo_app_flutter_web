import 'package:todo_app_web/data/models/response/todo_response.dart';

abstract class TodoRepository {
  Future<List<TodoResponse>> getTodos();

  Future<TodoResponse> createTodo(TodoResponse todo);

  Future<TodoResponse> updateTodo(String id, TodoResponse todo);

  Future<void> deleteTodo(String id);
}
