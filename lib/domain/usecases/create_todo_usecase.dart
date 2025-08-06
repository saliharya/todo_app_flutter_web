import 'package:todo_app_web/data/models/response/todo_dto.dart';
import 'package:todo_app_web/domain/entities/todo.dart';
import 'package:todo_app_web/domain/repositories/todo_repository.dart';

import 'package:injectable/injectable.dart';

@injectable
class CreateTodoUseCase {
  final TodoRepository repository;

  CreateTodoUseCase(this.repository);

  Future<Todo> call(Todo todo) {
    return repository.createTodo(todo);
  }
}
