import 'package:flutter/material.dart';
import 'package:rho/widgets/empty_state.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ListTile(
              trailing: Image.asset('assets/icon.png'),
            ),
            const Expanded(
              child: Center(
                child: EmptyState(
                  text: 'No tasks here yet',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
