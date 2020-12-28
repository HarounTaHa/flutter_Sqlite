

import 'package:flutter/material.dart';
import 'package:flutterassignment3/database/dbHelper.dart';
import 'package:flutterassignment3/model/task.dart';
import 'package:flutterassignment3/provider/app_provider.dart';
import 'package:flutterassignment3/toDoTasks.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  AppProvider appProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  void initData()async{
    await DbHelper.dbHelper.initDatabase();
    appProvider = Provider.of<AppProvider>(context,listen: false);
    List<Map> allTasksResult =await DbHelper.dbHelper.selectAllTasks();
    List<Map> completedTasksResult =await DbHelper.dbHelper.selectCompletedTasks();
    List<Map> inCompletedTasksResult =await DbHelper.dbHelper.selectInCompletedTasks();
    appProvider.allTasks = allTasksResult.map((e) => Task.fromJson(e)).toList();
    appProvider.completedTasks = completedTasksResult.map((e) => Task.fromJson(e)).toList();
    appProvider.inCompletedTasks = inCompletedTasksResult.map((e) => Task.fromJson(e)).toList();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>ToDoTasks()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Hero',style: TextStyle(
            fontSize: 30,
          ),),
        ),
      ),
    );
  }
}
