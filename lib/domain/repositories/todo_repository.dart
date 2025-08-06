import 'package:todo_app_web/data/models/response/todo_dto.dart';
import 'package:todo_app_web/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos();

  Future<Todo> createTodo(Todo todo);

  Future<Todo> updateTodo(Todo todo);

  Future<void> deleteTodo(String id);
}
