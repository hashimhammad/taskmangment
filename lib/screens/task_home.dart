import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';
import '../widgets/task_tile.dart';

class TaskHome extends StatefulWidget {
  const TaskHome({super.key});

  @override
  State<TaskHome> createState() => _TaskHomeState();
}

class _TaskHomeState extends State<TaskHome> {
  final TaskController _controller = TaskController();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.loadTasks().then((_) => setState(() {}));
  }

  void _addTask() {
    if (_textController.text.trim().isEmpty) return;
    setState(() {
      _controller.addTask(_textController.text.trim());
      _textController.clear();
    });
    _controller.saveTasks();
  }

  void _toggleTask(int index) {
    setState(() {
      _controller.toggleTask(index);
    });
    _controller.saveTasks();
  }

  void _deleteTask(int index) {
    setState(() {
      _controller.deleteTask(index);
    });
    _controller.saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = _controller.tasks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.task),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Enter task...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Icon(Icons.add),
                )
              ],
            ),
          ),
          Expanded(
            child: tasks.isEmpty
                ? const Center(child: Text('No tasks yet.'))
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return TaskTile(
                        task: task,
                        onToggle: () => _toggleTask(index),
                        onDelete: () => _deleteTask(index),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
