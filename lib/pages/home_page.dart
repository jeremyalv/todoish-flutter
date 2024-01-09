// ignore_for_file: prefer_const_constructors, slash_for_doc_comments, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import 'package:todoish/models/tasks.dart';
import 'package:todoish/api/tasks_fetch.dart';
import 'package:todoish/pages/task_detail.dart';
import 'package:todoish/pages/completed_tasks.dart';
import 'package:todoish/components/task_row.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<int, bool> completedTasks = {};

  List<Task> tasks = Task.getDummyTasks();
  List<Task> _foundTasks = [];

  final _taskController = TextEditingController();

  // Onboarding: ShowCase section keys
  final GlobalKey _one_MarkCompleteSection = GlobalKey();
  final GlobalKey _two_DeleteTaskSection = GlobalKey();
  final GlobalKey _three_SearchTaskSection = GlobalKey();
  final GlobalKey _four_TypeNewTaskSection = GlobalKey();
  final GlobalKey _five_ClickAddTaskSection = GlobalKey();
  final GlobalKey _six_ViewTaskDetailsSection = GlobalKey();
  final GlobalKey _seven_ViewCompletedTasksSection = GlobalKey();

  List<GlobalKey> showcaseKeys = [];

  final scrollController = ScrollController();

  // WIDGET LIFECYCLE METHODS

  @override
  void initState() {
    _foundTasks = tasks;

    // At construct time, fill showcaseKeys
    showcaseKeys = [
      _one_MarkCompleteSection,
      _two_DeleteTaskSection,
      _three_SearchTaskSection,
      _four_TypeNewTaskSection,
      _five_ClickAddTaskSection,
      _six_ViewTaskDetailsSection,
      _seven_ViewCompletedTasksSection,
    ];

    // Pass in Start onboarding an
    _startOnboarding(context, showcaseKeys);

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  // WIDGET HELPER METHODS
  void _startOnboarding(BuildContext context,
      List<GlobalKey<State<StatefulWidget>>> showcaseKeys) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      return ShowCaseWidget.of(context).startShowCase(showcaseKeys);
    });
  }

  List<Task> getCompletedtasks() {
    return tasks.where((task) => task.completed == true).toList();
  }

  void _addTaskItem(String todo) {
    setState(() {
      Task newTask = Task(
        id: tasks[tasks.length - 1].id + 1,
        todo: todo,
        completed: false,
        userId: 1,
      );

      tasks.insert(0, newTask);
    });

    _taskController.clear();
  }

  void _onTaskClick(BuildContext context, Task task) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => TaskDetail(
            task: task,
            completed: task.completed,
          ),
        ));
  }

  void _onTaskChangeComplete(Task task) {
    setState(() {
      task.completed = !task.completed;
    });
  }

  void _onTaskDelete(int taskId) {
    setState(() {
      tasks.removeWhere((item) => item.id == taskId);
    });
  }

  void _runFilter(String searchkey) {
    List<Task> results = [];

    if (searchkey.isEmpty) {
      results = tasks;
    } else {
      results = tasks
          .where((task) =>
              task.todo!.toLowerCase().contains(searchkey.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundTasks = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0x80808080),
        appBar: _appBar(context),
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 6, right: 6, top: 12, bottom: 70),
                child: Column(
                  children: [
                    // Searchbox
                    _searchBar(),
                    _todoList(),
                  ],
                ),
              ),
              bottomMenuAddTask()
            ],
          ),
        ));
  }

  Align bottomMenuAddTask() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 15, right: 20, left: 20),
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
                  controller: _taskController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Add a new task",
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  )),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15, right: 20),
            child: ElevatedButton(
              onPressed: () {
                _addTaskItem(_taskController.text);
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
          ),
        ],
      ),
    );
  }

  Container _searchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (val) => _runFilter(val),
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
            constraints: BoxConstraints(maxHeight: 60),
            filled: true,
            fillColor: Colors.grey,
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 22,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 40),
            border: InputBorder.none,
            hintText: "Search task",
            hintStyle: TextStyle(
                color: const Color.fromARGB(255, 102, 95, 95),
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      titleSpacing: 0,
      leading: Icon(
        Icons.now_widgets_rounded,
        color: Colors.white,
      ),
      title: Text(
        "Todoish",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.archive,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => CompletedTasks(
                        key: UniqueKey(),
                        completedTasks: getCompletedtasks(),
                        onTaskClick: _onTaskClick,
                        onTaskChangeComplete: _onTaskChangeComplete,
                        onTaskDelete: _onTaskDelete,
                      )),
            );
          },
        ),
      ],
    );
  }

  GestureDetector _showCaseTaskTile(
      {required GlobalKey<State<StatefulWidget>> key,
      required bool showCaseDetail,
      required BuildContext context,
      required Task task}) {
    // "Do Laundry" task tile
    int index = 0;

    // Change params for Showcase() here
    Map<String, dynamic> showcaseParams = {
      "key": key,
      "description": "Tap to complete a task",
      "tooltipPosition": TooltipPosition.top,
      "disposeOnTap": true, // Go to detail page
      "onTargetClick": () {
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (_) => TaskDetail(
                task: _foundTasks[index],
                completed: completedTasks[_foundTasks[index].id] == true),
          ),
        ).then((_) {
          List<GlobalKey<State<StatefulWidget>>> remainingShowcases =
              showcaseKeys.sublist(1, showcaseKeys.length - 1);
          setState(() {
            // Multi-page Showcasing
            // After tapping TaskTile and navigating back, we want to resume the showcase for the next parts (which are on the previous page)
            ShowCaseWidget.of(context).startShowCase(remainingShowcases);
          });
        });
      },
      "child": task,
    };

    return GestureDetector(
      onTap: () {
        Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (context) => TaskDetail(
                  task: _foundTasks[index],
                  completed: completedTasks[_foundTasks[index].id] == true),
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Showcase(
          key: showcaseParams["key"],
          description: showcaseParams["description"],
          child: showcaseParams["child"],
        ),
      ),
    );
  }

  Expanded _todoList() {
    return Expanded(
      child: ListView.separated(
        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
        reverse: false,
        itemCount: _foundTasks.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            // TODO
            // For the first Task element, we'll show the showcase onboarding
            return _showCaseTaskTile(
                key: _one_MarkCompleteSection,
                showCaseDetail: true,
                context: context,
                task: _foundTasks.first);
          }
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetail(
                        task: _foundTasks[index],
                        completed:
                            completedTasks[_foundTasks[index].id] == true),
                  ));
            },
            child: TaskRow(
              vpadding: 8,
              hpadding: 25,
              task: _foundTasks[index],
              onTaskClick: _onTaskClick,
              onTaskChangeComplete: _onTaskChangeComplete,
              onTaskDelete: _onTaskDelete,
            ),
          );
        },
        separatorBuilder: ((_, __) => Divider(
              thickness: .5,
              height: 2,
              color: Colors.black,
            )),
      ),
    );
  }
}
