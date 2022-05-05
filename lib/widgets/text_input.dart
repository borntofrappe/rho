import 'package:flutter/material.dart';

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
                textCapitalization: TextCapitalization.sentences,
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
                        fontWeight: FontWeight.w700,
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
