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
      body: List(),
    );
  }
}

class List extends StatefulWidget {
  const List({Key? key}) : super(key: key);

  @override
  State<List> createState() => _ListState();
}

class _ListState extends State<List> {
  final _items = [1, 2, 3, 4, 5, 6, 7];
  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      padding: const EdgeInsets.all(16.0),
      buildDefaultDragHandles: false,
      proxyDecorator: (Widget child, int index, Animation<double> animation) =>
          Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey[400]!,
            blurRadius: animation.value * 20,
            spreadRadius: -10.0,
            offset: const Offset(0, 0),
          )
        ]),
        child: child,
      ),
      onReorder: (int oldIndex, int newIndex) {
        int index = oldIndex < newIndex ? newIndex - 1 : oldIndex;
        setState(() {
          final int item = _items.removeAt(oldIndex);
          _items.insert(index, item);
        });
      },
      children: [
        for (final item in _items)
          Container(
            key: Key('${_items.indexOf(item)}'),
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: ReorderableDragStartListener(
                index: _items.indexOf(item),
                child: ListTile(
                  leading: const Icon(Icons.circle_outlined),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  title: Text('Item #$item'),
                ),
              ),
            ),
          )
      ],
    );
  }
}
