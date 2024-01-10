// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todoish/components/task_row.dart';
import 'package:todoish/models/tasks.dart';

class CompletedTasks extends StatelessWidget {
  CompletedTasks(
      {super.key,
      required this.completedTasks,
      required this.onTaskClick,
      required this.onTaskChangeComplete,
      required this.onTaskDelete});

  late List<Task> completedTasks;
  final Function onTaskClick;
  final Function onTaskChangeComplete;
  final Function onTaskDelete;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0x80808080),
        appBar: AppBar(
          backgroundColor: Color(0x80808080),
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left_rounded,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return TaskRow(
                      task: completedTasks[index],
                      showcaseComplete: false,
                      showcaseDelete: false,
                      onTaskClick: onTaskClick,
                      onTaskChangeComplete: onTaskChangeComplete,
                      onTaskDelete: onTaskDelete);
                },
                separatorBuilder: ((_, __) => Divider(
                      thickness: .5,
                    )),
                itemCount: (completedTasks.length)),
          ),
        ),
      ),
    );
  }
}
