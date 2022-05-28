import 'package:flutter/material.dart';
// import 'package:rho/widgets/empty_state.dart';
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
  bool _expanded = false;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
    _focusNode = FocusNode();

    setState(() {
      _expanded = widget.expanded;
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
    List<Task> tasks = <Task>[
      Task(title: 'Research AnimatedSliverList'),
      Task(title: 'Implement SliverList', completed: true),
      Task(title: 'Design task item', completed: true),
      Task(title: 'Complete sliver list workshop', completed: true),
    ];

    List<Task> completedTasks =
        tasks.where((Task task) => task.completed).toList();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomScrollView(
                slivers: [
                  Tasks(
                    tasks: tasks.where((Task task) => !task.completed).toList(),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 16.0),
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
                            setState(() {
                              _expanded = !_expanded;
                            });
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
                            'Completed ${completedTasks.length} tasks',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverVisibility(
                    visible: _expanded,
                    sliver: Tasks(
                      tasks: completedTasks,
                    ),
                  )
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
                          print(text);
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
