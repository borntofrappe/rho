import 'package:flutter/material.dart';

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
    List<Map> _tasks = [
      {
        'task': 'Research',
        'subtasks': [
          'ExpansionTile',
          'AnimatedRotation',
        ],
      },
      {
        'task': 'Dawdle',
      },
      {
        'task': 'git',
        'subtasks': [
          'add',
          'push',
          'commit',
        ],
      }
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
                itemBuilder: (BuildContext context, int index) => Tile(
                  task: _tasks[index]['task'],
                  subtasks: _tasks[index]['subtasks'] ?? [],
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

class Tile extends StatefulWidget {
  final String task;
  final List<String> subtasks;
  final bool expanded;

  const Tile({
    Key? key,
    required this.task,
    this.subtasks = const [],
    this.expanded = false,
  }) : super(key: key);

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
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
    List<String> subtasks = widget.subtasks;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: subtasks.isEmpty
          ? ListTile(
              leading: const Icon(
                Icons.crop_square_outlined,
                color: Colors.black38,
              ),
              title: Text(
                widget.task,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            )
          : ExpansionTile(
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
                  widget.task,
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
                    '${subtasks.length}',
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
              children: subtasks
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
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _expanded = expanded;
                });
              },
            ),
    );
  }
}
