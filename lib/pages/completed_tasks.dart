// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:todoish/models/tasks.dart';

class CompletedTasks extends StatelessWidget {
  CompletedTasks({super.key, required this.completedTasks});

  // final Future<List<Task>> completedTasks;
  late Future<List<Task>> completedTasks;

  @override
  Widget build(BuildContext context) {
    print("COMPLETED TASKS $completedTasks");
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Text(
                "Completed Tasks",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              SizedBox(height: 12),
              // ...completedTasks.map((task) => Text(task.todo)),

              FutureBuilder(
                  future: completedTasks,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var tasks = snapshot.data!;

                      return Expanded(
                        child: ListView.separated(
                          itemCount: tasks.length,
                          separatorBuilder: ((_, __) => const Divider(
                                thickness: .5,
                              )),
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Text(
                                "ID: ${tasks[index].id}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                              title: Text(
                                tasks[index].todo,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Text(
                        "Error: ${snapshot.error}",
                        style: TextStyle(color: Colors.red),
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
                  })
            ],
          ),
        ),
      ),
    ));
  }
}
