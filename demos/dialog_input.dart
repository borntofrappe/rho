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

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _hasFocus = false;

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
      backgroundColor: const Color(0xffefefef),
      floatingActionButton: _hasFocus
          ? null
          : FloatingActionButton(
              child: const Icon(
                Icons.add,
              ),
              onPressed: () {
                showGeneralDialog(
                  barrierDismissible: true,
                  barrierLabel: 'Go back to tasks',
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
                        print(text);

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

class TextInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onSubmit;

  const TextInput({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool _isEmpty = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      _isEmpty = widget.controller.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 420.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 4.0),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: widget.controller,
                focusNode: widget.focusNode,
                onChanged: (String text) {
                  setState(() {
                    _isEmpty = widget.controller.text.isEmpty;
                  });
                },
                onFieldSubmitted: (String text) {
                  if (text.isNotEmpty) {
                    widget.onSubmit(text);
                  }
                },
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.check_box_outline_blank_rounded,
                    color: Colors.black45,
                    size: 24.0,
                  ),
                  hintText: 'Create task',
                  hintStyle: TextStyle(color: Colors.black45),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _isEmpty
                        ? null
                        : () {
                            widget.onSubmit(widget.controller.text);
                          },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
