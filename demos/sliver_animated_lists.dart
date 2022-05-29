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
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Task> _tasks = <Task>[];
  final List<Task> _completed = <Task>[];
  final GlobalKey<SliverAnimatedListState> _listKeyTasks =
      GlobalKey<SliverAnimatedListState>();
  final GlobalKey<SliverAnimatedListState> _listKeyCompleted =
      GlobalKey<SliverAnimatedListState>();

  bool _visibleTasks = false;
  bool _visibleCompleted = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      _visibleTasks = _tasks.isNotEmpty;
      _visibleCompleted = _completed.isNotEmpty;
    });
  }

  int _counter = 0;

  void _addTask() {
    _counter++;

    _tasks.insert(
      0,
      Task(title: 'Task # ${_counter.toString()}'),
    );
    _listKeyTasks.currentState?.insertItem(0);

    setState(() {
      _visibleTasks = _tasks.isNotEmpty;
    });
  }

  void _checkTask(Task task) {
    if (!task.completed) {
      int index = _tasks.indexOf(task);

      Task complete = _tasks.removeAt(
        index,
      );

      complete.completed = true;

      _listKeyTasks.currentState?.removeItem(
          index,
          ((BuildContext context, Animation<double> animation) =>
              _getTransitionTask(context, animation, complete)));

      _completed.insert(
        0,
        complete,
      );
      _listKeyCompleted.currentState?.insertItem(0);

      setState(() {
        _visibleTasks = _tasks.isNotEmpty;
        _visibleCompleted = _completed.isNotEmpty;
      });
    } else {
      int index = _completed.indexOf(task);

      Task unfinished = _completed.removeAt(
        index,
      );

      unfinished.completed = false;

      _listKeyCompleted.currentState?.removeItem(
          index,
          ((BuildContext context, Animation<double> animation) =>
              _getTransitionTask(context, animation, unfinished)));

      _tasks.insert(
        0,
        unfinished,
      );
      _listKeyTasks.currentState?.insertItem(0);

      setState(() {
        _visibleTasks = _tasks.isNotEmpty;
        _visibleCompleted = _completed.isNotEmpty;
      });
    }
  }

  Widget _getTransitionTask(
      BuildContext context, Animation<double> animation, Task task) {
    return SizeTransition(
      axisAlignment: -1.0,
      sizeFactor: animation,
      child: TaskTile(
        task: task,
      ),
    );
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
                  opacity: _visibleTasks ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 250),
                  sliver: Tasks(
                    tasks: _tasks,
                    listKey: _listKeyTasks,
                    checkTask: _checkTask,
                  ),
                ),
                SliverAnimatedOpacity(
                  opacity: _visibleCompleted ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 250),
                  sliver: SliverPadding(
                    padding: const EdgeInsets.only(top: 16.0),
                    sliver: SliverToBoxAdapter(
                      child: ListTile(
                        minLeadingWidth: 0.0,
                        title: Text(
                          'Completed ${_completed.length} tasks',
                          style: const TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverAnimatedOpacity(
                    opacity: _visibleCompleted ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 250),
                    sliver: Tasks(
                      tasks: _completed,
                      listKey: _listKeyCompleted,
                      checkTask: _checkTask,
                    )),
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
  final Function checkTask;

  const Tasks({
    Key? key,
    required this.tasks,
    required this.listKey,
    required this.checkTask,
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
              checkTask: checkTask,
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
  final Function? checkTask;

  const TaskTile({
    Key? key,
    required this.task,
    this.checkTask,
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
        leading: GestureDetector(
          onTap: () {
            if (checkTask != null) {
              checkTask!(task);
            }
          },
          child: task.completed
              ? const Icon(
                  Icons.check_box_rounded,
                  color: Colors.amber,
                )
              : const Icon(
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
