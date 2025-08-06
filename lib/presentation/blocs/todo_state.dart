import 'package:equatable/equatable.dart';
import 'package:todo_app_web/domain/entities/todo.dart';

import '../enum/todo_filter.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object?> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;
  final String query;
  final TodoFilter filter;

  const TodoLoaded(this.todos, this.query, this.filter);

  @override
  List<Object?> get props => [todos, query, filter];
}

class TodoError extends TodoState {
  final String message;

  const TodoError(this.message);

  @override
  List<Object?> get props => [message];
}
