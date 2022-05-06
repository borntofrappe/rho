import 'package:flutter/material.dart';

class Task {
  String title;
  bool completed;

  Task({
    required this.title,
    this.completed = false,
  });
}

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Task> _tasks = [
      Task(
        title: 'Research',
      ),
      Task(title: 'Dawdle', completed: true),
      Task(
        title: 'git',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xffefefef),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400.0),
            child: ListView.separated(
              itemCount: _tasks.length,
              itemBuilder: (BuildContext context, int index) => TaskItem(
                task: _tasks[index],
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;
  const TaskItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: TaskTile(
        leading: task.completed
            ? Icon(
                Icons.check_box_rounded,
                color: Theme.of(context).primaryColor,
              )
            : const Icon(
                Icons.check_box_outline_blank_rounded,
                color: Colors.black38,
              ),
        title: Text(
          task.title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  final Widget title;
  final Widget leading;

  const TaskTile({
    Key? key,
    required this.title,
    required this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title,
    );
  }
}
