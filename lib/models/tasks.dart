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
    int idx = 0;
    List<Task> tasks = [
      Task(
        id: idx++,
        todo: "Do laundry",
        completed: false,
        userId: 1,
      ),
      Task(
        id: idx++,
        todo: "Clean the dishes",
        completed: true,
        userId: 1,
      ),
      Task(
        id: idx++,
        todo: "Walk the dog",
        completed: false,
        userId: 1,
      ),
      Task(
        id: idx++,
        todo: "Code login flow",
        completed: false,
        userId: 1,
      ),
      Task(
        id: idx++,
        todo: "Code auth flow",
        completed: false,
        userId: 1,
      ),
      Task(
        id: idx++,
        todo: "Water the plants",
        completed: false,
        userId: 1,
      ),
      Task(
        id: idx++,
        todo: "Buy groceries at Target",
        completed: false,
        userId: 1,
      ),
      Task(
        id: idx++,
        todo: "Buy new phone casing",
        completed: false,
        userId: 1,
      ),
      Task(
        id: idx++,
        todo: "Buy new phone casing",
        completed: false,
        userId: 1,
      ),
      Task(
        id: idx++,
        todo: "Lorem ipsum",
        completed: false,
        userId: 1,
      ),
      Task(
        id: idx++,
        todo: "Lorem ipsum",
        completed: false,
        userId: 1,
      ),
      Task(
        id: idx++,
        todo: "Lorem ipsum",
        completed: false,
        userId: 1,
      ),
      Task(
        id: idx++,
        todo: "Lorem ipsum",
        completed: false,
        userId: 1,
      ),
    ];

    return tasks;
  }
}
