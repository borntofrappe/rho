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
      home: Home(
        expanded: true,
      ),
    );
  }
}

class Home extends StatefulWidget {
  final bool expanded;
  const Home({
    Key? key,
    this.expanded = false,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Task> _tasks = <Task>[];
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();

  bool _visible = false;

  int _counter = 0;

  void _addTask() {
    _counter++;

    _tasks.insert(
      0,
      Task(title: 'Task # ${_counter.toString()}'),
    );
    _listKey.currentState?.insertItem(0);

    setState(() {
      _visible = _tasks.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffefefef),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomScrollView(
              slivers: [
                SliverAnimatedOpacity(
                  opacity: _visible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 250),
                  sliver: Tasks(
                    tasks: _tasks,
                    listKey: _listKey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: _addTask,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class Tasks extends StatelessWidget {
  final List<Task> tasks;
  final GlobalKey<SliverAnimatedListState> listKey;

  const Tasks({
    Key? key,
    required this.tasks,
    required this.listKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedList(
      key: listKey,
      itemBuilder:
          (BuildContext context, int index, Animation<double> animation) {
        return SizeTransition(
          axisAlignment: -1.0,
          sizeFactor: animation,
          child: Container(
            margin:
                EdgeInsets.only(bottom: index < tasks.length - 1 ? 16.0 : 0.0),
            child: TaskTile(
              task: tasks[index],
            ),
          ),
        );
      },
      initialItemCount: tasks.length,
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
