import 'package:flutterassignment3/database/dbHelper.dart';

class Task {
  String taskName;
  bool isCompleted;

  Task({this.taskName, this.isCompleted});

  factory Task.fromJson(Map<String, dynamic> json) => Task(
      taskName: json[DbHelper.taskNameColumn],
      isCompleted: json[DbHelper.taskIsCompleteColumn] == 1 ? true : false
   );

  toJason() {
    return {
      DbHelper.taskNameColumn: this.taskName,
      DbHelper.taskIsCompleteColumn: this.isCompleted ? 1 : 0
    };
  }
}
