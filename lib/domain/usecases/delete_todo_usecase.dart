import 'package:todo_app_web/domain/repositories/todo_repository.dart';
import 'package:todo_app_web/utils/base/base_response.dart';

class DeleteTodoUseCase {
  final TodoRepository repository;

  DeleteTodoUseCase(this.repository);

  Future<BaseResponse<void>> call(int id) {
    return repository.deleteTodo(id);
  }
}
