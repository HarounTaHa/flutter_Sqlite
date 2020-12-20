import 'package:flutter/material.dart';
import 'package:flutterassignment3/toDoTasks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Todo App',
      home: ToDoTasks(),
    );
  }
}
