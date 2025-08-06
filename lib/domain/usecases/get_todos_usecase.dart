import 'package:todo_app_web/data/models/response/todo_dto.dart';
import 'package:todo_app_web/domain/entities/todo.dart';
import 'package:todo_app_web/domain/repositories/todo_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTodosUseCase {
  final TodoRepository repository;

  GetTodosUseCase(this.repository);

  Future<List<Todo>> call() {
    return repository.getTodos();
  }
}
