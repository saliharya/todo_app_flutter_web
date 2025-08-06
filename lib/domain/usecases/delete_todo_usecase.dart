import 'package:todo_app_web/domain/repositories/todo_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteTodoUseCase {
  final TodoRepository repository;

  DeleteTodoUseCase(this.repository);

  Future<void> call(int id) {
    return repository.deleteTodo(id);
  }
}
