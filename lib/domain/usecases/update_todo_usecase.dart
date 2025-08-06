import 'package:todo_app_web/data/models/response/todo_response.dart';
import 'package:todo_app_web/domain/repositories/todo_repository.dart';
import 'package:todo_app_web/utils/base/base_response.dart';

class UpdateTodoUseCase {
  final TodoRepository repository;

  UpdateTodoUseCase(this.repository);

  Future<BaseResponse<TodoResponse>> call(int id, TodoResponse todo) {
    return repository.updateTodo(id, todo);
  }
}
