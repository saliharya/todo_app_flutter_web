import 'package:todo_app_web/data/models/response/todo_response.dart';
import 'package:todo_app_web/domain/repositories/todo_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateTodoUseCase {
  final TodoRepository repository;

  UpdateTodoUseCase(this.repository);

  Future<TodoResponse> call(String id, TodoResponse todo) {
    return repository.updateTodo(id, todo);
  }
}
