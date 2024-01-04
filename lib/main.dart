// ignore_for_file: prefer_const_constructors, slash_for_doc_comments, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:todoish/tasks.dart';
import 'package:todoish/tasks_fetch.dart';
import 'package:todoish/task_detail.dart';
import 'package:todoish/completed_tasks.dart';

/** NOTE on next steps 
 * Render task details when tile is clicked
 * See list of completed tasks on another page (use navigation)
 */

void main() {
  runApp(const TodoishApp());
}

class TodoishApp extends StatelessWidget {
  const TodoishApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todoish",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<int, bool> completedTasks = {};
  late Future<List<Task>> futureTasks;

  @override
  void initState() {
    super.initState();
    futureTasks = fetchTasks();
  }

  Future<List<Task>> getCompletedTasks() async {
    // We know for sure that futureTasks have rendered
    List<Task> tasks = await fetchTasks();
    return tasks.where((task) => completedTasks[task.id] == true).toList();
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
            backgroundColor: Color(0x80808080),
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
                              completedTasks: getCompletedTasks(),
                            )),
                  );
                },
              ),
            ],
          ),
          body: FutureBuilder(
              future: futureTasks,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var tasks = snapshot.data!;

                  return ListView.separated(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      // Todo Tile
                      return taskTile(context, tasks, index);
                    },
                    separatorBuilder: ((_, __) => const Divider(
                          thickness: .5,
                        )),
                  );
                }
                if (snapshot.hasError) {
                  return Text(
                    "Oops, an error happened: ${snapshot.error}",
                  );
                }

                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text(
                          "Loading tasks...",
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                );
              })),
    );
  }

  /* COMPONENTS */

  GestureDetector taskTile(BuildContext context, List<Task> tasks, int index) {
    return GestureDetector(
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskDetail(
                    task: tasks[index],
                    completed: completedTasks[tasks[index].id] == true),
              ));
        },
        leading: Transform.scale(
          scale: 1.35,
          child: Checkbox(
              shape: CircleBorder(),
              side: BorderSide(color: Colors.grey),
              value: completedTasks[tasks[index].id] == true,
              onChanged: (value) {
                setState(() {
                  completedTasks[tasks[index].id] = value!;
                });
              }),
        ),
        title: Text(
          tasks[index].todo,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
