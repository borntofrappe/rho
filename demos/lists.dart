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
      Task(title: 'design list', completed: true),
      Task(title: 'design list items', completed: true),
      Task(title: 'research overlay widget'),
      Task(title: 'animate list items'),
      Task(title: 'watch tennis final', completed: true),
    ];

    return Scaffold(
      backgroundColor: const Color(0xffefefef),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400.0),
            child: Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: Column(
                children: [
                  Tasks(
                    tasks: _tasks.where((task) => !task.completed).toList(),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CompletedTasks(
                    tasks: _tasks.where((task) => task.completed).toList(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Tasks extends StatelessWidget {
  final List<Task> tasks;

  const Tasks({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) => Item(
        title: tasks[index].title,
      ),
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 10.0),
    );
  }
}

class CompletedTasks extends StatefulWidget {
  final List<Task> tasks;
  final bool expanded;

  const CompletedTasks({
    Key? key,
    required this.tasks,
    this.expanded = false,
  }) : super(key: key);

  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  bool _expanded = false;

  void _setExpanded(bool expanded) {
    setState(() {
      _expanded = expanded;
    });
  }

  @override
  void initState() {
    super.initState();

    _setExpanded(widget.expanded);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: ExpansionTile(
        onExpansionChanged: (bool expanded) {
          _setExpanded(expanded);
        },
        title: Row(
          children: [
            AnimatedRotation(
              duration: const Duration(milliseconds: 200),
              turns: _expanded ? 0.5 : 0.0,
              child: const Icon(
                Icons.keyboard_arrow_up_rounded,
                color: Colors.black45,
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              'Completed ${widget.tasks.length}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black45,
                fontSize: 14.0,
              ),
            )
          ],
        ),
        trailing: const ExcludeSemantics(),
        children: [
          ListView.separated(
            shrinkWrap: true,
            itemCount: widget.tasks.length,
            itemBuilder: (BuildContext context, int index) => Item(
              title: widget.tasks[index].title,
              completed: true,
            ),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 10.0),
          )
        ],
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String title;
  final bool completed;

  const Item({
    Key? key,
    required this.title,
    this.completed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: completed ? 0.6 : 1,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        child: ListTile(
          minLeadingWidth: 0.0,
          leading: Icon(
              completed ? Icons.check_box_rounded : Icons.crop_square_outlined),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              decoration: completed ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ),
    );
  }
}
