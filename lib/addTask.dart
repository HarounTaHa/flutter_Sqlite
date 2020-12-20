import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterassignment3/database/dbHelper.dart';

import 'model/task.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String nameTask;
  bool isComplete=false;
  GlobalKey<FormState> key = GlobalKey();

  saveForm() {
    if (key.currentState.validate()) {
        key.currentState.save();
        DbHelper.dbHelper.insertNewTask(new Task(taskName: nameTask,isCompleted: isComplete));
    } else {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Empty")));
    }
  }
  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: key,
                child: TextFormField(
                  onSaved: (newValue) {
                    this.nameTask = newValue;
                  },
                  validator: (value) {
                    if (value == null || value == "") {
                      return 'required field';
                    } else {
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'New Task'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Text(
                      "Add Task",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      saveForm();
                      print("zzzzzzzzzzzzzzzzz");
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
