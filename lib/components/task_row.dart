// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:todoish/models/tasks.dart';
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
    required this.showcaseComplete,
    required this.showcaseDelete,
    required this.showcaseViewDetail,
    this.showCaseKey,
  });

  // Params
  final Task task;
  final double vpadding;
  final double hpadding;

  final GlobalKey<State<StatefulWidget>>? showCaseKey;
  final bool showcaseComplete;
  final bool showcaseDelete;
  final bool showcaseViewDetail;

  // Handlers
  final Function onTaskClick;
  final Function onTaskChangeComplete;
  final Function onTaskDelete;

  @override
  Widget build(BuildContext context) {
    // Checkbox Variations
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

    // Delete Button Variations
    Widget regularDeleteButton = Container(
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
    );

    Widget onboardingDeleteButton = Showcase(
      key: showCaseKey ?? GlobalKey(),
      targetShapeBorder: const CircleBorder(),
      targetBorderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      title: "Delete Task",
      description: "Tap and delete a task",
      child: regularDeleteButton,
    );

    return TaskRowTile(
        vpadding: vpadding,
        hpadding: hpadding,
        showcaseComplete: showcaseComplete,
        onboardingCheckboxButton: onboardingCheckboxButton,
        regularCheckboxButton: regularCheckboxButton,
        onTaskClick: onTaskClick,
        task: task,
        showcaseDelete: showcaseDelete,
        onboardingDeleteButton: onboardingDeleteButton,
        regularDeleteButton: regularDeleteButton);
  }
}

class TaskRowTile extends StatelessWidget {
  const TaskRowTile({
    super.key,
    required this.vpadding,
    required this.hpadding,
    required this.showcaseComplete,
    required this.onboardingCheckboxButton,
    required this.regularCheckboxButton,
    required this.onTaskClick,
    required this.task,
    required this.showcaseDelete,
    required this.onboardingDeleteButton,
    required this.regularDeleteButton,
  });

  final double vpadding;
  final double hpadding;
  final bool showcaseComplete;
  final Widget onboardingCheckboxButton;
  final Widget regularCheckboxButton;
  final Function onTaskClick;
  final Task task;
  final bool showcaseDelete;
  final Widget onboardingDeleteButton;
  final Widget regularDeleteButton;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          EdgeInsets.symmetric(vertical: vpadding, horizontal: hpadding),
      // If showCaseDetail, activate onboarding step #1
      leading:
          showcaseComplete ? onboardingCheckboxButton : regularCheckboxButton,
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
      trailing: showcaseDelete ? onboardingDeleteButton : regularDeleteButton,
    );
  }
}
