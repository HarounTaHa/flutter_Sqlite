import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterassignment3/database/dbHelper.dart';
import 'package:flutterassignment3/provider/app_provider.dart';
import 'package:provider/provider.dart';

import 'model/task.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  AppProvider appProvider;
  String nameTask;
  bool isComplete=false;
  GlobalKey<FormState> key = GlobalKey();


  saveForm() {
    if (key.currentState.validate()) {
        key.currentState.save();
      appProvider.addTask(Task(taskName:nameTask,isCompleted: isComplete));
      Navigator.pop(context);
    } else {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Empty")));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appProvider = Provider.of(context,listen: false);
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
