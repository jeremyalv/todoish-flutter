 // For remote API call
  // FutureBuilder<Object?> _futureTasksBuilder(Future<List<Task>> futureTasks) {
  //   return FutureBuilder(
  //       future: futureTasks,
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           List<Task> tasks = snapshot.data as List<Task>;

  //           return ListView.separated(
  //             itemCount: tasks.length,
  //             itemBuilder: (context, index) {
  //               return GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) => TaskDetail(
  //                             task: tasks[index],
  //                             completed:
  //                                 completedTasks[tasks[index].id] == true),
  //                       ));
  //                 },
  //                 child: TaskRow(
  //                   task: tasks[index],
  //                   onTaskClick: _onTaskClick,
  //                   onTaskChangeComplete: _onTaskChangeComplete,
  //                   onTaskDelete: _onTaskDelete,
  //                 ),
  //               );

  //               // return GestureDetector(
  //               //     child: taskTile(context, tasks, index));
  //             },
  //             separatorBuilder: ((_, __) => Divider(
  //                   thickness: .5,
  //                   height: 20,
  //                   color: Colors.black,
  //                 )),
  //           );
  //         }
  //         if (snapshot.hasError) {
  //           return Text(
  //             "Oops, an error happened: ${snapshot.error}",
  //           );
  //         }

  //         return Center(
  //           child:
  //               Column(mainAxisAlignment: MainAxisAlignment.center, children: [
  //             CircularProgressIndicator(),
  //             SizedBox(height: 10),
  //             Text(
  //               "Loading tasks...",
  //               style: TextStyle(color: Colors.white),
  //             ),
  //           ]),
  //         );
  //       });
  // }