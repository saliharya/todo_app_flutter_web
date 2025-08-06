import 'package:flutter/material.dart';
import 'package:todo_app_web/utils/routes/keys.dart';
import 'package:todo_app_web/utils/routes/routes.dart';

import 'core/di/injection.dart';

void main() {
  getDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: RouteKey.root,
      routes: routes,
    );
  }
}
