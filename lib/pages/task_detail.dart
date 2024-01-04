// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todoish/models/tasks.dart';

class TaskDetail extends StatelessWidget {
  const TaskDetail({super.key, required this.task, required this.completed});

  final Task task;
  final bool completed;

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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Task #${task.id}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                completed
                    ? Text("Completed", style: TextStyle(color: Colors.green))
                    : Text("Not Completed",
                        style: TextStyle(color: Colors.red)),
                Text(
                  "${task.todo}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
