import 'package:flutter/material.dart';
import 'package:simple_todo/src/tasks/presentation/tasks_list_screen.dart';
import 'package:simple_todo/src/tasks/presentation/tasks_create_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/tasks': (context) => const TaskListScreen(),
        '/tasks/create': (context) => const TaskCreateScreen()
      },
      initialRoute: '/tasks',
    );
  }
}
