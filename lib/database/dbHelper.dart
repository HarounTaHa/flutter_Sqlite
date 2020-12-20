import 'dart:io';

import 'package:flutterassignment3/model/task.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  DbHelper._();

  static DbHelper dbHelper = DbHelper._();
  Database database;
  static final String tableName = 'tasks';
  static final String taskIdColumn = 'id';
  static final String taskNameColumn = 'name';
  static final String taskIsCompleteColumn = 'isComplete';

  Future<Database> initDatabase() async {
    if (database == null) {
      return await createDatabase();
    } else {
      return database;
    }
  }

  Future<Database> createDatabase() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String path = join(appDocDir.path, 'Tasks.db');
      database = await openDatabase(path, version: 1, onCreate: (db, version) {
        db.execute(
            'create table $tableName($taskIdColumn integer primary key autoincrement,$taskNameColumn text not null,$taskIsCompleteColumn integer)');
      });
      return database;
    } on Exception catch (e) {
      print(e);
    }
  }

  insertNewTask(Task task) async {
    try {
      database = await initDatabase();
      var x = await database.insert(tableName, task.toJason());
      print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh$x");
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Map>> selectAllTasks() async {
    try {
      database = await initDatabase();
      List<Map> result = await database.query(tableName);
      print(result);
      return result;
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<Map> selectSpecificTask(String name) async {
    try {
      database = await initDatabase();
      List<Map> result = await database
          .query(tableName, where: '$taskNameColumn', whereArgs: [name]);
      print(result);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Map>> selectCompletedTasks() async {
    try {
      database = await initDatabase();
      List<Map> result = await database
          .query(tableName, where: '$taskIsCompleteColumn=?', whereArgs: [1]);
      print("rRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR$result");
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Map>> selectInCompletedTasks() async {
    try {
      database = await initDatabase();
      List<Map> result = await database
          .query(tableName, where: '$taskIsCompleteColumn=?', whereArgs: [0]);
    } on Exception catch (e) {
      print(e);
    }
  }

  updateTask(Task task) async {
    try {
      database = await initDatabase();
      int result = await database.update(tableName, task.toJason(),
          where: '$taskNameColumn=?', whereArgs: [task.taskName]);
      print(result);
    } on Exception catch (e) {
      print(e);
    }
  }

  deleteTask(Task task) async {
    try {
      database = await initDatabase();
      int result = await database.delete(tableName,
          where: '$taskNameColumn=?', whereArgs: [task.taskName]);
      print(result);
    } on Exception catch (e) {
      print(e);
    }
  }
}
