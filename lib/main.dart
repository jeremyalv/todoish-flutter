// ignore_for_file: prefer_const_constructors, slash_for_doc_comments, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:todoish/pages/home_page.dart';

import 'package:todoish/models/tasks.dart';
import 'package:todoish/api/tasks_fetch.dart';
import 'package:todoish/pages/task_detail.dart';
import 'package:todoish/pages/completed_tasks.dart';
import 'package:todoish/components/task_row.dart';
import 'package:todoish/constants/colors.dart';

void main() {
  runApp(const TodoishApp());
}

class TodoishApp extends StatelessWidget {
  const TodoishApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todoish",
      theme: ThemeData(useMaterial3: true, primaryColor: Colors.red),
      home: HomePage(),
    );
  }
}
