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

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool _expanded = false;
  final List<Task> _tasks = [
    Task(title: 'design list', completed: true),
    Task(title: 'design list items', completed: true),
    Task(title: 'research overlay widget'),
    Task(title: 'animate list items'),
    Task(title: 'watch tennis final', completed: true),
  ];

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 250),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });

    if (_expanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Task> _completed = _tasks.where((task) => task.completed).toList();

    return Scaffold(
      backgroundColor: const Color(0xffefefef),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400.0),
            child: CustomScrollView(
              slivers: [
                Tasks(
                  tasks: _tasks.where((task) => !task.completed).toList(),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 18.0),
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
                          _toggleExpanded();
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
                          'Completed ${_completed.length}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverFadeTransition(
                  opacity: _animation,
                  sliver: Tasks(
                    tasks: _completed,
                  ),
                ),
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

  const Tasks({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) => Padding(
          padding:
              EdgeInsets.only(bottom: index < tasks.length - 1 ? 10.0 : 0.0),
          child: Item(
            title: tasks[index].title,
            completed: tasks[index].completed,
          ),
        ),
        childCount: tasks.length,
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
