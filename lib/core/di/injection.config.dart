// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/datasources/remote/api/todo_api.dart' as _i719;
import '../../data/repositories/todo_repository_impl.dart' as _i538;
import '../../domain/repositories/todo_repository.dart' as _i643;
import '../../domain/usecases/create_todo_usecase.dart' as _i73;
import '../../domain/usecases/delete_todo_usecase.dart' as _i789;
import '../../domain/usecases/get_todos_usecase.dart' as _i713;
import '../../domain/usecases/update_todo_usecase.dart' as _i427;
import '../../module/app_module.dart' as _i207;
import '../../presentation/blocs/todo_cubit.dart' as _i677;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.lazySingleton<_i361.Dio>(() => appModule.dio);
    gh.lazySingleton<_i719.TodoApi>(
      () => appModule.provideTodoApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i643.TodoRepository>(
      () => _i538.TodoRepositoryImpl(gh<_i719.TodoApi>()),
    );
    gh.factory<_i73.CreateTodoUseCase>(
      () => _i73.CreateTodoUseCase(gh<_i643.TodoRepository>()),
    );
    gh.factory<_i789.DeleteTodoUseCase>(
      () => _i789.DeleteTodoUseCase(gh<_i643.TodoRepository>()),
    );
    gh.factory<_i713.GetTodosUseCase>(
      () => _i713.GetTodosUseCase(gh<_i643.TodoRepository>()),
    );
    gh.factory<_i427.UpdateTodoUseCase>(
      () => _i427.UpdateTodoUseCase(gh<_i643.TodoRepository>()),
    );
    gh.factory<_i677.TodoCubit>(
      () => _i677.TodoCubit(
        getTodosUseCase: gh<_i713.GetTodosUseCase>(),
        createTodoUseCase: gh<_i73.CreateTodoUseCase>(),
        updateTodoUseCase: gh<_i427.UpdateTodoUseCase>(),
        deleteTodoUseCase: gh<_i789.DeleteTodoUseCase>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i207.AppModule {}
