class Task {
  int id;
  String todo;
  bool completed;
  int userId;

  Task({
    required this.id,
    required this.todo,
    this.completed = false,
    required this.userId,
  });

  static List<Task> getDummyTasks() {
    return [
      Task(
        id: 1000,
        todo: "Custom Todo",
        completed: false,
        userId: 1,
      ),
      Task(
        id: 1001,
        todo: "Custom Todo #2",
        completed: false,
        userId: 1,
      ),
      Task(
        id: 1002,
        todo: "Custom Todo #3",
        completed: false,
        userId: 1,
      ),
    ];
  }
}
