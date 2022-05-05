import 'package:flutter/material.dart';
import 'package:rho/widgets/empty_state.dart';
import 'package:rho/widgets/text_input.dart';
import 'package:rho/helpers/Task.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Task> _tasks = [];

  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _hasFocus = false;

  void _addTask(String title) {
    setState(() {
      _tasks.insert(
        0,
        Task(
          title: title,
        ),
      );
    });
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index].completed = !_tasks[index].completed;
    });
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
        child: Center(
          child: Column(
            children: <Widget>[
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
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) => ListTile(
                    onTap: () => {
                      _toggleTask(index),
                    },
                    leading: Icon(
                      _tasks[index].completed
                          ? Icons.check_box_rounded
                          : Icons.check_box_outline_blank,
                    ),
                    title: Text(_tasks[index].title),
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 8.0),
                  itemCount: _tasks.length,
                ),
              ),
            ],
          ),
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
                        _addTask(text);
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
