// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:todoish/tasks.dart';
import 'package:todoish/tasks_fetch.dart';

void main() {
  runApp(const TodoishApp());
}

class TodoishApp extends StatelessWidget {
  const TodoishApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  late final Future<List<Task>> futureTasks;

  @override
  void initState() {
    super.initState();
    futureTasks = fetchTasks();
    // futureTasks.then((arr) => arr.map((task) => task.completed
    //     ? completedTasks[task.id] = true
    //     : completedTasks[task.id] = false));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0x80808080),
          appBar: AppBar(
            backgroundColor: Color(0x80808080),
            title: Text(
              "Todoish",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          body: FutureBuilder(
              future: futureTasks,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var tasks = snapshot.data!;

                  return ListView.separated(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: Checkbox(
                          value: completedTasks[tasks[index].id] == true,
                          onChanged: (value) {
                            setState(() {
                              completedTasks[tasks[index].id] = value!;
                            });
                          }),
                      title: Text(
                        tasks[index].todo,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
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

                return const CircularProgressIndicator();
              })),
    );
  }
}
