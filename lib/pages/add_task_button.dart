// ignore_for_file: prefer_const_constructors, slash_for_doc_comments, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';

class AddTaskbutton extends StatelessWidget {
  const AddTaskbutton({
    super.key,
    required this.addTaskItem,
    required this.newTaskNameController,
  });

  final Function addTaskItem;
  final TextEditingController newTaskNameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, right: 15),
      child: ElevatedButton(
        onPressed: () {
          addTaskItem(newTaskNameController.text);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          minimumSize: Size(60, 60),
          elevation: 10,
        ),
        child: Text(
          '+',
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
