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
  int _count = 0;
  final _items = <int>[];
  final _key = GlobalKey<AnimatedListState>();

  final Tween<Offset> _tween = Tween(
    begin: const Offset(-1, 0),
    end: Offset.zero,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _items.add(_count++);
              _key.currentState!.insertItem(_items.length - 1);
            },
          ),
          title: const Text('Add'),
        ),
        Expanded(
          child: AnimatedList(
            key: _key,
            initialItemCount: _items.length,
            itemBuilder: (BuildContext context, int index,
                    Animation<double> animation) =>
                SlideTransition(
              position: animation.drive(_tween),
              child: Item(
                  onPressed: () {
                    _items.remove(_items[index]);
                    AnimatedList.of(context).removeItem(
                      index,
                      (BuildContext context, Animation<double> animation) =>
                          SlideTransition(
                        position: animation.drive(_tween),
                        child: Item(
                          onPressed: null,
                          title: Text('Item #${_items[index]}'),
                        ),
                      ),
                    );
                  },
                  title: Text('Item #${_items[index]}')),
            ),
          ),
        ),
      ],
    );
  }
}

class Item extends StatelessWidget {
  final Widget title;
  final Function()? onPressed;

  const Item({Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: const Icon(Icons.remove),
        onPressed: onPressed,
      ),
      title: title,
    );
  }
}
