import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_web/utils/routes/keys.dart';

import '../../core/di/injection.dart';
import '../../presentation/blocs/todo_cubit.dart';
import '../../presentation/pages/todo_list_page.dart';

final routes = <String, WidgetBuilder>{
  RouteKey.root: (context) => BlocProvider(
    create: (_) => getIt<TodoCubit>()..fetchTodos(),
    child: const TodoListPage(),
  ),
};
