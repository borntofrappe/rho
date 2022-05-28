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
  bool _expanded = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      _expanded = widget.expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = <Task>[
      Task(title: 'Research AnimatedSliverList'),
      Task(title: 'Implement SliverList', completed: true),
      Task(title: 'Design task item', completed: true),
      Task(title: 'Complete sliver list workshop', completed: true),
    ];

    List<Task> completedTasks =
        tasks.where((Task task) => task.completed).toList();

    return Scaffold(
      backgroundColor: const Color(0xffefefef),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomScrollView(
              slivers: [
                Tasks(
                  tasks: tasks.where((Task task) => !task.completed).toList(),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 16.0),
                  sliver: SliverToBoxAdapter(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                      ),
                      child: ListTile(
                        minLeadingWidth: 0.0,
                        onTap: () {
                          setState(() {
                            _expanded = !_expanded;
                          });
                        },
                        leading: AnimatedRotation(
                          duration: const Duration(milliseconds: 200),
                          turns: _expanded ? 0.5 : 0.0,
                          child: const Icon(
                            Icons.keyboard_arrow_up_rounded,
                            color: Colors.black45,
                          ),
                        ),
                        title: Text(
                          'Completed ${completedTasks.length} tasks',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverVisibility(
                  visible: _expanded,
                  sliver: Tasks(
                    tasks: completedTasks,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Tasks extends StatelessWidget {
  final List<Task> tasks;

  const Tasks({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index.isEven) {
            return TaskTile(
              task: tasks[index ~/ 2],
            );
          }
          return const SizedBox(
            height: 16.0,
          );
        },
        childCount: (tasks.length * 2 - 1),
        semanticIndexCallback: (Widget widget, int localIndex) {
          if (localIndex.isEven) {
            return localIndex ~/ 2;
          }
          return null;
        },
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
