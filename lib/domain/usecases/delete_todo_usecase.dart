import 'package:injectable/injectable.dart';
import 'package:todo_app_web/domain/repositories/todo_repository.dart';

@injectable
class DeleteTodoUseCase {
  final TodoRepository repository;

  DeleteTodoUseCase(this.repository);

  Future<void> call(String id) async {
    return await repository.deleteTodo(id);
  }
}
