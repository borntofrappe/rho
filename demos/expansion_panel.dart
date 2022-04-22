import 'package:flutter/material.dart';

class Task {
  String task;
  List<String> subtasks;
  bool isExpanded;

  Task({
    required this.task,
    this.subtasks = const [],
    this.isExpanded = false,
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
        task: 'Research',
        subtasks: [
          'ExpansionPanel',
        ],
        isExpanded: true,
      ),
      Task(
        task: 'Dawdle',
      ),
      Task(
        task: 'git',
        subtasks: [
          'add',
          'push',
          'commit',
        ],
        isExpanded: false,
      ),
    ];
    return Scaffold(
      backgroundColor: const Color(0xffefefef),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400.0),
            child: PanelList(
              tasks: _tasks,
            ),
          ),
        ),
      ),
    );
  }
}

class PanelList extends StatefulWidget {
  final List<Task> tasks;
  const PanelList({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  @override
  State<PanelList> createState() => _PanelListState();
}

class _PanelListState extends State<PanelList> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      _tasks = widget.tasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: (int panelIndex, bool isExpanded) {
          setState(() {
            _tasks[panelIndex].isExpanded = !isExpanded;
          });
        },
        expandedHeaderPadding: EdgeInsets.zero,
        elevation: 0.0,
        dividerColor: null,
        children: _tasks
            .map((task) => ExpansionPanel(
                  isExpanded: task.isExpanded,
                  headerBuilder: (BuildContext context, bool isExpanded) =>
                      ListTile(
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
                      child: Text(
                        task.task,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    trailing: Text(
                      '${task.subtasks.length}',
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      children: task.subtasks
                          .map(
                            (subtask) => ListTile(
                              leading: const Icon(
                                Icons.crop_square_outlined,
                                color: Colors.black38,
                              ),
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
                  ),
                ))
            .toList(),
      ),
    );
  }
}
