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
        todo: "Do laundry",
        completed: false,
        userId: 1,
      ),
      Task(
        id: 2,
        todo: "Clean the dishes",
        completed: true,
        userId: 1,
      ),
      Task(
        id: 3,
        todo: "Walk the dog",
        completed: false,
        userId: 1,
      ),
      Task(
        id: 4,
        todo: "Code login flow",
        completed: false,
        userId: 1,
      ),
    ];
  }
}
