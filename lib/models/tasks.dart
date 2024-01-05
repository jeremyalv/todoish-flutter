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
        id: 1,
        todo: "Custom Todo",
        completed: false,
        userId: 1,
      ),
      Task(
        id: 2,
        todo: "Custom Todo #2",
        completed: true,
        userId: 1,
      ),
      Task(
        id: 3,
        todo: "Custom Todo #3",
        completed: false,
        userId: 1,
      ),
      Task(
        id: 4,
        todo: "Custom Todo #4",
        completed: false,
        userId: 1,
      ),
    ];
  }
}
