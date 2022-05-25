import 'package:flutter/material.dart';
import 'package:rho/widgets/empty_state.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xfffefefe),
      body: Center(
        child: EmptyState(),
      ),
    );
  }
}
