import 'package:flutter/material.dart';
import 'package:todo_app_web/utils/routes/keys.dart';
import 'package:todo_app_web/utils/routes/routes.dart';

void main() {
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
