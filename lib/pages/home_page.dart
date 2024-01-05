// ignore_for_file: prefer_const_constructors, slash_for_doc_comments, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:todoish/main.dart';

import 'package:todoish/models/tasks.dart';
import 'package:todoish/api/tasks_fetch.dart';
import 'package:todoish/pages/task_detail.dart';
import 'package:todoish/pages/completed_tasks.dart';
import 'package:todoish/components/task_row.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<int, bool> completedTasks = {};
  // late Future<List<Task>> futureTasks;
  final List<Task> tasks = Task.getDummyTasks();

  final _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // futureTasks = fetchTasks();
  }

  List<Task> getCompletedtasks() {
    return tasks.where((task) => task.completed == true).toList();
  }

  // Future<List<Task>> getCompletedTasks() async {
  //   // We know for sure that futureTasks have rendered
  //   List<Task> tasks = await fetchTasks();
  //   return tasks.where((task) => completedTasks[task.id] == true).toList();
  // }

  void _addTaskItem(int id, String todo, bool completed, int userId) {
    setState(() {
      tasks.add(Task(
        id: id,
        todo: todo,
        completed: completed,
        userId: userId,
      ));
    });

    _taskController.clear();
  }

  void _onTaskClick(BuildContext context, Task task) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => TaskDetail(
            task: task,
            completed: task.completed,
          ),
        ));
  }

  void _onTaskChangeComplete(Task task) {
    setState(() {
      task.completed = !task.completed;
    });
  }

  void _onTaskDelete(int taskId) {
    setState(() {
      tasks.removeWhere((item) => item.id == taskId);
    });
  }

  @override
  Widget build(BuildContext context) {
    // List<Task> getCompletedTasks() {
    //   // We know for sure that futureTasks have rendered
    //   futureTasks = fetchTasks();
    //   futureTasks.then((tasks) {
    //     List<Task> res =
    //         tasks.where((task) => completedTasks[task.id] == true).toList();

    //     print("RES: $res");
    //     print(res.length > 0 ? res[0].todo : "none");
    //     return res;
    //   });

    //   return [];
    // }

    print("COMPLETED TASKS $completedTasks");

    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0x80808080),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            titleSpacing: 0,
            leading: Icon(
              Icons.now_widgets_rounded,
              color: Colors.white,
            ),
            title: Text(
              "Todoish",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.archive,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => CompletedTasks(
                              key: UniqueKey(),
                              completedTasks: getCompletedtasks(),
                              onTaskClick: _onTaskClick,
                              onTaskChangeComplete: _onTaskChangeComplete,
                              onTaskDelete: _onTaskDelete,
                            )),
                  );
                },
              ),
            ],
          ),
          body: ListView.separated(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetail(
                            task: tasks[index],
                            completed: completedTasks[tasks[index].id] == true),
                      ));
                },
                child: TaskRow(
                  vpadding: 8,
                  hpadding: 12,
                  task: tasks[index],
                  onTaskClick: _onTaskClick,
                  onTaskChangeComplete: _onTaskChangeComplete,
                  onTaskDelete: _onTaskDelete,
                ),
              );

              // return GestureDetector(
              //     child: taskTile(context, tasks, index));
            },
            separatorBuilder: ((_, __) => Divider(
                  thickness: .5,
                  height: 2,
                  color: Colors.black,
                )),
          )),
    );
  }

  FutureBuilder<Object?> _futureTasksBuilder(Future<List<Task>> futureTasks) {
    return FutureBuilder(
        future: futureTasks,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Task> tasks = snapshot.data as List<Task>;

            return ListView.separated(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetail(
                              task: tasks[index],
                              completed:
                                  completedTasks[tasks[index].id] == true),
                        ));
                  },
                  child: TaskRow(
                    task: tasks[index],
                    onTaskClick: _onTaskClick,
                    onTaskChangeComplete: _onTaskChangeComplete,
                    onTaskDelete: _onTaskDelete,
                  ),
                );

                // return GestureDetector(
                //     child: taskTile(context, tasks, index));
              },
              separatorBuilder: ((_, __) => Divider(
                    thickness: .5,
                    height: 20,
                    color: Colors.black,
                  )),
            );
          }
          if (snapshot.hasError) {
            return Text(
              "Oops, an error happened: ${snapshot.error}",
            );
          }

          return Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text(
                "Loading tasks...",
                style: TextStyle(color: Colors.white),
              ),
            ]),
          );
        });
  }

  /* COMPONENTS */

  // ListTile taskTile(BuildContext context, List<Task> tasks, int index) {
  //   return ListTile(
  //     onTap: () {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => TaskDetail(
  //                 task: tasks[index],
  //                 completed: completedTasks[tasks[index].id] == true),
  //           ));
  //     },
  //     leading: Transform.scale(
  //       scale: 1.35,
  //       child: Checkbox(
  //           shape: CircleBorder(),
  //           side: BorderSide(color: Colors.grey),
  //           value: completedTasks[tasks[index].id] == true,
  //           onChanged: (value) {
  //             setState(() {
  //               completedTasks[tasks[index].id] = value!;
  //             });
  //           }),
  //     ),
  //     title: Text(
  //       tasks[index].todo,
  //       style: TextStyle(
  //         color: Colors.white,
  //       ),
  //     ),
  //   );
  // }
}
