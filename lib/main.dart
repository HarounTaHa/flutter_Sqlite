import 'package:flutter/material.dart';
import 'package:flutterassignment3/provider/app_provider.dart';
import 'package:flutterassignment3/toDoTasks.dart';
import 'package:flutterassignment3/widget/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
      create: (_)=>AppProvider(),
      child: MaterialApp(
        title: 'Todo App',
        home: Splash(),
      ),
    );
  }
}
