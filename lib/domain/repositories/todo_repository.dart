import 'package:todo_app_web/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos();

  Future<Todo> createTodo(String title);

  Future<Todo> updateTodo(Todo todo);

  Future<void> deleteTodo(String id);
}
