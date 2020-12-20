import 'package:flutter/material.dart';
import 'package:flutterassignment3/widget/taskWidget.dart';

import 'addTask.dart';
import 'database/dbHelper.dart';
import 'model/task.dart';

class ToDoTasks extends StatefulWidget {
  @override
  _ToDoTasksState createState() => _ToDoTasksState();
}

class _ToDoTasksState extends State<ToDoTasks> with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTask()));
        },
      ),
      appBar: AppBar(
        title: Text("To Do"),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              text: 'All Tasks',
            ),
            Tab(
              text: 'Complete Tasks',
            ),
            Tab(
              text: 'InComplete Tasks',
            ),
          ],
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          AllTask(),
          CompleteTask(),
          InCompleteTask(),
        ],
      ),
    );
  }
}

class AllTask extends StatefulWidget {
  _AllTaskState createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  int length;

  Future getData() async {
    List<Map> result = await DbHelper.dbHelper.selectAllTasks();
    print("ssssssssssssssssssssssssssssssssss$result");
    length = result.map((e) => Task.fromJson(e)).toList().length;
    print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk$length");
    return result.map((e) => Task.fromJson(e)).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: length,
                itemBuilder: (context, i) {
                  return TaskWidget(snapshot.data[i]);
                },
              );
            }
            return Scaffold(
              body: Container(
                child: Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

//------------------------------------------------------------------------------
class CompleteTask extends StatefulWidget {
  @override
  _CompleteTaskState createState() => _CompleteTaskState();
}

class _CompleteTaskState extends State<CompleteTask> {
  int length;
  List<Map> result;

  Future getDataComplete() async {
    List<Map> result = await DbHelper.dbHelper.selectCompletedTasks();
    print("ssssssssssssssssssssssssssssssssss$result");
    length = result.map((e) => Task.fromJson(e)).toList().length;
    print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk$length");
    return result.map((e) => Task.fromJson(e)).toList();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: FutureBuilder(
          future: getDataComplete(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: length,
                itemBuilder: (context, i) {
                  return TaskWidget(snapshot.data[i]);
                },
              );
            }
            return Scaffold(
              body: Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

//-----------------------------------------------------------------------------------------
class InCompleteTask extends StatefulWidget {
  @override
  _InCompleteTaskState createState() => _InCompleteTaskState();
}

class _InCompleteTaskState extends State<InCompleteTask> {
  List<Task> taskList;
  Task task;
  int length;

  Future getDataInComplete() async {
    List<Map> result = await DbHelper.dbHelper.selectInCompletedTasks();
    print("ssssssssssssssssssssssssssssssssss$result");
    length = result.map((e) => Task.fromJson(e)).toList().length;
    print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk$length");
    return result.map((e) => Task.fromJson(e)).toList();
  }

  init() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: FutureBuilder(
          future: getDataInComplete(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: length,
                itemBuilder: (context, i) {
                  return TaskWidget(snapshot.data[i]);
                },
              );
            }
            return Scaffold(
              body: Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

