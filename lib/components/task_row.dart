import 'package:flutter/material.dart';
import 'package:todoish/constants/colors.dart';
import 'package:todoish/models/tasks.dart';
import 'package:todoish/pages/task_detail.dart';

class TaskRow extends StatelessWidget {
  const TaskRow(
      {super.key,
      required this.task,
      required this.onTaskClick,
      required this.onTaskChangeComplete,
      required this.onTaskDelete});

  final Task task;

  // Handlers
  final onTaskClick;
  final onTaskChangeComplete;
  final onTaskDelete;

  @override
  Widget build(BuildContext context) {
    // TODO - add event handlers and connect with this component.
    return Container(
      child: GestureDetector(
        child: ListTile(
          onTap: () {
            onTaskClick(context, task);
          },
          leading: Transform.scale(
            scale: 1.35,
            child: Checkbox(
                shape: CircleBorder(),
                side: BorderSide(color: Colors.grey),
                checkColor: Theme.of(context).primaryColor,
                value: task.completed,
                onChanged: (checkValue) {
                  onTaskChangeComplete(task);
                }),
          ),
          title: Text(
            task.todo,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          trailing: Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.symmetric(vertical: 12),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5)),
            child: IconButton(
              icon: Icon(Icons.delete),
              iconSize: 18,
              color: Colors.white,
              onPressed: () {
                onTaskDelete(task.id);
              },
            ),
          ),
        ),
      ),
    );
  }
}
