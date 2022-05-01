import 'package:flutter/material.dart';
import 'dart:ui';

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
      body: Center(
        child: EmptyState(),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  final Color glassColor;

  const EmptyState({
    Key? key,
    this.text = 'No tasks here yet',
    this.icon = Icons.checklist_rounded,
    this.iconColor = Colors.white,
    this.glassColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double offset = 14.0;
    double opacity = 0.25;

    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(14.0));

    Widget background = Opacity(
      opacity: opacity,
      child: Container(
        decoration: BoxDecoration(
          color: glassColor,
          borderRadius: borderRadius,
        ),
      ),
    );

    Widget foreground = Padding(
      padding: const EdgeInsets.all(24.0),
      child: Icon(
        icon,
        size: 38.0,
        color: iconColor,
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: offset),
          child: Stack(clipBehavior: Clip.none, children: <Widget>[
            Positioned(
              left: offset * -1,
              bottom: offset * -1,
              top: offset,
              right: offset,
              child: background,
            ),
            Positioned.fill(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5,
                    sigmaY: 5,
                  ),
                  child: background,
                ),
              ),
            ),
            foreground
          ]),
        ),
        const SizedBox(height: 16.0),
        Text(text),
      ],
    );
  }
}
