// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:todoish/constants/colors.dart';
import 'package:todoish/models/tasks.dart';
import 'package:todoish/pages/task_detail.dart';
import 'package:showcaseview/showcaseview.dart';

class TaskRow extends StatelessWidget {
  const TaskRow({
    super.key,
    this.vpadding = 4,
    this.hpadding = 2,
    required this.task,
    required this.onTaskClick,
    required this.onTaskChangeComplete,
    required this.onTaskDelete,
    this.showCaseDetail = false,
    this.showCaseKey = null,
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
    Widget regularCheckboxButton = Transform.scale(
      scale: 1.35,
      child: Checkbox(
          shape: const CircleBorder(),
          side: const BorderSide(color: Colors.grey),
          checkColor: Theme.of(context).primaryColor,
          value: task.completed,
          onChanged: (checkValue) {
            onTaskChangeComplete(task);
          }),
    );

    Widget onboardingCheckboxButton = Showcase.withWidget(
      // Provide default value for key if showCaseKey not provided
      key: showCaseKey ?? GlobalKey(),
      height: 50,
      width: 50,
      targetShapeBorder: const CircleBorder(),
      targetBorderRadius: const BorderRadius.all(
        Radius.circular(50),
      ),
      tooltipPosition: TooltipPosition.bottom,
      container: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Tap to complete a Task",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      // The widget which will be showcased:
      child: regularCheckboxButton,
    );

    return ListTile(
      contentPadding:
          EdgeInsets.symmetric(vertical: vpadding, horizontal: hpadding),
      // If showCaseDetail, activate onboarding step #1
      leading:
          showCaseDetail ? onboardingCheckboxButton : regularCheckboxButton,
      // Onboarding: When title is clicked, dispose onboarding on tap
      title: GestureDetector(
        onTap: () {
          onTaskClick(context, task);
        },
        child: Text(
          task.todo,
          style: TextStyle(
              color: Colors.white,
              decorationColor: Colors.red,
              decorationThickness: 1.25,
              decoration: task.completed == true
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
      ),
      trailing: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
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
    );
  }
}
