import 'package:flutter/material.dart';
import 'package:rho/widgets/empty_state.dart';
import 'package:rho/widgets/text_input.dart';
import 'package:rho/helpers/task.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Task> _tasks = [];
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();

  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _hasFocus = false;

  void _removeTaskAt(int index) {
    Task task = _tasks.removeAt(index);
    _listKey.currentState!.removeItem(
      index,
      (BuildContext context, Animation<double> animation) => AnimatedItem(
        animation: animation,
        isLast: index < _tasks.length - 1,
        title: task.title,
      ),
    );

    // rebuild the widget to show the empty state
    if (_tasks.isEmpty) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {});
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();

    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              trailing: Image.asset('assets/icon.png'),
            ),
            if (_tasks.isEmpty)
              const Expanded(
                child: Center(
                  child: EmptyState(
                    text: 'No tasks here yet',
                  ),
                ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomScrollView(
                  slivers: [
                    CustomSliverList(
                      tasks: _tasks,
                      listKey: _listKey,
                      removeTaskAt: _removeTaskAt,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _hasFocus
          ? null
          : FloatingActionButton(
              elevation: 0.0,
              focusElevation: 0.0,
              hoverElevation: 0.0,
              highlightElevation: 0.0,
              foregroundColor: Theme.of(context).colorScheme.background,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(
                Icons.add,
              ),
              onPressed: () {
                showGeneralDialog(
                  barrierDismissible: true,
                  barrierLabel: 'Go back to home screen',
                  context: context,
                  transitionBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation,
                          Widget child) =>
                      SlideTransition(
                    child: child,
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 1.0),
                      end: Offset.zero,
                    ).animate(animation),
                  ),
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) =>
                      Dialog(
                    alignment: Alignment.bottomCenter,
                    insetPadding: EdgeInsets.zero,
                    elevation: 0.0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                      ),
                    ),
                    child: TextInput(
                      controller: _controller,
                      focusNode: _focusNode,
                      onSubmit: (String text) {
                        int index = 0;

                        _tasks.insert(
                          index,
                          Task(
                            title: text,
                          ),
                        );

                        _listKey.currentState!.insertItem(index);

                        _controller.clear();
                        _focusNode.unfocus();

                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class CustomSliverList extends StatelessWidget {
  final List<Task> tasks;
  final GlobalKey<SliverAnimatedListState> listKey;
  final Function(int) removeTaskAt;

  const CustomSliverList({
    Key? key,
    required this.tasks,
    required this.listKey,
    required this.removeTaskAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedList(
      key: listKey,
      initialItemCount: tasks.length,
      itemBuilder:
          (BuildContext context, int index, Animation<double> animation) =>
              AnimatedItem(
        animation: animation,
        isLast: index < tasks.length - 1,
        title: tasks[index].title,
        onTap: () {
          removeTaskAt(index);
        },
      ),
    );
  }
}

class AnimatedItem extends StatelessWidget {
  final bool isLast;
  final Animation<double> animation;
  final String title;
  final VoidCallback? onTap;

  const AnimatedItem({
    Key? key,
    required this.isLast,
    required this.animation,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Animation<Offset> position = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(animation);

    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: position,
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 10.0 : 0.0),
            child: Item(
              title: title,
              onTap: onTap,
            ),
          ),
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const Item({Key? key, required this.title, this.onTap}) : super(key: key);

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
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        trailing: GestureDetector(
          onTap: onTap,
          child: const Icon(
            Icons.delete_forever_rounded,
            color: Colors.black45,
          ),
        ),
      ),
    );
  }
}
