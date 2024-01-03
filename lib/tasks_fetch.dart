import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todoish/tasks.dart';

const baseUrl = "https://dummyjson.com/todos";

Future<List<Task>> fetchTasks() async {
  try {
    final response = await http.get(Uri.parse(baseUrl));
    final requestSuccessful = response.statusCode == 200;

    if (requestSuccessful) {
      var tasksJson = jsonDecode(response.body)["todos"] as List<dynamic>;

      return tasksJson
          .map((t) => Task(
                id: t["id"],
                todo: t["todo"],
                completed: t["completed"],
                userId: t["userId"],
              ))
          .toList();
    }
    return [];
  } catch (exception) {
    print(exception);
    return [];
  }
}
