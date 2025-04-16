import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/task_model.dart';

class TaskStorage {
  static const _key = 'task_manager_data';

  static Future<void> save(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final data = tasks.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList(_key, data);
  }

  static Future<List<Task>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data.map((e) => Task.fromJson(jsonDecode(e))).toList();
  }
}
