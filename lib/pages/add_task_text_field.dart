// ignore_for_file: prefer_const_constructors, slash_for_doc_comments, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';

class AddTaskTextField extends StatelessWidget {
  const AddTaskTextField({
    super.key,
    required this.focusNewTaskField,
    required this.newTaskNameController,
  });

  final FocusNode focusNewTaskField;
  final TextEditingController newTaskNameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, right: 15, left: 15),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 2,
      ),
      decoration: BoxDecoration(
          color: Colors.grey,
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(0, 0),
              blurRadius: 7,
              spreadRadius: 3,
            )
          ],
          borderRadius: BorderRadius.circular(15)),
      child: TextField(
          focusNode: focusNewTaskField,
          controller: newTaskNameController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Add a new task",
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          )),
    );
  }
}
