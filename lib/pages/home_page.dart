// ignore_for_file: prefer_const_constructors, slash_for_doc_comments, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import 'package:todoish/models/tasks.dart';
import 'package:todoish/pages/task_detail.dart';
import 'package:todoish/pages/completed_tasks.dart';
import 'package:todoish/components/task_row.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FocusNode _focusNewTaskField = FocusNode();

  // Set to TRUE to activate auto onboarding when starting app
  final bool _autoOnboarding = false;

  final Map<int, bool> _completedTasks = {};
  final List<Task> _tasks = Task.getDummyTasks();

  List<Task> _foundTasks = [];

  // Onboarding: ShowCase section keys
  final GlobalKey _one_MarkCompleteSection = GlobalKey();
  final GlobalKey _two_DeleteTaskSection = GlobalKey();
  final GlobalKey _three_SearchTaskSection = GlobalKey();
  final GlobalKey _four_TypeNewTaskSection = GlobalKey();
  final GlobalKey _five_ClickAddTaskSection = GlobalKey();
  final GlobalKey _six_ViewTaskDetailsSection = GlobalKey();
  final GlobalKey _seven_ViewCompletedTasksSection = GlobalKey();

  List<GlobalKey> _showcaseKeys = [];

  // Controllers
  final _newTaskNameController = TextEditingController();
  final _searchQueryController = TextEditingController();
  final _scrollController = ScrollController();

  // WIDGET LIFECYCLE METHODS
  @override
  void initState() {
    super.initState();

    _focusNewTaskField.addListener(_onNewTaskFieldFocusChange);
    _foundTasks = _tasks;

    // At construct time, fill showcaseKeys
    _showcaseKeys = [
      _one_MarkCompleteSection,
      _two_DeleteTaskSection,
      _three_SearchTaskSection,
      _four_TypeNewTaskSection,
      _five_ClickAddTaskSection,
      _six_ViewTaskDetailsSection,
      _seven_ViewCompletedTasksSection,
    ];

    if (_autoOnboarding) _startOnboarding(context, _showcaseKeys);
  }

  @override
  void dispose() {
    // Dispose controllers
    _scrollController.dispose();
    _searchQueryController.dispose();
    _newTaskNameController.dispose();

    // Dispose focus
    _focusNewTaskField.removeListener(_onNewTaskFieldFocusChange);
    _focusNewTaskField.dispose();
    super.dispose();
  }

  // WIDGET HELPER METHODS
  void _startOnboarding(BuildContext context,
      List<GlobalKey<State<StatefulWidget>>> showcaseKeys) {
    // Begin onboarding immediately after app starts
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      return ShowCaseWidget.of(context).startShowCase(showcaseKeys);
    });
  }

  void _clearSearch() {
    _searchQueryController.clear();

    setState(() {
      _foundTasks = _tasks;
    });
  }

  void _onNewTaskFieldFocusChange() {
    debugPrint("Focus ${_focusNewTaskField.hasFocus.toString()}");
  }

  List<Task> getCompletedtasks() {
    return _tasks.where((task) => task.completed == true).toList();
  }

  void _addTaskItem(String todo) {
    setState(() {
      Task newTask = Task(
        id: _tasks[_tasks.length - 1].id + 1,
        todo: todo,
        completed: false,
        userId: 1,
      );

      _tasks.insert(0, newTask);
    });

    _newTaskNameController.clear();
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
      _tasks.removeWhere((item) => item.id == taskId);
    });
  }

  void _runFilter(String searchkey) {
    List<Task> results = [];

    if (searchkey.isEmpty) {
      results = _tasks;
    } else {
      results = _tasks
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
                    Showcase(
                      key: _three_SearchTaskSection,
                      title: "Search Task",
                      description: "Start typing here to filter and find tasks",
                      targetBorderRadius: BorderRadius.all(Radius.circular(20)),
                      child: _searchBar(),
                    ),
                    _todoList(),
                  ],
                ),
              ),
              bottomMenuAddTask()
            ],
          ),
        ));
  }

  Container _searchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 22, 19, 19).withOpacity(0.20),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ]),
      child: TextField(
        controller: _searchQueryController,
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
            suffixIcon: Container(
              width: 100,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const VerticalDivider(
                      color: Colors.black,
                      indent: 10,
                      endIndent: 10,
                      thickness: 0.2,
                    ),
                    GestureDetector(
                      onTap: _clearSearch,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.cancel,
                          color: Color.fromARGB(255, 128, 128, 128),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
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
      leading: GestureDetector(
        onTap: () {
          setState(() {
            _scrollController.jumpTo(0);
            ShowCaseWidget.of(context).startShowCase(_showcaseKeys);
          });
        },
        child: Icon(
          // Todoish placeholder icon
          // Onboarding: Manually trigger onboarding when clicking the icon
          Icons.now_widgets_rounded,
          color: Colors.white,
        ),
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

  Container _showCaseTaskTile({
    required GlobalKey<State<StatefulWidget>> globalKey,
    required BuildContext context,
    required Task task,
    required int taskIndex,
    required bool showCaseComplete,
    required bool showCaseDelete,
  }) {
    // Change params for Showcase() here
    // Map<String, dynamic> params = {
    //   "onTargetClick": () {
    //     // TODO ini harusnya disesuaikan dengan showcase yang mengharuskan klik details TaskTile
    //     Navigator.push<void>(
    //       context,
    //       MaterialPageRoute<void>(
    //         builder: (_) => TaskDetail(
    //             task: _foundTasks[taskIndex],
    //             completed: completedTasks[_foundTasks[taskIndex].id] == true),
    //       ),
    //     ).then((_) {
    //       // Continue the remaining showcases from showcase index 2 to end
    //       List<GlobalKey<State<StatefulWidget>>> remainingShowcases =
    //           showcaseKeys.sublist(1, showcaseKeys.length - 1);
    //       setState(() {
    //         // Multi-page Showcasing
    //         // After tapping TaskTile and navigating back, we want to resume the showcase for the next parts (which are on the previous page)
    //         ShowCaseWidget.of(context).startShowCase(remainingShowcases);
    //       });
    //     });
    //   },
    // };
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: TaskRow(
        task: task,
        showCaseKey: globalKey,
        showcaseComplete: showCaseComplete,
        showcaseDelete: showCaseDelete,
        vpadding: 8,
        hpadding: 25,
        onTaskClick: _onTaskClick,
        onTaskChangeComplete: _onTaskChangeComplete,
        onTaskDelete: _onTaskDelete,
      ),
    );
  }

  Expanded _todoList() {
    return Expanded(
      child: ListView.separated(
        controller: _scrollController,
        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
        reverse: false,
        itemCount: _foundTasks.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            // For the first Task element, we'll show the showcase step #1 (Complete)
            return _showCaseTaskTile(
              globalKey: _one_MarkCompleteSection,
              showCaseComplete: true,
              showCaseDelete: false,
              context: context,
              taskIndex: index,
              task: _foundTasks[index],
            );
          } else if (index == 1) {
            // For the second Task element, we'll show the showcase step #2 (Delete)
            return _showCaseTaskTile(
              globalKey: _two_DeleteTaskSection,
              showCaseComplete: false,
              showCaseDelete: true,
              context: context,
              taskIndex: index,
              task: _foundTasks[index],
            );
          }
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetail(
                        task: _foundTasks[index],
                        completed:
                            _completedTasks[_foundTasks[index].id] == true),
                  ));
            },
            child: TaskRow(
              vpadding: 8,
              hpadding: 25,
              task: _foundTasks[index],
              showCaseKey: null,
              showcaseComplete: false,
              showcaseDelete: false,
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

  Align bottomMenuAddTask() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: Showcase(
              key: _four_TypeNewTaskSection,
              title: "Adding Tasks",
              description: "Type a new todo",
              targetBorderRadius: BorderRadius.all(Radius.circular(20)),
              targetPadding: EdgeInsets.only(
                top: 10,
              ),
              child: _addTaskTextField(),
            ),
          ),
          Showcase(
            key: _five_ClickAddTaskSection,
            title: "Adding Tasks",
            description: "Insert the new task to your list",
            targetBorderRadius: BorderRadius.all(Radius.circular(50)),
            targetPadding: EdgeInsets.only(
              top: 10,
              left: 15,
            ),
            child: _addTaskToList(),
          ),
        ],
      ),
    );
  }

  Container _addTaskTextField() {
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
          focusNode: _focusNewTaskField,
          controller: _newTaskNameController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Add a new task",
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          )),
    );
  }

  Container _addTaskToList() {
    return Container(
      margin: EdgeInsets.only(bottom: 10, right: 15),
      child: ElevatedButton(
        onPressed: () {
          _addTaskItem(_newTaskNameController.text);
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
