import 'package:flutter/material.dart';

class Task {
  String title;

  Task({
    required this.title,
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

class _HomeState extends State<Home> {
  int _count = 0;
  final List<Task> _tasks = [];

  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();

  void _addTask() {
    _tasks.insert(
      0,
      Task(title: 'Task #${_count++}'),
    );

    _listKey.currentState!.insertItem(0);
  }

  void _removeTask() {
    if (_tasks.isEmpty) return;

    Task task = _tasks.removeAt(0);

    _listKey.currentState!.removeItem(
      0,
      (BuildContext context, Animation<double> animation) => SizeTransition(
        sizeFactor: animation,
        child: Item(
          title: task.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('Add task'),
                        onPressed: _addTask,
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.remove),
                        label: const Text('Remove task'),
                        onPressed: _removeTask,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      CustomSliverList(
                        tasks: _tasks,
                        listKey: _listKey,
                      ),
                    ],
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

class CustomSliverList extends StatelessWidget {
  final List<Task> tasks;
  final GlobalKey<SliverAnimatedListState> listKey;

  const CustomSliverList({
    Key? key,
    required this.tasks,
    required this.listKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedList(
      key: listKey,
      initialItemCount: tasks.length,
      itemBuilder:
          (BuildContext context, int index, Animation<double> animation) =>
              SizeTransition(
        sizeFactor: animation,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: index < tasks.length - 1 ? 10.0 : 0.0),
          child: Item(
            title: tasks[index].title,
          ),
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String title;
  const Item({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
      ),
      child: ListTile(
        minLeadingWidth: 0.0,
        leading: const Icon(Icons.crop_square_outlined),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
