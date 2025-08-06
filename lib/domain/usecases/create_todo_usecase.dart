import 'package:todo_app_web/data/models/response/todo_response.dart';
import 'package:todo_app_web/domain/repositories/todo_repository.dart';
import 'package:todo_app_web/utils/base/base_response.dart';

class CreateTodoUseCase {
  final TodoRepository repository;

  CreateTodoUseCase(this.repository);

  Future<BaseResponse<TodoResponse>> call(TodoResponse todo) {
    return repository.createTodo(todo);
  }
}
