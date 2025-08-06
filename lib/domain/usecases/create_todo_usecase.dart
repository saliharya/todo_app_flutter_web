import 'package:todo_app_web/data/models/response/todo_response.dart';
import 'package:todo_app_web/domain/repositories/todo_repository.dart';

import 'package:injectable/injectable.dart';

@injectable
class CreateTodoUseCase {
  final TodoRepository repository;

  CreateTodoUseCase(this.repository);

  Future<TodoResponse> call(TodoResponse todo) {
    return repository.createTodo(todo);
  }
}
