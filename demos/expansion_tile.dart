import 'package:flutter/material.dart';

class Task {
  String title;
  List<String> subtasks;

  Task({
    required this.title,
    this.subtasks = const [],
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
        subtasks: [
          'ExpansionTile',
          'AnimatedRotation',
        ],
      ),
      Task(
        title: 'Dawdle',
      ),
      Task(
        title: 'git',
        subtasks: [
          'add',
          'push',
          'commit',
        ],
      ),
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
      child: task.subtasks.isEmpty
          ? TaskTile(
              title: Text(
                task.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            )
          : TaskExpansionTile(
              title: task.title,
              children: task.subtasks
                  .map(
                    (subtask) => TaskTile(
                      title: Text(
                        subtask,
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}

class TaskTile extends StatelessWidget {
  final Widget title;
  const TaskTile({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        onTap: () {
          print('Check task');
        },
        child: const Icon(
          Icons.crop_square_outlined,
          color: Colors.black38,
        ),
      ),
      title: GestureDetector(
          onTap: () {
            print('Edit task');
          },
          child: title),
    );
  }
}

class TaskExpansionTile extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final bool expanded;
  const TaskExpansionTile({
    Key? key,
    required this.title,
    required this.children,
    this.expanded = false,
  }) : super(key: key);

  @override
  State<TaskExpansionTile> createState() => _TaskExpansionTileState();
}

class _TaskExpansionTileState extends State<TaskExpansionTile> {
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
    return ExpansionTile(
      childrenPadding: const EdgeInsets.only(left: 16.0),
      leading: GestureDetector(
        onTap: () {
          print('Check task');
        },
        child: const Icon(
          Icons.crop_square_outlined,
          color: Colors.black38,
        ),
      ),
      title: GestureDetector(
        onTap: () {
          print('Edit Task');
        },
        child: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${widget.children.length}',
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          AnimatedRotation(
            duration: const Duration(milliseconds: 200),
            turns: _expanded ? 0.5 : 0.0,
            child: Container(
              padding: const EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(
                  24.0,
                ),
              ),
              child: const Icon(
                Icons.keyboard_arrow_up_rounded,
                color: Colors.black38,
                size: 24.0,
              ),
            ),
          ),
        ],
      ),
      children: widget.children,
      initiallyExpanded: widget.expanded,
      onExpansionChanged: (bool expanded) {
        setState(() {
          _expanded = expanded;
        });
      },
    );
  }
}
