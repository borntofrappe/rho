import 'package:flutter/material.dart';
import 'package:rho/widgets/empty_state.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: EmptyState(
            text: 'No tasks here yet',
          ),
        ),
      ),
    );
  }
}
