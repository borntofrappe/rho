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
      home: Scaffold(
        body: Center(
          child: EmptyState(),
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  final Color boxColor;

  const EmptyState({
    Key? key,
    this.text = 'No tasks here yet',
    this.icon = Icons.checklist_rounded,
    this.iconColor = Colors.white,
    this.boxColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double offset = 16.0;
    double opacity = 0.3;

    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(12.0));

    Widget box = Opacity(
      opacity: opacity,
      child: Container(
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: borderRadius,
        ),
      ),
    );

    Widget foreground = Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 28.0),
      child: Icon(
        icon,
        size: 42.0,
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
              child: box,
            ),
            Positioned.fill(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5,
                    sigmaY: 5,
                  ),
                  child: box,
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