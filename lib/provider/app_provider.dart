import 'package:flutter/cupertino.dart';
import 'package:flutterassignment3/database/dbHelper.dart';
import 'package:flutterassignment3/model/task.dart';

class AppProvider with ChangeNotifier{

  List<Task> allTasks = [];
  List<Task> completedTasks = [];
  List<Task> inCompletedTasks = [];


  void updateTask(Task task){
    int index = allTasks.indexWhere((element) => task.taskName==element.taskName);
    allTasks[index] = task;
    print(allTasks.length);
    print(completedTasks.length);
    print(inCompletedTasks.length);
    if(task.isCompleted) {
      print("complete");
      print(task.isCompleted);
      completedTasks.add(task);
      print(inCompletedTasks.length);
      inCompletedTasks.removeWhere((element) => element.taskName == task.taskName);
    }else{
      print("incomplete");
      print(task.isCompleted);
      inCompletedTasks.add(task);
      print(completedTasks.length);
      completedTasks.removeWhere((element) => element.taskName == task.taskName);
      print(completedTasks.length);
    }
    print('hahaha');
    notifyListeners();
    DbHelper.dbHelper.updateTask(task);
  }

  void deleteTask(Task task){
    allTasks.removeWhere((element) => element.taskName == task.taskName);
    completedTasks.removeWhere((element) => element.taskName == task.taskName);
    inCompletedTasks.removeWhere((element) => element.taskName == task.taskName);
    notifyListeners();
    DbHelper.dbHelper.deleteTask(task);
  }

  void addTask(Task task){
    allTasks.add(task);
    inCompletedTasks.add(task);
    notifyListeners();
    DbHelper.dbHelper.insertNewTask(new Task(taskName: task.taskName,isCompleted: task.isCompleted));
  }

}