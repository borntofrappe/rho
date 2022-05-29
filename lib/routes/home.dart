import 'package:flutter/material.dart';
import 'package:rho/widgets/empty_state.dart';
import 'package:rho/widgets/text_input.dart';
import 'package:rho/helpers/task.dart';
import 'package:rho/widgets/tasks.dart';

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
  late TextEditingController _controller;
  late FocusNode _focusNode;

  bool _visible = false;
  final List<Task> _tasks = <Task>[];
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  void _addTask(String text) {
    _tasks.insert(0, Task(title: text));
    _listKey.currentState?.insertItem(0);

    setState(() {
      _visible = _tasks.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _tasks.isEmpty
                  ? const EmptyState()
                  : CustomScrollView(
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
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: _focusNode.hasFocus
          ? null
          : FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.add),
              onPressed: () {
                showGeneralDialog(
                  barrierDismissible: true,
                  barrierLabel: 'Go back to tasks',
                  context: context,
                  transitionBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, 1.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 350),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return Dialog(
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
                          _addTask(text);
                          _controller.clear();
                          _focusNode.unfocus();

                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
