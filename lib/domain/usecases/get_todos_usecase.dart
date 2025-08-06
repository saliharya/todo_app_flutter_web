import 'package:todo_app_web/data/models/response/todo_response.dart';
import 'package:todo_app_web/domain/repositories/todo_repository.dart';
import 'package:todo_app_web/utils/base/base_response.dart';

class GetTodosUseCase {
  final TodoRepository repository;

  GetTodosUseCase(this.repository);

  Future<BaseResponse<List<TodoResponse>>> call() {
    return repository.getTodos();
  }
}
