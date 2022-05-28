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
    List<Task> tasks = <Task>[
      Task(title: 'Research AnimatedSliverList'),
      Task(title: 'Implement SliverList'),
      Task(title: 'Design task item', completed: true),
      Task(title: 'Complete sliver list workshop', completed: true),
    ];

    return Scaffold(
      backgroundColor: const Color(0xffefefef),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) => TaskTile(
                task: tasks[index],
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 16.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({
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
      child: ListTile(
        onTap: () {
          print('This is where you\'d edit the task');
        },
        onLongPress: () {
          print('This is where you\'d select the task, possibly to delete');
        },
        leading: task.completed
            ? GestureDetector(
                onTap: () {
                  print('This is where you\'d un-check the task');
                },
                child: const Icon(
                  Icons.check_box_rounded,
                  color: Colors.amber,
                ),
              )
            : GestureDetector(
                onTap: () {
                  print('This is where you\'d check the task');
                },
                child: const Icon(
                  Icons.check_box_outline_blank_rounded,
                  color: Colors.black38,
                ),
              ),
        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: task.completed ? Colors.black45 : Colors.black87,
            decoration: task.completed ? TextDecoration.lineThrough : null,
          ),
        ),
      ),
    );
  }
}
