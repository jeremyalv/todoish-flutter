import 'package:flutter/material.dart';
import 'package:todoish/constants/colors.dart';
import 'package:todoish/models/tasks.dart';
import 'package:todoish/pages/task_detail.dart';

class TaskRow extends StatelessWidget {
  const TaskRow({
    super.key,
    required this.task,
    required this.onTaskClick,
    required this.onTaskChangeComplete,
    required this.onTaskDelete,
    this.showCaseDetail = false,
    this.showCaseKey,
    this.vpadding = 4,
    this.hpadding = 2,
  });

  // TODO add key params to build()

  final Task task;

  // Handlers
  final Function onTaskClick;
  final Function onTaskChangeComplete;
  final Function onTaskDelete;
  final double vpadding;
  final double hpadding;

  final bool showCaseDetail;
  final GlobalKey<State<StatefulWidget>>? showCaseKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        contentPadding:
            EdgeInsets.symmetric(vertical: vpadding, horizontal: hpadding),
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
              decorationColor: Colors.red,
              decorationThickness: 1.25,
              decoration: task.completed == true
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        trailing: Container(
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
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
    );
  }
}
