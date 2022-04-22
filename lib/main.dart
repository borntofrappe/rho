import 'package:flutter/material.dart';
import 'package:rho/routes/home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.amber,
              background: Colors.white,
            ),
      ),
      home: const Home(),
    );
  }
}
