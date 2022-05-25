import 'package:flutter/material.dart';
import 'dart:ui';

class EmptyState extends StatelessWidget {
  final Text text;
  final IconData icon;
  final Color? iconColor;
  final Color? glassColor;

  const EmptyState({
    Key? key,
    this.text = const Text('No tasks here yet'),
    this.icon = Icons.checklist_rounded,
    this.iconColor,
    this.glassColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double offset = 14.0;
    double opacity = 0.25;

    BorderRadius borderRadius = const BorderRadius.all(
      Radius.circular(14.0),
    );

    Widget background = Opacity(
      opacity: opacity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: glassColor ?? Theme.of(context).colorScheme.primary,
          borderRadius: borderRadius,
        ),
      ),
    );

    Widget foreground = Padding(
      padding: const EdgeInsets.all(24.0),
      child: Icon(
        icon,
        size: 38.0,
        color: iconColor ?? Theme.of(context).colorScheme.background,
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: offset),
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
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
              foreground,
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        text,
      ],
    );
  }
}
