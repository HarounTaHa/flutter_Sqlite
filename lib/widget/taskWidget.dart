import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterassignment3/model/task.dart';
import 'package:flutterassignment3/provider/app_provider.dart';
import 'package:provider/provider.dart';

class TaskWidget extends StatefulWidget {
  Task task;

  TaskWidget(this.task);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  AppProvider appProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appProvider = Provider.of(context, listen: false);
  }

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
                  appProvider.updateTask(widget.task);
                }),
            Text(widget.task.taskName),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  child: AlertDialog(
                    title: Text('Are you sure?'),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          appProvider.deleteTask(widget.task);
                        },
                        child: Text('Confirm'),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
