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
}
