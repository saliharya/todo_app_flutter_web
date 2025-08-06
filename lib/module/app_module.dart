import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app_web/core/constants/api_constants.dart';
import 'package:todo_app_web/data/datasources/remote/api/todo_api.dart';

@module
abstract class AppModule {
  @lazySingleton
  Dio get dio => Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  @lazySingleton
  TodoApi provideTodoApi(Dio dio) => TodoApi(dio);
}
