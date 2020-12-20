import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterassignment3/database/dbHelper.dart';
import 'package:flutterassignment3/model/task.dart';
import 'package:flutterassignment3/toDoTasks.dart';


class TaskWidget extends StatefulWidget  {
  Task task;
  Function function;

  TaskWidget(this.task, [this.function]);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Checkbox(
                value: widget.task.isCompleted,
                onChanged: (value) {
                  this.widget.task.isCompleted = !this.widget.task.isCompleted;
                  setState(() {});
                  DbHelper.dbHelper.updateTask(widget.task);
                  widget.function();

                }),
            Text(widget.task.taskName),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                DbHelper.dbHelper.deleteTask(widget.task);
                setState(() {});
                widget.function();
              },
            ),
          ],
        ),
      ),
    );
  }
}
