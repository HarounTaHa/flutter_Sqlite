import 'package:flutter/material.dart';
import 'package:flutterassignment3/provider/app_provider.dart';
import 'package:flutterassignment3/widget/taskWidget.dart';
import 'package:provider/provider.dart';

import 'addTask.dart';
import 'database/dbHelper.dart';
import 'model/task.dart';

class ToDoTasks extends StatefulWidget {
  @override
  _ToDoTasksState createState() => _ToDoTasksState();
}

class _ToDoTasksState extends State<ToDoTasks> with TickerProviderStateMixin {
  TabController tabController;
  AppProvider appProvider;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    appProvider = Provider.of<AppProvider>(context,listen: false);
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
  AppProvider appProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appProvider =  Provider.of<AppProvider>(context,listen: false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child:
      Consumer<AppProvider>(
        builder: (context,value,child){
          print('rebuiild');
          return Container(
          child: ListView.builder(
              itemCount: value.allTasks.length,
              itemBuilder: (context, i) {
                return TaskWidget(value.allTasks[i]);
              }),
        );
        },
      ),
    );
  }
}

//------------------------------------------------------------------------------
class CompleteTask extends StatefulWidget {
  @override
  _CompleteTaskState createState() => _CompleteTaskState();
}

class _CompleteTaskState extends State<CompleteTask> {

  AppProvider appProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appProvider =  Provider.of<AppProvider>(context,listen: false);
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<AppProvider>(
      builder: (context,value,child)=> Container(
        child: ListView.builder(
            itemCount: value.completedTasks.length,
            itemBuilder: (context, i) {
              return TaskWidget(value.completedTasks[i]);
            }),
      ),
    );
  }
}

//-----------------------------------------------------------------------------------------
class InCompleteTask extends StatefulWidget {
  @override
  _InCompleteTaskState createState() => _InCompleteTaskState();
}

class _InCompleteTaskState extends State<InCompleteTask> {

  AppProvider appProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appProvider =  Provider.of<AppProvider>(context,listen: false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<AppProvider>(
      builder: (context,value,child)=> Container(
        child: ListView.builder(
            itemCount: value.inCompletedTasks.length,
            itemBuilder: (context, i) {
              return TaskWidget(value.inCompletedTasks[i]);
            }),
      ),
    );
  }
}

