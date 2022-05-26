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
    return const Scaffold(
      backgroundColor: Color(0xffefefef),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: TextInput(),
      ),
    );
  }
}

class TextInput extends StatefulWidget {
  const TextInput({Key? key}) : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isEmpty = true;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
    _focusNode = FocusNode();

    _controller.addListener(() {
      setState(() {
        _isEmpty = _controller.text.isEmpty;
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
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 420.0,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 8.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                cursorColor: Colors.amber,
                controller: _controller,
                focusNode: _focusNode,
                textCapitalization: TextCapitalization.sentences,
                onFieldSubmitted: (String text) {
                  if (text.isNotEmpty) {
                    print(text);
                    _controller.clear();
                    _focusNode.unfocus();
                  }
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.check_box_outline_blank_rounded,
                      color: Colors.black45, size: 24.0),
                  hintText: 'Create task',
                  hintStyle: TextStyle(color: Colors.black45),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.amber,
                  ),
                  onPressed: _isEmpty
                      ? null
                      : () {
                          print(_controller.text);
                          _controller.clear();
                          _focusNode.unfocus();
                        },
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
