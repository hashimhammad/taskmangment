import 'package:finalapp/services/task_stoarage.dart';

import '../models/task_model.dart';

class TaskController {
  List<Task> tasks = [];

  Future<void> loadTasks() async {
    tasks = await TaskStorage.load();
  }

  Future<void> saveTasks() async {
    await TaskStorage.save(tasks);
  }

  void addTask(String title) {
    tasks.add(Task(title: title));
  }

  void toggleTask(int index) {
    tasks[index].isDone = !tasks[index].isDone;
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
  }
}
