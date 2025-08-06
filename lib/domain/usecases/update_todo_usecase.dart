import 'package:injectable/injectable.dart';
import 'package:todo_app_web/domain/entities/todo.dart';
import 'package:todo_app_web/domain/repositories/todo_repository.dart';

@injectable
class UpdateTodoUseCase {
  final TodoRepository repository;

  UpdateTodoUseCase(this.repository);

  Future<Todo> call(Todo todo) {
    return repository.updateTodo(todo);
  }
}
